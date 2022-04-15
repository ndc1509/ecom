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


class LaptopBrand(models.Model):
    name = models.CharField(max_length=100, unique=True)
    origin = models.CharField(max_length=100)

    def __str__(self):
        return self.name


class Laptop(Product):
    brand = models.ForeignKey(LaptopBrand, on_delete=models.CASCADE)
    ram = models.CharField(max_length=100)
    vga = models.CharField(max_length=100)
    cpu = models.CharField(max_length=100)
    screen = models.CharField(max_length=100)
    storage = models.CharField(max_length=100)
    battery = models.CharField(max_length=100)
    os = models.CharField(max_length=100)

    def __str__(self):
        return self.name


class SmartphoneBrand(models.Model):
    name = models.CharField(max_length=100, unique=True)
    origin = models.CharField(max_length=100)

    def __str__(self):
        return self.name


class Smartphone(Product):
    brand = models.ForeignKey(SmartphoneBrand, on_delete=models.CASCADE)
    cpu = models.CharField(max_length=100)
    ram = models.CharField(max_length=100)
    rom = models.CharField(max_length=100)
    camera = models.CharField(max_length=100)
    display = models.CharField(max_length=100)
    battery = models.CharField(max_length=100)
    os = models.CharField(max_length=100)

    def __str__(self):
        return self.name


class MyAccountManager(BaseUserManager):
    def create_user(self, first_name, last_name, username, email, password=None):
        if not email:
            raise ValueError('Email address is required')

        if not username:
            raise ValueError('User name is required')

        # Tạo đối tượng user mới
        user = self.model(
            email=self.normalize_email(email=email),  # Chuyển email về dạng bình thường
            username=username,
            first_name=first_name,
            last_name=last_name,
        )

        user.set_password(password)
        user.save(using=self._db)
        return user

    def create_superuser(self, first_name, last_name, email, username, password):
        user = self.create_user(
            email=self.normalize_email(email=email),
            username=username,
            password=password,
            first_name=first_name,
            last_name=last_name,
        )
        user.is_admin = True
        user.is_active = True
        user.is_staff = True
        user.is_superadmin = True
        user.save(using=self._db)
        return user


class Account(AbstractBaseUser):
    first_name = models.CharField(max_length=50)
    last_name = models.CharField(max_length=50)
    username = models.CharField(max_length=50, unique=True)
    email = models.EmailField(max_length=100, unique=True)
    phone_number = models.CharField(max_length=50)

    # required
    date_joined = models.DateTimeField(auto_now_add=True)
    last_login = models.DateTimeField(auto_now_add=True)
    is_admin = models.BooleanField(default=False)
    is_staff = models.BooleanField(default=False)
    is_active = models.BooleanField(default=False)
    is_superadmin = models.BooleanField(default=False)

    USERNAME_FIELD = 'email'  # Trường quyêt định khi login
    REQUIRED_FIELDS = ['username', 'first_name',
                       'last_name']  # Các trường yêu cầu khi đk tài khoản (mặc định đã có email), mặc định có password

    objects = MyAccountManager()

    def __str__(self):
        return self.email

    def has_perm(self, perm, obj=None):
        return self.is_admin  # Admin có tất cả quyền trong hệ thống

    def has_module_perms(self, add_label):
        return True

    def full_name(self):
        return self.first_name + " " + self.last_name


# CART
class Cart(models.Model):
    cart_id = models.CharField(max_length=250, blank=True)
    date_added = models.DateTimeField(auto_now_add=True)
    user = models.ForeignKey(Account, on_delete=models.CASCADE, null=True)
    is_checked_out = models.BooleanField(default=False)

    def __str__(self):
        return self.cart_id


class ProductItem(models.Model):
    # user = models.ForeignKey(Account, on_delete=models.CASCADE, null=True)
    product = models.ForeignKey(Product, on_delete=models.CASCADE)
    cart = models.ForeignKey(Cart, on_delete=models.CASCADE, null=True)
    quantity = models.IntegerField()
    is_active = models.BooleanField(default=True)

    def __unicode__(self):
        return self.product

    def sub_total(self):
        return self.quantity * self.product.price


# ORDER
class Payment(models.Model):
    PAYMENT_STATUS = {
        ('Succeeded', 'Succeeded'),
        ('Failed', 'Failed'),
        ('Processing', 'Processing'),
    }
    user = models.ForeignKey(Account, on_delete=models.CASCADE)
    payment_id = models.CharField(max_length=100)
    payment_method = models.CharField(max_length=100)
    amount = models.FloatField()
    status = models.CharField(max_length=10, choices=PAYMENT_STATUS, default='Processing')
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.payment_id


class Shipment(models.Model):
    SHIPMENT_STATUS = {
        ('Pending', 'Pending'),
        ('Shipping', 'Shipping'),
        ('Delivered', 'Delivered'),
        ('Returned', 'Returned')
    }
    shipment_id = models.CharField(max_length=100)
    shipment_method = models.CharField(max_length=100)
    address_line_1 = models.CharField(max_length=100)
    address_line_2 = models.CharField(max_length=100, blank=True)
    city = models.CharField(max_length=50)
    country = models.CharField(max_length=50)
    fee = models.FloatField(default=0)
    status = models.CharField(max_length=10, choices=SHIPMENT_STATUS, default='Pending')

    def full_address(self):
        return self.address_line_1 + " " + self.city + " " + self.country

    def __str__(self):
        return self.shipment_id


class Order(models.Model):
    ORDER_STATUS = (
        ('New', 'New'),
        ('Accepted', 'Accepted'),
        ('Completed', 'Completed'),
        ('Cancelled', 'Cancelled')
    )

    user = models.ForeignKey(Account, on_delete=models.SET_NULL, null=True)
    payment = models.ForeignKey(Payment, on_delete=models.SET_NULL, blank=True, null=True)
    shipment = models.ForeignKey(Shipment, on_delete=models.SET_NULL, blank=True, null=True)
    cart = models.ForeignKey(Cart, on_delete=models.CASCADE, blank=True, null=True)

    order_id = models.CharField(max_length=20)
    order_note = models.CharField(max_length=100, blank=True)
    order_total = models.FloatField()
    status = models.CharField(max_length=10, choices=ORDER_STATUS, default='New')
    tax = models.FloatField(default=10)
    ip = models.CharField(max_length=20, blank=True)

    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def full_name(self):
        return self.user.first_name + self.user.last_name


