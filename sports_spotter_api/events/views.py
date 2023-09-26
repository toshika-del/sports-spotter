from .serializers import EventSerializer, AlertSerializer, TeamSerializer, ResultSerializer
from .models import Event, Alert, Team, Result
from rest_framework.permissions import IsAuthenticated
from rest_framework import viewsets
from rest_framework.mixins import ListModelMixin, RetrieveModelMixin
from rest_framework.decorators import api_view
from rest_framework.parsers import JSONParser
from django.http import JsonResponse
from rest_framework import status
from django.shortcuts import get_object_or_404

class EventViewSet(ListModelMixin, RetrieveModelMixin, viewsets.GenericViewSet):
    
    permission_classes = (IsAuthenticated,)
    serializer_class = EventSerializer
    queryset = Event.objects.all()

    @staticmethod
    @api_view(['POST'])
    def create_event(request):
        data = JSONParser().parse(request)
        event_serializer = EventSerializer(data=data)
        if event_serializer.is_valid():
            event_serializer.save()
            return JsonResponse({"details":f"{data['title']} event created"})
        return JsonResponse(event_serializer.errors,status=status.HTTP_400_BAD_REQUEST)

class AlertViewSet(ListModelMixin, RetrieveModelMixin, viewsets.GenericViewSet):

    permission_classes = (IsAuthenticated,)
    serializer_class = AlertSerializer
    queryset = Alert.objects.all()


class TeamView(ListModelMixin, RetrieveModelMixin, viewsets.GenericViewSet):
    queryset = Team.objects.all()
    serializer_class = TeamSerializer
    json = JSONParser()

    @staticmethod
    @api_view(['Post'])
    def add_to_team(request, id):
        data = TeamView.json.parse(request)
        team = get_object_or_404(Team, id=id)
        try:
            team.add_member(data['username'])
        except OverflowError:
            return JsonResponse({"error":f"max team members added"},status=status.HTTP_400_BAD_REQUEST)
        return JsonResponse({"detail":f"{data['username']} added to team {team.name}"},status=status.HTTP_200_OK)
    
    @staticmethod
    @api_view(['Post'])
    def remove_from_team(request, id):
        data = TeamView.json.parse(request)
        team = get_object_or_404(Team, id=id)
        team.remove_member(data['username'])
        return JsonResponse({"detail":f"{data['username']} removed from team {team.name}"},status=status.HTTP_200_OK)
    
    @staticmethod
    @api_view(['POST'])
    def create(request):
        data = TeamView.json.parse(request)
        id = Team.create_team(data['name'],data['captain_username'],data['event_id'],data['size'])
        return JsonResponse({"id":id})
    
    @staticmethod
    @api_view(['POST'])
    def delete(request, id):
        team = get_object_or_404(Team, id=id)
        team.delete()
        return JsonResponse({"detail":"team deleted"})
    

class ResultView(ListModelMixin, RetrieveModelMixin, viewsets.GenericViewSet):
    queryset = Result.objects.all()
    serializer_class = ResultSerializer
    