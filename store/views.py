import datetime

from django.contrib.auth.decorators import login_required
from django.core.exceptions import ObjectDoesNotExist
from django.core.mail import EmailMessage
from django.core.paginator import Paginator
from django.db.models import Q
from django.http import JsonResponse
from django.shortcuts import render, redirect, get_object_or_404
# Create your views here.
from django.template.loader import render_to_string

from items.models import Product, Category
from store.forms import ShipmentForm
from store.models import Payment, Shipment, Order, ProductItem, Cart


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
    return redirect('store:cart')


def remove_cart(req, product_id):
    product = get_object_or_404(Product, id=product_id)
    cart = _get_cart(req)
    item = ProductItem.objects.get(product=product, cart=cart, is_active=True)

    if item.quantity > 1:
        item.quantity -= 1
    else:
        item.is_active = False
    item.save()
    return redirect('store:cart')


def remove_cart_item(req, product_id):
    product = get_object_or_404(Product, id=product_id)
    cart = _get_cart(req)
    item = ProductItem.objects.get(product=product, cart=cart, is_active=True)
    item.is_active = False
    item.save()
    return redirect('store:cart')


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
        items = ProductItem.objects.filter(cart=cart, is_active=True)
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
        'tax': tax,
        'grand_total': grand_total,
    })


# SEARCH
def search(req):
    global products, product_count, q
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


def sendOrderEmail(request, order):
    mail_subject = 'Thank you for your order!'
    message = render_to_string('orders/order_recieved_email.html', {
        'user': request.user,
        'order': order
    })
    to_email = request.user.email
    send_email = EmailMessage(mail_subject, message, to=[to_email])
    send_email.send()


def payments(request):
    global data
    try:
        if request.META.get('HTTP_X_REQUESTED_WITH') == 'XMLHttpRequest' and request.method == 'POST':
            user = request.user
            order_id = request.POST['orderID']
            trans_id = request.POST['transID']
            payment_method = request.POST['payment_method']
            status = request.POST['status']

            # Lấy bản ghi order
            order = Order.objects.get(user=user, order_id=order_id)
            cart = Cart.objects.get(id=order.cart.id)

            # Tạo 1 bản ghi payment
            payment = Payment(
                user=request.user,
                payment_id=trans_id,
                payment_method=payment_method,
                amount=order.order_total,
                status=status,
            )
            payment.save()

            order.payment = payment
            order.save()

            # Chuyển hết cart_item thành order_product
            items = ProductItem.objects.filter(cart=cart, is_active=True)
            for item in items:
                # Reduce the quantity of the sold products
                product = Product.objects.get(id=item.product_id)
                product.stock -= item.quantity
                product.save()

            # Xóa hết cart_item
            Cart.objects.filter(id=cart.id).update(is_checked_out=True)

            # Gửi thư cảm ơn
            # sendOrderEmail(request=request, order=order)

            # Phản hồi lại ajax
            data = {
                'order_id': order.order_id,
                'trans_id': payment.payment_id,
            }
        return JsonResponse({"data": data}, status=200)
    except Exception as e:
        return JsonResponse({"error": e}, status=400)


def place_order(request, total=0, quantity=0):
    user = request.user
    cart = _get_cart(request)
    items = ProductItem.objects.filter(cart=cart, is_active=True)
    item_count = items.count()
    if item_count <= 0:
        redirect('store:store')

    for item in items:
        total += (item.product.price * item.quantity)
        quantity += item.quantity
    tax = total / 10
    grand_total = total + tax

    if request.method == 'POST':
        form = ShipmentForm(request.POST)
        if form.is_valid():
            data = Order()
            data.user = user
            data.cart = cart
            address_line_1 = form.cleaned_data['address_line_1']
            address_line_2 = form.cleaned_data['address_line_2']
            city = form.cleaned_data['city']
            country = form.cleaned_data['country']
            shipment = Shipment.objects.create(address_line_1=address_line_1, address_line_2=address_line_2, city=city,
                                               country=country)
            data.shipment_id = shipment.id
            data.order_total = grand_total
            data.order_note = request.POST['order_note']
            data.ip = request.META.get('REMOTE_ADDR')
            data.save()
            order_id = datetime.datetime.now().strftime("%d%m%Y" + str(data.id))
            data.order_id = order_id
            data.save()

            order = Order.objects.get(user=user, order_id=order_id)
            return render(request, 'orders/payments.html', {
                'order': order,
                'cart_items': items,
                'total': total,
                'tax': tax,
                'grand_total': grand_total
            })
    else:
        return redirect('store:checkout')


def order_complete(request):
    order_id = request.GET.get('order_id')
    trans_id = request.GET.get('payment_id')
    shipment_id = request.GET.get('shipment_id')

    try:
        order = Order.objects.get(order_id=order_id)
        ordered_items = order.cart.productitem_set.all()

        subtotal = 0
        for item in ordered_items:
            subtotal += item.product.price * item.quantity

        payment = Payment.objects.get(payment_id=trans_id)
        shipment = Shipment.objects.get(shipment_id=shipment_id)

        return render(request, 'orders/order_complete.html', {
            'order': order,
            'ordered_products': ordered_items,
            'order_id': order.order_id,
            'trans_id': payment.payment_id,
            'payment': payment,
            'subtotal': subtotal,
            'shipment': shipment
        })
    except Exception:
        return redirect('home')
