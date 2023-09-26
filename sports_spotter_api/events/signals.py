from django.db.models.signals import post_save
from django.dispatch import receiver
from .models import Event, Alert, Result

@receiver(post_save, sender=Event, weak=False)
def add_alert(sender, instance, created, **kwargs):
    if created:
        alert  = Alert.objects.create()
        alert.title = f'New event {instance.title}'
        alert.description = f'Last date to register is {instance.deactivate_date}'
        alert.save()

@receiver(post_save, sender=Result, weak=False)
def add_alert(sender, instance, created, **kwargs):
    if created:
        alert  = Alert.objects.create()
        alert.title = f'Result out for {instance.event.title}'
        alert.description = f'Check out winner in results'
        alert.save()