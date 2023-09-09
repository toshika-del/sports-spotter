from json import JSONDecodeError
from django.http import JsonResponse
from .serializers import PostSerializer, AlertSerializer
from .models import Post, Alert
from rest_framework.parsers import JSONParser
from rest_framework.permissions import IsAuthenticated
from rest_framework import viewsets, status
from rest_framework.response import Response
from rest_framework.mixins import ListModelMixin, UpdateModelMixin, RetrieveModelMixin


class PostViewSet(ListModelMixin, RetrieveModelMixin, viewsets.GenericViewSet):
    
    permission_classes = (IsAuthenticated,)
    serializer_class = PostSerializer
    queryset = Post.objects.all()


class AlertViewSet(ListModelMixin, RetrieveModelMixin, viewsets.GenericViewSet):

    permission_classes = (IsAuthenticated,)
    serializer_class = AlertSerializer
    queryset = Alert.objects.all()
