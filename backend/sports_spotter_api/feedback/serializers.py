from . import models
from rest_framework import serializers
from rest_framework.fields import CharField, EmailField

class FeedbackSerializer(serializers.ModelSerializer):
    
    title = CharField(required = True)
    description = CharField(required = True)
    email = EmailField(required = True)

    class Meta:
        model = models.Feedback
        fields = ('title', 'description', 'email')