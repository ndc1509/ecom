from django.contrib import admin

# Register your models here.
from items.models import Book, Smartphone, Laptop, Author, BookCategory, LaptopBrand

admin.site.register(Book)
admin.site.register(Laptop)
admin.site.register(Smartphone)
admin.site.register(Author)
admin.site.register(BookCategory)
admin.site.register(LaptopBrand)
