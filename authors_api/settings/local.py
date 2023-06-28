from .base import *  # noqa
from .base import env

# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = env(
    "DJANGO_SECRET_KEY",
    default="4QTY6Rn3AYs6-BaTkwuM2BHoOVnpGqWgGl3l5H60ahbnrWtKWAU",
)

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = True

CSRF_TRUSTED_ORIGINS = ["http://192.168.0.100:8080"]

ALLOWED_HOSTS = ['*']