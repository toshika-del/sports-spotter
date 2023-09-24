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

    def __str__(self) -> str:
        return self.title


class Alert(TimeStampedModel, ActivatorModel, TitleDescriptionModel, Model):

    class Meta:
        verbose_name = "Alert"
        verbose_name_plural = "Alerts"
        ordering = ["id"]

    def __str__(self) -> str:
        return self.title


class Team(Model):

    class Meta:
        verbose_name = "Team"
        verbose_name_plural = "Teams"
        ordering = ["id"]

    name = models.CharField(default='Team', null=False, max_length=1000)
    event = models.ForeignKey(Event, on_delete=models.CASCADE)
    size = models.IntegerField(default=1,null=False)
    captain = models.ForeignKey(User,null=True,on_delete=models.CASCADE,related_name='captain')
    members = models.ManyToManyField(User,related_name='members')

    def __str__(self) -> str:
        return f"{self.name} ({self.event.title})"
    
    def add_member(self, username):
        if(self.members.count()<self.size):
            user = get_object_or_404(User, username=username)
            self.members.add(user)
        else:
            raise OverflowError('max team members added')

    def remove_member(self, username):
        user = get_object_or_404(User, username=username)
        self.members.remove(user)

    @staticmethod
    def create_team(name, captain_username, event_id, size):
        captain = get_object_or_404(User, username=captain_username)
        event = get_object_or_404(Event, id=event_id)
        team = Team.objects.create(name=name,captain=captain,event=event,size=size)
        team.add_member(captain_username)
        team.save()
        return team.id

class Result(Model):

    class Meta:
        verbose_name = "Result"
        verbose_name_plural = "Results"
        ordering = ["id"]
    
    event = models.ForeignKey(Event,on_delete=models.CASCADE, null=True)
    winner = models.ForeignKey(Team,on_delete=models.CASCADE, null=True)
    declare_date = models.DateField(null=True)

    def __str__(self) -> str:
        return f'{self.event.title} result'