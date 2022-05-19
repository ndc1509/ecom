from django import forms

from store.models import Shipment


class ShipmentForm(forms.ModelForm):
    class Meta:
        model = Shipment
        fields = ['address_line_1', 'address_line_2', 'city', 'country']

# class OrderForm(forms.ModelForm):
#     class Meta:
#         model = Order
#         fields = ['order_note']
