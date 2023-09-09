from django.db import models
from utils.model_abstract import Model
from django_extensions.db.models import(TimeStampedModel, ActivatorModel, TitleDescriptionModel)

class Feedback(TimeStampedModel, ActivatorModel, TitleDescriptionModel, Model):
    
	class Meta:
		verbose_name = 'Feedback'
		verbose_name_plural = 'Feedbacks'

	email = models.EmailField(verbose_name='Email')
	
	def __str__(self):
		return f"{self.title}"