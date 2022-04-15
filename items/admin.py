from django.contrib import admin
# Register your models here.
from django.contrib.auth.admin import UserAdmin

from items.models import Book, Smartphone, Laptop, Author, Category, LaptopBrand, Account, ProductItem, Cart

admin.site.register(Book)
admin.site.register(Laptop)
admin.site.register(Smartphone)
admin.site.register(Author)
admin.site.register(Category)
admin.site.register(LaptopBrand)
admin.site.register(Cart)
admin.site.register(ProductItem)


class AccountAdmin(UserAdmin):
    list_display = ('email', 'username', 'first_name', 'last_name', 'last_login', 'date_joined', 'is_active')
    list_display_links = ('email', 'username', 'first_name', 'last_name')  # Các trường có gắn link dẫn đến trang detail
    readonly_fields = ('last_login', 'date_joined')  # Chỉ cho phép đọc
    ordering = ('-date_joined',)  # Sắp xếp theo chiều ngược

    # Bắt buộc phải khai báo
    filter_horizontal = ()
    list_filter = ()
    fieldsets = ()


admin.site.register(Account, AccountAdmin)
