from django.urls import path

from . import views

app_name = 'items'
urlpatterns = [
    path('admin/', views.index, name='index'),
    path('admin/book/', views.listBook, name='listBook'),
    path('admin/book/add/', views.addBook, name='addBook'),
    path('admin/book/delete/<int:id>/', views.deleteBook, name='deleteBook'),
    path('admin/book/edit/<int:id>/', views.editBook, name='editBook'),
    path('admin/book/add-author', views.addAuthor, name='addAuthor'),
    path('admin/book/add-author/<int:success>/', views.addAuthorSuccess, name='addAuthorSuccess'),
    path('admin/save-author/', views.saveAuthor, name='saveAuthor'),
    path('admin/book/add/<int:success>', views.addBookSuccess, name='addBookSuccess'),
    path('admin/save-book/', views.saveBook, name='saveBook'),
    path('admin/book/edit/<int:edited_id>/<int:success>', views.editBookSuccess, name='editBookSuccess'),
    path('admin/update-book/', views.updateBook, name='updateBook'),

    path('admin/laptop/', views.listLaptop, name='listLaptop'),
    path('admin/laptop/add/', views.addLaptop, name='addLaptop'),
    path('admin/laptop/delete/<int:id>/', views.deleteLaptop, name='deleteLaptop'),
    path('admin/laptop/edit/<int:id>/', views.editLaptop, name='editLaptop'),
    path('admin/laptop/add-brand', views.addLaptopBrand, name='addBrand'),
    path('admin/laptop/add-brand/<int:success>/', views.addLaptopBrandSuccess, name='addLaptopBrandSuccess'),
    path('admin/save-brand/', views.saveLaptopBrand, name='saveBrand'),
    path('admin/laptop/add/<int:success>', views.addLaptopSuccess, name='addLaptopSuccess'),
    path('admin/save-laptop/', views.saveLaptop, name='saveLaptop'),
    path('admin/laptop/edit/<int:id>/<int:success>', views.editLaptopSuccess, name='editLaptopSuccess'),
    path('admin/update-laptop', views.updateLaptop, name='updateLaptop'),

    path('error/', views.notFound, name='notFound'),
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
    path('checkout', views.checkout, name='checkout'),

    # SEARCH
    path('search/', views.search, name='search'),

    # ACCOUNT
    path('register/', views.register, name='register'),
    path('login/', views.login, name='login'),
    path('logout/', views.logout, name='logout'),
    path('forgotPassword/', views.forgotPassword, name='forgotPassword'),

    path('dashboard/', views.dashboard, name='dashboard'),
    #path('', views.dashboard, name='dashboard'),

    path('activate/<uidb64>/<token>', views.activate, name='activate'),
    path('reset_password_validate/<uidb64>/<token>', views.reset_password_validate, name='reset_password_validate'),
    path('reset_password/', views.reset_password, name='reset_password')
]
