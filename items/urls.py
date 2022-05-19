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

    # path('error/', views.notFound, name='notFound'),
    # path('save-item/', views.saveData, name='saveData'),
    # path('show/', views.show, name =  'show')

]
