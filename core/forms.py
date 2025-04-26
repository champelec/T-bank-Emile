from django import forms
import re
from django.core.exceptions import ValidationError

class PaymentIDForm(forms.Form):
    payment_id = forms.CharField(max_length=100, label='Payment ID')

class PaymentIDForm(forms.Form):
    payment_id = forms.CharField(max_length=100, label='Payment ID')

    def clean_payment_id(self):
        payment_id = self.cleaned_data['payment_id']
        if len(payment_id) < 3:
            raise ValidationError("ID платежа должно содержать минимум 3 символа.")
        if not re.match(r'^[a-zA-Z0-9]*$', payment_id):
            raise ValidationError("ID платежа может содержать только буквы и цифры.")
        return payment_id
