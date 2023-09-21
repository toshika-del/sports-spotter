from rest_framework import serializers
from .models import Event, Alert, Team

class EventSerializer(serializers.ModelSerializer):
    
    class Meta:
        model = Event
        fields = ('title', 'description', 'image_url', 'form_url', 'activate_date', 'deactivate_date')


class AlertSerializer(serializers.ModelSerializer):

    class Meta:
        model = Alert
        fields = ('title', 'description', 'form_url')

class TeamSerializer(serializers.ModelSerializer):

    class Meta:
        model = Team
        fields = ('id', 'name', 'event', 'captain', 'members', 'size',)