from rest_framework import serializers
from .models import Event, Alert, Team

class EventSerializer(serializers.ModelSerializer):
    
    class Meta:
        model = Event
        fields = ('title', 'description', 'image_url', 'activate_date', 'deactivate_date')


class AlertSerializer(serializers.ModelSerializer):

    class Meta:
        model = Alert
        fields = ('title', 'description', 'activate_date', 'deactivate_date')

class TeamSerializer(serializers.ModelSerializer):

    class Meta:
        model = Team
        fields = ('id', 'name', 'event', 'captain', 'members', 'size',)