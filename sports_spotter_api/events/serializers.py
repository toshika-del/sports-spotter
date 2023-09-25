from rest_framework import serializers
from .models import Event, Alert, Team, Result

class EventSerializer(serializers.ModelSerializer):
    
    class Meta:
        model = Event
        fields = ('title', 'description', 'image_url', 'activate_date', 'deactivate_date', 'event_date', 'status')


class AlertSerializer(serializers.ModelSerializer):

    class Meta:
        model = Alert
        fields = ('title', 'description', 'activate_date', 'deactivate_date')

class TeamSerializer(serializers.ModelSerializer):

    class Meta:
        model = Team
        fields = ('id', 'name', 'event', 'captain', 'members', 'size',)

class ResultSerializer(serializers.ModelSerializer):
    
    class Meta:
        model = Result
        fields = ('id', 'event', 'winner', 'declare_date')