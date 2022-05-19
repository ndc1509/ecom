from django.conf import settings
from django.conf.urls.static import static
from django.contrib import admin
from django.urls import path, include

from store import views

urlpatterns = [
                  path('admin/', admin.site.urls),
                  path('/', include('items.urls')),
                  path('shop/account/', include('account.urls')),
                  path('shop/', include('store.urls')),
                  path('shop/home', views.home, name='home'),
              ] + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
