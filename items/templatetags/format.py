from django import template
from django.utils.safestring import mark_safe

register = template.Library()


@register.filter(is_safe=True)
def bold(value):
    return mark_safe('<strong> %s </strong>' % value)
