from django import forms

from store.models import Shipment, ReviewRating


class ShipmentForm(forms.ModelForm):
    class Meta:
        model = Shipment
        fields = ['address_line_1', 'address_line_2', 'city', 'country']

# class OrderForm(forms.ModelForm):
#     class Meta:
#         model = Order
#         fields = ['order_note']


class ReviewForm(forms.ModelForm):
    class Meta:
        model = ReviewRating
        fields = ['subject', 'review', 'rating']
