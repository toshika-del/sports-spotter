from .serializers import EventSerializer, AlertSerializer
from .models import Event, Alert
from rest_framework.permissions import IsAuthenticated
from rest_framework import viewsets
from rest_framework.mixins import ListModelMixin, RetrieveModelMixin


class EventViewSet(ListModelMixin, RetrieveModelMixin, viewsets.GenericViewSet):
    
    permission_classes = (IsAuthenticated,)
    serializer_class = EventSerializer
    queryset = Event.objects.all()


class AlertViewSet(ListModelMixin, RetrieveModelMixin, viewsets.GenericViewSet):

    permission_classes = (IsAuthenticated,)
    serializer_class = AlertSerializer
    queryset = Alert.objects.all()
