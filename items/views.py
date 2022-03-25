from django.http import HttpResponseRedirect
from django.shortcuts import render, redirect
from django.urls import reverse

from .models import *


# # Create your views here.
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
    return render(req, 'items/book/editBook.html',{
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
            status = status,
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

# def addItem(req):
#     return render(req, 'items/addItem.html')
#
#
# def notFound(req):
#     return render(req, 'items/error.html')
#
#
# def saveData(req):
#     if req.method == 'POST':
#         print(req.POST)
#         name_book = req.POST['name_book']
#         type_book = req.POST['type_book']
#         author = req.POST['author']
#         price = req.POST['price']
#         description = req.POST['description']
#         status = req.POST['status']
#         new_item = item_model.objects.create(
#             name_book=name_book,
#             type_book=type_book,
#             author=author,
#             price=price,
#             description=description,
#             status=status,
#         )
#         new_item.save()
#         return render(req, 'items/addItem.html')
#     else:
#         return render(req, 'items/error.html')
