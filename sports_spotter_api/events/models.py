from django.db import models
from django_extensions.db.models import (TimeStampedModel, ActivatorModel, TitleDescriptionModel)
from utils.model_abstract import Model
from django.contrib.auth.models import User
from django.shortcuts import get_object_or_404


class Event(TimeStampedModel, ActivatorModel, TitleDescriptionModel, Model):

    class Meta:
        verbose_name = "Event"
        verbose_name_plural = "Event"
        ordering = ["id"]

    image_url = models.URLField(max_length=10000, default='')
    form_url = models.URLField(max_length=10000, default='')

    def __str__(self) -> str:
        return self.title


class Alert(TimeStampedModel, ActivatorModel, TitleDescriptionModel, Model):

    class Meta:
        verbose_name = "Alert"
        verbose_name_plural = "Alerts"
        ordering = ["id"]

    form_url = models.URLField(default='', max_length=10000)

    def __str__(self) -> str:
        return self.title


class Team(Model):

    class Meta:
        verbose_name = "Team"
        verbose_name_plural = "Teams"
        ordering = ["id"]

    name = models.CharField(default='Team', null=False, max_length=1000)
    event = models.ForeignKey(Event, on_delete=models.CASCADE)
    members = models.ManyToManyField(User)

    def __str__(self) -> str:
        return f"{self.event.title} {self.name}"
    
    def add_member(self, username):
        user = get_object_or_404(User, username=username)
        self.members.add(user)

    def remove_member(self, username):
        user = get_object_or_404(User, username=username)
        self.members.remove(user)

class Result(Model):

    class Meta:
        verbose_name = "Result"
        verbose_name_plural = "Results"
        ordering = ["id"]
    
    event = models.ForeignKey(Event,on_delete=models.CASCADE, null=True)
    winner = models.ForeignKey(Team,on_delete=models.CASCADE, null=True)

    def __str__(self) -> str:
        return self.event.title