from django.http import HttpResponseRedirect
from django.shortcuts import render, redirect
from django.urls import reverse
from .models import *


# Create your views here.
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
    categories = BookCategory.objects.all()

    return render(req, 'items/book/listBook.html', {
        'Books': books,
        'Categories': categories
    })


def addBook(req):
    categories = BookCategory.objects.filter(child__isnull=True)
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
            category=BookCategory.objects.get(pk=category_id),
            author=Author.objects.get(pk=author_id),
            status=status,
            slug=slug,
            price=price,
            description=description,
            publisher=publisher,
            publication_date=pub_date
        )
        new_book.save()
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
    category = BookCategory.objects.filter(child__isnull=True)
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
            category=BookCategory.objects.get(pk=category_id),
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
    category = BookCategory.objects.filter(child__isnull=True)
    return render(req, 'items/book/editBook.html', {
        'success': success,
        'Categories': category,
        'Book': book,
        'Authors': author
    })


#
# def notFound(req):
#     return render(req, 'items/error.html')

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
