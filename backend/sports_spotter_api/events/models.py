from django.db import models
from django_extensions.db.models import (TimeStampedModel, ActivatorModel, TitleDescriptionModel)
from utils.model_abstract import Model


class Post(TimeStampedModel, ActivatorModel, TitleDescriptionModel, Model):

    class Meta:
        verbose_name = "Post"
        verbose_name_plural = "Posts"
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
    