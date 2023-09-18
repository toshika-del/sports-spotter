from rest_framework import serializers
from .models import Event, Alert

class EventSerializer(serializers.ModelSerializer):
    
    class Meta:
        model = Event
        fields = ('title', 'description', 'image_url', 'form_url')


class AlertSerializer(serializers.ModelSerializer):

    class Meta:
        model = Alert
        fields = ('title', 'description', 'form_url')
