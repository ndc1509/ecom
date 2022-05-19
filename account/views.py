from django.core.mail import EmailMessage

from django.contrib import messages, auth
from django.contrib.auth.decorators import login_required
from django.contrib.auth.tokens import default_token_generator
import requests
from django.contrib.sites.shortcuts import get_current_site
from django.shortcuts import render, redirect

from django.template.loader import render_to_string
from django.utils.encoding import force_bytes
from django.utils.http import urlsafe_base64_encode, urlsafe_base64_decode

from account.forms import RegistrationForm
from account.models import Account
from store.views import _get_cart


def register(req):
    if req.method == 'POST':
        form = RegistrationForm(req.POST)
        if form.is_valid():
            first_name = form.cleaned_data['first_name']
            last_name = form.cleaned_data['last_name']
            email = form.cleaned_data['email']
            phone_number = form.cleaned_data['phone_number']
            password = form.cleaned_data['password']
            username = email.split('@')[0]

            user = Account.objects.create_user(
                first_name=first_name,
                last_name=last_name,
                email=email,
                username=username,
                password=password
            )
            user.phone_number = phone_number
            user.save()

            current_site = get_current_site(request=req)
            mail_subject = 'Activate your account!'
            message = render_to_string('accounts/active_email.html', {
                'user': user,
                'domain': current_site.domain,
                'uid': urlsafe_base64_encode(force_bytes(user.pk)),
                'token': default_token_generator.make_token(user)
            })
            send_email = EmailMessage(mail_subject, message, to=[email])
            send_email.send()
            messages.success(
                request=req,
                message='Please confirm your email address to complete the registration'
            )
            return redirect('account:register')
        else:
            messages.error(request=req, message='Register failed!')
    else:
        form = RegistrationForm()
    return render(req, 'accounts/register.html', {
        'form': form
    })


def login(request):
    global email, password
    temp_cart_id = request.session.session_key

    if request.method == 'POST':
        email = request.POST.get('email')
        password = request.POST.get('password')
        user = auth.authenticate(email=email, password=password)
        if user is not None:

            auth.login(request=request, user=user)
            messages.success(request=request, message="Login successful!")

            url = request.META.get('HTTP_REFERER')
            cart = _get_cart(request, temp_cart_id)
            try:
                query = requests.utils.urlparse(url).query
                params = dict(x.split("=") for x in query.split("&"))
                if "next" in params:
                    next_page = params["next"]
                    return redirect(next_page)
            except Exception:
                return redirect('account:dashboard')
        else:
            messages.error(request=request, message="Login failed!")
    context = {
        'email': email if 'email' in locals() else '',
        'password': password if 'password' in locals() else '',
    }
    return render(request, 'accounts/login.html', context=context)


@login_required(login_url='login')
def logout(req):
    auth.logout(req)
    messages.success(req, message="You are logged out!")
    return redirect('account:login')


def forgotPassword(req):
    global email
    try:
        if req.method == 'POST':
            email = req.POST.get('email')
            user = Account.objects.get(email__exact=email)

            current_site = get_current_site(request=req)
            mail_subject = 'Reset your password'
            message = render_to_string('accounts/reset_password_email.html', {
                'user': user,
                'domain': current_site.domain,
                'uid': urlsafe_base64_encode(force_bytes(user.pk)),
                'token': default_token_generator.make_token(user)
            })
            send_email = EmailMessage(mail_subject, message, to=[email])
            send_email.send()

            messages.success(
                request=req, message="Password reset email has been sent to your email address")
    except Exception:
        messages.error(request=req, message="Account does not exist!")
    finally:
        return render(req, "accounts/forgotPassword.html", {
            'email': email if 'email' in locals() else '',
        })


@login_required(login_url="login")
def dashboard(req):
    return render(req, 'accounts/dashboard.html')


def activate(req, uidb64, token):
    try:
        uid = urlsafe_base64_decode(uidb64).decode()
        user = Account.objects.get(pk=uid)
    except Exception:
        user = None

    if user is not None and default_token_generator.check_token(user, token):
        user.is_active = True
        user.save()
        messages.success(
            request=req, message="Your account is activated, please login!")
        return render(req, 'accounts/login.html')
    else:
        messages.error(request=req, message="Activation link is invalid!")
        return redirect('home')


def reset_password_validate(req, uidb64, token):
    global uid
    try:
        uid = urlsafe_base64_decode(uidb64).decode()
        user = Account.objects.get(pk=uid)
    except Exception:
        user = None

    if user is not None and default_token_generator.check_token(user, token):
        req.session['uid'] = uid
        messages.info(request=req, message='Please reset your password')
        return redirect('auth:reset_password')
    else:
        messages.error(request=req, message="This link has been expired!")
        return redirect('home')


def reset_password(req):
    if req.method == 'POST':
        password = req.POST.get('password')
        confirm_password = req.POST.get('confirm_password')

        if password == confirm_password:
            uid = req.session.get('uid')
            user = Account.objects.get(pk=uid)
            user.set_password(password)
            user.save()
            messages.success(req, message="Password reset successful!")
            return redirect('account:login')
        else:
            messages.error(req, message="Password do not match!")
    return render(req, 'accounts/reset_password.html')
