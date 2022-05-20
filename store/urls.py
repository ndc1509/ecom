from django.urls import path

from . import views

app_name = 'store'
urlpatterns = [

    # path('error/', views.notFound, name='notFound'),
    # path('save-item/', views.saveData, name='saveData'),
    # path('show/', views.show, name =  'show')
    # SHOP
    path('', views.store, name='store'),
    path('all-products/', views.store, name='products'),
    path('category/<slug:category_slug>/', views.store, name='products_by_category'),
    path('category/<slug:category_slug>/<slug:product_slug>/', views.product_detail, name='product_detail'),

    # CART
    path('cart/', views.cart, name='cart'),
    path('add-to-cart/<int:product_id>/', views.add_cart, name='add_cart'),
    path('remove-cart/<int:product_id>/', views.remove_cart, name='remove_cart'),
    path('remove-cart-item/<int:product_id>/', views.remove_cart_item, name='remove_cart_item'),

    # CHECKOUT
    path('checkout/', views.checkout, name='checkout'),

    # SEARCH
    path('search/', views.search, name='search'),

    # ORDERS
    path('place_order/', views.place_order, name='place_order'),
    path('payments/', views.payments, name='payments'),
    path('order_complete/', views.order_complete, name='order_complete'),

    # REVIEW
    path('submit_review/<int:product_id>/', views.submit_review, name='submit_review'),
]
