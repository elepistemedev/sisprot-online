from django.conf import settings
from django.contrib import admin
from django.urls import path
from drf_yasg import openapi
from drf_yasg.views import get_schema_view
from rest_framework import permissions

schema_view = get_schema_view(
    openapi.Info(
        title="Sisprot Online API",
        default_version="v1",
        description="API endpoints para SISPROT Online",
        contact=openapi.Contact(email="anchastreluis@gmail.com"),
        license=openapi.License(name="MIT License"),
    ),
    public=True,
    permission_classes=(permissions.AllowAny,),
)

urlpatterns = [
    path("redoc/", schema_view.with_ui("redoc", cache_timeout=0), name="schema-redoc"),
    path(settings.ADMIN_URL, admin.site.urls),
]

admin.site.site_header = "SISPROT Online API Admin"
admin.site.site_title = "SISPROT Online API Admin Portal"
admin.site.index_title = "Bienvenido al portal de SISPROT Online API"
