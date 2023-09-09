from rest_framework import serializers
from .models import Post, Alert

class PostSerializer(serializers.ModelSerializer):
    
    class Meta:
        model = Post
        fields = ('title', 'description', 'image_url', 'form_url')


class AlertSerializer(serializers.ModelSerializer):

    class Meta:
        model = Alert
        fields = ('title', 'description', 'form_url')
