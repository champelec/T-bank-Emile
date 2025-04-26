# core/views.py

from django.shortcuts import redirect, render
from django.http import HttpResponseBadRequest, HttpResponse
from django.views import View
from django.core.validators import validate_slug
from django.core.exceptions import ValidationError
import logging
import re

logger = logging.getLogger(__name__)

def home(request):
    """Перенаправление на форму оплаты"""
    return redirect('payment_form')

def payment_form(request):
    """Отображение формы оплаты"""
    return render(request, 'core/payment_form.html')

def detect_platform(user_agent):
    """Автоматическое определение платформы по User-Agent"""
    user_agent = user_agent.lower()
    if 'iphone' in user_agent or 'ipad' in user_agent:
        return 'ios'
    elif 'android' in user_agent:
        return 'android'
    elif 'windows' in user_agent or 'macintosh' in user_agent or 'linux' in user_agent:
        return 'desktop'
    return 'unknown'

def validate_payment_id(payment_id):
    """Валидация ID платежа"""
    try:
        validate_slug(payment_id)
        return True
    except ValidationError:
        return False

def is_app_installed(platform_type):
    """Проверка установки приложения (заглушка для тестов)"""
    # В реальной реализации здесь должна быть логика проверки
    return False  # Всегда false для тестирования fallback

def get_redirect_link(request):
    """
    Основная функция обработки редиректа
    Поддерживает: iOS (old/new), Android, Desktop/Web
    """
    try:
        payment_id = request.GET.get('paymentid')
        platform_type = request.GET.get('platform', '').lower()
        user_agent = request.META.get('HTTP_USER_AGENT', '')

        # Валидация payment_id
        if not payment_id or not validate_payment_id(payment_id):
            logger.error(f"Invalid payment ID: {payment_id}")
            return HttpResponseBadRequest("Invalid payment ID")

        # Автоопределение платформы если не указана
        if not platform_type:
            platform_type = detect_platform(user_agent)
            logger.info(f"Auto-detected platform: {platform_type}")

        # Логика редиректов для каждой платформы
        if platform_type in ['ios', 'iphone', 'ipad']:
            app_version = request.GET.get('app_version', 'new')
            if app_version == 'old':
                redirect_url = f"https://payservice.com/tpay/{payment_id}"
            else:
                redirect_url = f"bank100000000004://pay/{payment_id}"

        elif platform_type in ['android', 'and']:
            redirect_url = f"tinkoffbank://pay/{payment_id}"

        elif platform_type in ['desktop', 'web', 'pc']:
            return redirect(f"https://payservice.com/webpay/{payment_id}")

        else:
            logger.warning(f"Unsupported platform: {platform_type}")
            return render(request, 'core/unsupported_platform.html', {
                'payment_id': payment_id
            })

        # Проверка установки приложения (кроме веба)
        if platform_type != 'desktop' and not is_app_installed(platform_type):
            logger.info(f"App not installed for {platform_type}")
            return redirect(f"/fallback/?platform={platform_type}&paymentid={payment_id}")

        # Обработка deeplink (не HTTP)
        if not redirect_url.startswith(('http://', 'https://')):
            return render(request, 'core/deeplink_redirect.html', {
                'redirect_url': redirect_url,
                'fallback_url': f"/fallback/?platform={platform_type}&paymentid={payment_id}"
            })

        return redirect(redirect_url)

    except Exception as e:
        logger.error(f"Redirect error: {str(e)}", exc_info=True)
        return HttpResponseBadRequest("Payment processing error")

class PaymentRedirectView(View):
    """API-версия для интеграции"""
    def get(self, request, payment_id):
        request.GET = request.GET.copy()
        request.GET['paymentid'] = payment_id
        return get_redirect_link(request)

def fallback_view(request):
    """Страница для случаев, когда приложение не установлено"""
    platform = request.GET.get('platform', 'unknown')
    payment_id = request.GET.get('paymentid', '')
    
    install_links = {
        'ios': 'itms-services://?action=download-manifest&url=https://example.com/app.plist',
        'android': 'https://trusted.store/app/com.tbank',
        'web': f'https://payservice.com/webpay/{payment_id}'
    }
    
    return render(request, 'core/fallback.html', {
        'platform': platform,
        'payment_id': payment_id,
        'install_links': install_links
    })
def api_redirect_handler(request, payment_id):
    """Обработчик для API-версии редиректа"""
    request.GET = request.GET.copy()  # Делаем GET mutable
    request.GET['paymentid'] = payment_id  # Добавляем payment_id в параметры
    return get_redirect_link(request)  # Используем существующую логику

def unsupported_platform_view(request):
    """Страница для неподдерживаемых платформ"""
    return render(request, 'core/unsupported_platform.html', {
        'payment_id': request.GET.get('paymentid', '')
    })

def deeplink_handler(request):
    """Обработчик deeplink-редиректов"""
    redirect_url = request.GET.get('redirect_url')
    fallback_url = request.GET.get('fallback_url', '/fallback/')
    return render(request, 'core/deeplink_redirect.html', {
        'redirect_url': redirect_url,
        'fallback_url': fallback_url
    })