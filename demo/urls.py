from django.contrib import admin
from django.urls import path, include
from django.conf.urls.static import static
from django.conf import settings

from items import views

urlpatterns = [
    path('admin/', admin.site.urls),
    path('shop/', include('items.urls')),
    path('', views.home, name='home'),
] + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
