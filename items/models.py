import datetime

from django.contrib.auth.base_user import BaseUserManager, AbstractBaseUser
from django.contrib.auth.models import AbstractUser
from django.db import models
from django.urls import reverse

PRODUCT_STATUS = (
    ('C', 'Còn hàng'),
    ('H', 'Hết hàng'),
    ('CH', 'Chờ hàng'),
)

YEAR_CHOICES = [(r, r) for r in range(2010, datetime.date.today().year + 1)]


# Create your models here.

class Category(models.Model):
    name = models.CharField(max_length=100, unique=True)
    parent = models.ForeignKey('self', on_delete=models.CASCADE,
                               blank=True, null=True, related_name='children', related_query_name='child')
    slug = models.SlugField(max_length=100, unique=True, default="")

    class Meta:
        verbose_name = 'Category'
        verbose_name_plural = "Categories"

    def __str__(self):
        return self.name

    def get_url(self):
        return reverse('items:products_by_category', args=[self.slug])


class Product(models.Model):
    name = models.CharField(max_length=255)
    price = models.FloatField()
    stock = models.IntegerField(default=0)
    sold = models.IntegerField(default=0)
    status = models.CharField(choices=PRODUCT_STATUS, null=True, blank=True, max_length=2)
    slug = models.SlugField()
    description = models.TextField()
    category = models.ForeignKey(Category, on_delete=models.CASCADE, null=True, blank=True)

    def __str__(self):
        return self.name

    def get_url(self):
        return reverse('items:product_detail', args=[self.category.slug, self.slug])


class ProductImage(models.Model):
    image = models.ImageField()
    product = models.ForeignKey(Product, on_delete=models.CASCADE)

    class Meta:
        verbose_name_plural = "Product images"

    def __str__(self):
        return self.product.name


class Author(models.Model):
    name = models.CharField(max_length=100)

    def __str__(self):
        return self.name


class Book(Product):
    publisher = models.CharField(max_length=255)
    publication_date = models.IntegerField(null=True, blank=True)
    numbers_of_pages = models.IntegerField(default=0)
    author = models.ForeignKey(Author, on_delete=models.CASCADE, null=True, blank=True)

    def __str__(self):
        return self.name


class Brand(models.Model):
    name = models.CharField(max_length=100, unique=True)
    origin = models.CharField(max_length=100)

    def __str__(self):
        return self.name


class Laptop(Product):
    brand = models.ForeignKey(Brand, on_delete=models.CASCADE)
    ram = models.CharField(max_length=100)
    vga = models.CharField(max_length=100)
    cpu = models.CharField(max_length=100)
    screen = models.CharField(max_length=100)
    storage = models.CharField(max_length=100)
    battery = models.CharField(max_length=100)
    os = models.CharField(max_length=100)

    def __str__(self):
        return self.name


class Smartphone(Product):
    brand = models.ForeignKey(Brand, on_delete=models.CASCADE)
    cpu = models.CharField(max_length=100)
    ram = models.CharField(max_length=100)
    rom = models.CharField(max_length=100)
    camera = models.CharField(max_length=100)
    display = models.CharField(max_length=100)
    battery = models.CharField(max_length=100)
    os = models.CharField(max_length=100)

    def __str__(self):
        return self.name
