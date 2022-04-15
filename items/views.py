from django.contrib import messages, auth
from django.contrib.auth.decorators import login_required
from django.contrib.auth.tokens import default_token_generator
import requests
from django.contrib.sessions.backends.db import SessionStore
from django.contrib.sites.shortcuts import get_current_site
from django.core.exceptions import ObjectDoesNotExist
from django.core.files.storage import FileSystemStorage
from django.core.mail import EmailMessage
from django.core.paginator import Paginator
from django.db.models import Q
from django.shortcuts import render, redirect, get_object_or_404
from django.template.loader import render_to_string
from django.utils.encoding import force_bytes
from django.utils.http import urlsafe_base64_encode, urlsafe_base64_decode
from django.contrib.sessions.models import Session

from .forms import RegistrationForm
from .models import *


# Create your views here.
# ADMIN
def index(req):
    phones = Smartphone.objects.all()
    laptops = Laptop.objects.all()
    return render(req, "items/home.html",
                  {'phones': phones, 'laptops': laptops})


def addAuthor(req):
    return render(req, "items/book/addAuthor.html")


def saveAuthor(req):
    if req.method == 'POST':
        author_name = req.POST['name']
        new_author = Author.objects.create(
            name=author_name
        )
        new_author.save()
        return redirect(reverse('items:addAuthorSuccess', args=(1,)))
    else:
        return render(req, 'items/error.html')


def addAuthorSuccess(req, success):
    return render(req, 'items/book/addAuthor.html', {
        'success': success
    })


def listBook(req):
    books = Book.objects.all()
    categories = Category.objects.all()

    return render(req, 'items/book/listBook.html', {
        'Books': books,
        'Categories': categories
    })


def addBook(req):
    categories = Category.objects.filter(child__isnull=True)
    authors = Author.objects.all()
    return render(req, 'items/book/addBook.html', {
        'Categories': categories,
        'Authors': authors
    })


def saveBook(req):
    if req.method == 'POST':
        name = req.POST['name']
        category_id = req.POST['category_id']
        author_id = req.POST['author']
        status = req.POST['status']
        price = req.POST['price']
        description = req.POST['description']
        slug = req.POST['slug']
        publisher = req.POST['publisher']
        pub_date = req.POST['pub_date']
        new_book = Book.objects.create(
            name=name,
            category=Category.objects.get(pk=category_id),
            author=Author.objects.get(pk=author_id),
            status=status,
            slug=slug,
            price=price,
            description=description,
            publisher=publisher,
            publication_date=pub_date
        )
        new_book.save()
        fs = FileSystemStorage()
        if req.FILES.getlist('image'):
            for file in req.FILES.getlist('image'):
                f = fs.save(file.name, file)
                f_url = fs.url(f)
                image = ProductImage.objects.create(
                    image=f_url,
                    product=new_book
                )
                image.save()
        return redirect(reverse('items:addBookSuccess', args=(1,)))
    else:
        return render(req, 'items/error.html')


def addBookSuccess(req, success):
    return render(req, 'items/book/addBook.html', {
        'success': success
    })


def deleteBook(req, id):
    book = Book.objects.filter(pk=id).delete()
    return redirect(reverse('items:listBook'))


def editBook(req, id):
    author = Author.objects.all()
    category = Category.objects.filter(child__isnull=True)
    edit_book = Book.objects.get(pk=id)
    return render(req, 'items/book/editBook.html', {
        'Book': edit_book,
        'Categories': category,
        'Authors': author
    })


def updateBook(req):
    if req.method == 'POST':
        book_id = req.POST['book_id']
        name = req.POST['name']
        category_id = req.POST['category_id']
        author_id = req.POST['author']
        price = req.POST['price']
        status = req.POST['status']
        description = req.POST['description']
        slug = req.POST['slug']
        publisher = req.POST['publisher']
        pub_date = req.POST['pub_date']
        Book.objects.filter(pk=book_id).update(
            name=name,
            category=Category.objects.get(pk=category_id),
            author=Author.objects.get(pk=author_id),
            slug=slug,
            price=price,
            status=status,
            description=description,
            publisher=publisher,
            publication_date=pub_date
        )
        return redirect(reverse('items:editBookSuccess', args=(book_id, 1,)))
    else:
        return render(req, 'items/error.html')


def editBookSuccess(req, edited_id, success):
    author = Author.objects.all()
    book = Book.objects.get(pk=edited_id)
    category = Category.objects.filter(child__isnull=True)
    return render(req, 'items/book/editBook.html', {
        'success': success,
        'Categories': category,
        'Book': book,
        'Authors': author
    })


# 404
def notFound(req):
    return render(req, 'items/error.html')


# Laptop functions
def listLaptop(req):
    laptops = Laptop.objects.all()
    brands = LaptopBrand.objects.all()

    return render(req, 'items/laptop/listLaptop.html', {
        'Laptops': laptops,
        'Brands': brands
    })


def addLaptopBrand(req):
    return render(req, 'items/laptop/addBrand.html')


def addLaptopBrandSuccess(req, success):
    return render(req, 'items/laptop/addBrand.html', {
        'success': success
    })


def saveLaptopBrand(req):
    if req.method == 'POST':
        name = req.POST['name']
        origin = req.POST['origin']
        new_brand = LaptopBrand.objects.create(
            name=name,
            origin=origin
        )
        new_brand.save()
        return redirect(reverse('items:addLaptopBrandSuccess', args=(1,)))
    else:
        return render(req, 'items/error.html')


def addLaptop(req):
    brand = LaptopBrand.objects.all()
    return render(req, 'items/laptop/addLaptop.html', {
        'Brands': brand
    })


def saveLaptop(req):
    if req.method == 'POST':
        name = req.POST['name']
        brand_id = req.POST['brand_id']
        status = req.POST['status']
        price = req.POST['price']
        description = req.POST['description']
        slug = req.POST['slug']
        cpu = req.POST['cpu']
        ram = req.POST['ram']
        vga = req.POST['vga']
        screen = req.POST['screen']
        storage = req.POST['storage']
        battery = req.POST['battery']
        os = req.POST['os']
        new_lap = Laptop.objects.create(
            name=name,
            brand=LaptopBrand.objects.get(pk=brand_id),
            status=status,
            slug=slug,
            price=price,
            description=description,
            cpu=cpu, ram=ram, vga=vga, screen=screen, storage=storage, battery=battery, os=os
        )
        new_lap.save()
        return redirect(reverse('items:addLaptopSuccess', args=(1,)))
    else:
        return render(req, 'items/error.html')


def addLaptopSuccess(req, success):
    return render(req, 'items/laptop/addLaptop.html', {
        'success': success
    })


def editLaptop(req, id):
    brand = LaptopBrand.objects.all()
    laptop = Laptop.objects.get(pk=id)
    return render(req, 'items/laptop/editLaptop.html', {
        'Brands': brand,
        'Laptop': laptop
    })


def updateLaptop(req):
    if req.method == 'POST':
        name = req.POST['name']
        id = req.POST['id']
        brand_id = req.POST['brand_id']
        status = req.POST['status']
        price = req.POST['price']
        description = req.POST['description']
        slug = req.POST['slug']
        cpu = req.POST['cpu']
        ram = req.POST['ram']
        vga = req.POST['vga']
        screen = req.POST['screen']
        storage = req.POST['storage']
        battery = req.POST['battery']
        os = req.POST['os']
        edited_lap = Laptop.objects.filter(pk=id).update(
            name=name,
            brand=LaptopBrand.objects.get(pk=brand_id),
            status=status,
            slug=slug,
            price=price,
            description=description,
            cpu=cpu, ram=ram, vga=vga, screen=screen, storage=storage, battery=battery, os=os
        )
        return redirect(reverse('items:editLaptopSuccess', args=(id, 1,)))
    else:
        return render(req, 'items/error.html')


def editLaptopSuccess(req, id, success):
    laptop = Laptop.objects.get(pk=id)
    brand = LaptopBrand.objects.all()
    return render(req, 'items/laptop/editLaptop.html', {
        'success': success,
        'Brands': brand,
        'Laptop': laptop
    })


def deleteLaptop(req, id):
    lap = Laptop.objects.filter(pk=id).delete()
    return redirect(reverse('items:listLaptop'))


# SHOP MAIN PAGE
def home(req):
    products = Product.objects.all()
    return render(req, 'home.html', {
        'products': products
    })


def store(req, category_slug=None):
    if category_slug is not None:
        categories = get_object_or_404(Category, slug=category_slug)
        products = Product.objects.all().filter(category=categories)
    else:
        products = Product.objects.all().order_by('id')
    page = req.GET.get('page')
    page = page or 1
    paginator = Paginator(products, 3)
    paged_products = paginator.get_page(page)
    product_count = products.count()
    links = Category.objects.all()
    return render(req, 'store/store.html', {
        'products': paged_products,
        'product_count': product_count,
        'links': links
    })


def product_detail(req, category_slug, product_slug=None):
    product = Product.objects.get(category__slug=category_slug, slug=product_slug)
    return render(req, 'store/product_detail.html', {
        'single_product': product
    })


# CART
def _get_cart(request, cart_id=None):
    try:
        if cart_id is None:
            cart_id = request.session.session_key
        if cart_id:
            temp_cart = Cart.objects.get(cart_id=cart_id, is_checked_out=False)
        else:
            request.session.create()
            cart_id = request.session.session_key
            temp_cart = Cart.objects.create(cart_id=cart_id)
    except Cart.DoesNotExist:
        temp_cart = Cart.objects.create(cart_id=cart_id)
    if not request.user.is_authenticated:
        return temp_cart
    else:
        user = request.user
        try:
            db_cart = Cart.objects.get(user=user, is_checked_out=False)
            # print(temp_cart)
            db_items = ProductItem.objects.filter(cart=db_cart, cart__is_checked_out=False).all()
            temp_items = ProductItem.objects.filter(cart=temp_cart, cart__is_checked_out=False).all()
            for temp_item in temp_items:
                ProductItem.objects.filter(id=temp_item.id).update(cart=db_cart)
                for db_item in db_items:
                    if db_item.product.id == temp_item.product.id:
                        ProductItem.objects.filter(id=db_item.id).update(quantity=db_item.quantity + temp_item.quantity)
                        ProductItem.objects.filter(id=temp_item.id).delete()
            db_cart = Cart.objects.get(user=user, is_checked_out=False)
        except Cart.DoesNotExist:
            db_cart = Cart.objects.create(user=user)
            # db_items = ProductItem.objects.filter(cart=db_cart, cart__is_checked_out=False).all()
            temp_items = ProductItem.objects.filter(cart=temp_cart, cart__is_checked_out=False).all()
            for temp_item in temp_items:
                ProductItem.objects.filter(id=temp_item.id).update(cart=db_cart)
                # for db_item in db_items:
                #     if db_item.product.id == temp_item.product.id:
                #         ProductItem.objects.filter(id=db_item.id).update(quantity=db_item.quantity + temp_item.quantity)
                #         ProductItem.objects.filter(id=temp_item.id).delete()
            db_cart = Cart.objects.get(user=user, is_checked_out=False)
        return db_cart


def add_cart(req, product_id):
    user = req.user
    product = Product.objects.get(id=product_id)
    cart = _get_cart(req)
    is_existed_item = cart.productitem_set.filter(product=product, is_active=True).exists()
    if is_existed_item:
        item = ProductItem.objects.get(cart=cart, product=product, is_active=True)
        item.quantity += 1
    else:
        item = ProductItem.objects.create(cart=cart, product=product, quantity=1)
    item.save()
    return redirect('items:cart')


def remove_cart(req, product_id):
    product = get_object_or_404(Product, id=product_id)
    cart = _get_cart(req)
    item = ProductItem.objects.get(product=product, cart=cart, is_active=True)

    if item.quantity > 1:
        item.quantity -= 1
    else:
        item.is_active = False
    item.save()
    return redirect('items:cart')


def remove_cart_item(req, product_id):
    product = get_object_or_404(Product, id=product_id)
    cart = _get_cart(req)
    item = ProductItem.objects.get(product=product, cart=cart, is_active=True)
    item.is_active = False
    item.save()
    return redirect('items:cart')


def cart(req, total=0, quantity=0, items=None):
    global tax, grand_total
    try:
        cart = _get_cart(req)
        items = ProductItem.objects.filter(cart=cart, is_active=True).all()
        for item in items:
            total += item.product.price * item.quantity
            quantity += item.quantity
        tax = total * 10 / 100
        grand_total = total + tax
    except ObjectDoesNotExist:
        pass
    return render(req, 'store/cart.html', {
        'total': total,
        'quantity': quantity,
        'cart_items': items,
        'tax': tax,  # if "tax" in locals() else "",
        'grand_total': grand_total  # if "tax" in locals() else 0,
    })


@login_required(login_url='login')
def checkout(req, total=0, quantity=0, items=None):
    global grand_total, tax
    try:
        user = req.user
        cart = _get_cart(req)
        items = ProductItem.objects.filter(cart=cart, user=user, is_active=True)
        for item in items:
            total += item.product.price * item.quantity
            quantity += item.quantity
        tax = total * 10 / 100
        grand_total = total + tax
    except ObjectDoesNotExist:
        pass  # Chỉ bỏ qua
    return render(req, 'store/checkout.html', {
        'total': total,
        'quantity': quantity,
        'cart_items': items,
        'tax': tax if "tax" in locals() else "",
        'grand_total': grand_total,
    })


# SEARCH
def search(req):
    links = Category.objects.all()
    if 'q' in req.GET:
        q = req.GET.get('q')
        products = Product.objects.order_by('id').filter(Q(name__icontains=q) | Q(description__icontains=q))
        product_count = products.count()
    return render(req, 'store/store.html', {
        'products': products,
        'q': q,
        'product_count': product_count,
        'links': links
    })


# ACCOUNT

def register(req):
    if req.method == 'POST':
        form = RegistrationForm(req.POST)
        if form.is_valid():
            first_name = form.cleaned_data['first_name']
            last_name = form.cleaned_data['last_name']
            email = form.cleaned_data['email']
            phone_number = form.cleaned_data['phone_number']
            password = form.cleaned_data['password']
            username = email.split('@')[0]

            user = Account.objects.create_user(
                first_name=first_name,
                last_name=last_name,
                email=email,
                username=username,
                password=password
            )
            user.phone_number = phone_number
            user.save()

            current_site = get_current_site(request=req)
            mail_subject = 'Activate your account!'
            message = render_to_string('accounts/active_email.html', {
                'user': user,
                'domain': current_site.domain,
                'uid': urlsafe_base64_encode(force_bytes(user.pk)),
                'token': default_token_generator.make_token(user)
            })
            send_email = EmailMessage(mail_subject, message, to=[email])
            send_email.send()
            messages.success(
                request=req,
                message='Please confirm your email address to complete the registration'
            )
            return redirect('items:register')
        else:
            messages.error(request=req, message='Register failed!')
    else:
        form = RegistrationForm()
    return render(req, 'accounts/register.html', {
        'form': form
    })


def login(request):
    temp_cart_id = request.session.session_key

    if request.method == 'POST':
        email = request.POST.get('email')
        password = request.POST.get('password')
        user = auth.authenticate(email=email, password=password)
        if user is not None:

            auth.login(request=request, user=user)
            messages.success(request=request, message="Login successful!")

            url = request.META.get('HTTP_REFERER')
            cart = _get_cart(request, temp_cart_id)
            try:
                query = requests.utils.urlparse(url).query
                params = dict(x.split("=") for x in query.split("&"))
                if "next" in params:
                    next_page = params["next"]
                    return redirect(next_page)
            except Exception:
                return redirect('items:dashboard')
        else:
            messages.error(request=request, message="Login failed!")
    context = {
        'email': email if 'email' in locals() else '',
        'password': password if 'password' in locals() else '',
    }
    return render(request, 'accounts/login.html', context=context)


@login_required(login_url='login')
def logout(req):
    auth.logout(req)
    messages.success(req, message="You are logged out!")
    return redirect('items:login')


def forgotPassword(req):
    try:
        if req.method == 'POST':
            email = req.POST.get('email')
            user = Account.objects.get(email__exact=email)

            current_site = get_current_site(request=req)
            mail_subject = 'Reset your password'
            message = render_to_string('accounts/reset_password_email.html', {
                'user': user,
                'domain': current_site.domain,
                'uid': urlsafe_base64_encode(force_bytes(user.pk)),
                'token': default_token_generator.make_token(user)
            })
            send_email = EmailMessage(mail_subject, message, to=[email])
            send_email.send()

            messages.success(
                request=req, message="Password reset email has been sent to your email address")
    except Exception:
        messages.error(request=req, message="Account does not exist!")
    finally:
        return render(req, "accounts/forgotPassword.html", {
            'email': email if 'email' in locals() else '',
        })


@login_required(login_url="login")
def dashboard(req):
    return render(req, 'accounts/dashboard.html')


def activate(req, uidb64, token):
    try:
        uid = urlsafe_base64_decode(uidb64).decode()
        user = Account.objects.get(pk=uid)
    except Exception:
        user = None

    if user is not None and default_token_generator.check_token(user, token):
        user.is_active = True
        user.save()
        messages.success(
            request=req, message="Your account is activated, please login!")
        return render(req, 'accounts/login.html')
    else:
        messages.error(request=req, message="Activation link is invalid!")
        return redirect('home')


def reset_password_validate(req, uidb64, token):
    try:
        uid = urlsafe_base64_decode(uidb64).decode()
        user = Account.objects.get(pk=uid)
    except Exception:
        user = None

    if user is not None and default_token_generator.check_token(user, token):
        req.session['uid'] = uid
        messages.info(request=req, message='Please reset your password')
        return redirect('items:reset_password')
    else:
        messages.error(request=req, message="This link has been expired!")
        return redirect('home')


def reset_password(req):
    if req.method == 'POST':
        password = req.POST.get('password')
        confirm_password = req.POST.get('confirm_password')

        if password == confirm_password:
            uid = req.session.get('uid')
            user = Account.objects.get(pk=uid)
            user.set_password(password)
            user.save()
            messages.success(req, message="Password reset successful!")
            return redirect('items:login')
        else:
            messages.error(req, message="Password do not match!")
    return render(req, 'accounts/reset_password.html')
