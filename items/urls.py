from django.urls import path
from . import views

app_name = 'items'
urlpatterns = [
    path('', views.index, name='index'),
    path('book/', views.listBook, name='listBook'),
    path('book/add/', views.addBook, name='addBook'),
    path('book/delete/<int:id>/', views.deleteBook, name='deleteBook'),
    path('book/edit/<int:id>/', views.editBook, name='editBook'),
    path('book/add-author', views.addAuthor, name='addAuthor'),
    path('book/add-author/<int:success>/', views.addAuthorSuccess, name='addAuthorSuccess'),
    path('save-author/', views.saveAuthor, name='saveAuthor'),
    path('book/add/<int:success>', views.addBookSuccess, name='addBookSuccess'),
    path('save-book/', views.saveBook, name='saveBook'),
    path('book/edit/<int:edited_id>/<int:success>', views.editBookSuccess, name='editBookSuccess'),
    path('update-book/', views.updateBook, name='updateBook')
    # path('error/', views.notFound, name='notFound'),
    # path('save-item/', views.saveData, name='saveData'),
    # path('show/', views.show, name =  'show')
]
