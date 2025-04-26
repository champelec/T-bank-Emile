# core/urls.py

from django.urls import path
from . import views

urlpatterns = [
    path('', views.home, name='home'),
    path('payment/', views.payment_form, name='payment_form'),
    path('redirect/', views.get_redirect_link, name='get_redirect_link'),
    path('api/redirect/<str:payment_id>/', views.PaymentRedirectView.as_view(), name='api_redirect'),
    path('fallback/', views.fallback_view, name='fallback'),
    path('unsupported-platform/', views.unsupported_platform_view, name='unsupported_platform'),
    path('deeplink-handler/', views.deeplink_handler, name='deeplink_handler'),
]