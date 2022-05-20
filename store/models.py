# CART
from django.db import models

from account.models import Account
from items.models import Product


class Cart(models.Model):
    cart_id = models.CharField(max_length=250, blank=True)
    date_added = models.DateTimeField(auto_now_add=True)
    user = models.ForeignKey(Account, on_delete=models.CASCADE, null=True)
    is_checked_out = models.BooleanField(default=False)

    def __str__(self):
        return self.cart_id


class ProductItem(models.Model):
    user = models.ForeignKey(Account, on_delete=models.CASCADE, null=True)
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
    # shipment_id = models.CharField(max_length=100)
    shipment_method = models.CharField(max_length=100, null=True, blank=True)
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


class ReviewRating(models.Model):
    product = models.ForeignKey(Product, on_delete=models.CASCADE)
    user = models.ForeignKey(Account, on_delete=models.CASCADE)
    subject = models.CharField(max_length=100, blank=True)
    review = models.TextField(max_length=500, blank=True)
    rating = models.FloatField()
    ip = models.CharField(max_length=20, blank=True)
    status = models.BooleanField(default=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.subject
