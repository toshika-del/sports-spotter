from django.http import JsonResponse
from rest_framework.decorators import api_view
from rest_framework.response import Response
from django.contrib.auth.models import User
from rest_framework.authtoken.models import Token
from rest_framework.parsers import JSONParser
from django.shortcuts import get_object_or_404

from .serializers import UserSerializer
from rest_framework import status

@api_view(['POST'])
def login(request):
    data = JSONParser().parse(request)
    print(data)
    user = get_object_or_404(User, username=data['username'])
    if not user.check_password(data['password']):
        return JsonResponse({"error":"wrong password"},status=status.HTTP_403_FORBIDDEN)
    print(user.has_usable_password())
    token, created = Token.objects.get_or_create(user=user)
    serializer = UserSerializer(user)
    return JsonResponse({"token":token.key, "user":serializer.data},status=status.HTTP_200_OK)

@api_view(['POST'])
def logout(request):
    return JsonResponse({"message":"logged out successfully"},status=status.HTTP_200_OK)

@api_view(['POST'])
def register(request):
    data = JSONParser().parse(request)
    serializer = UserSerializer(data=data)
    if not data['username'].startswith('0801'):
        return JsonResponse({"error":"you are unauthorised"}, status=status.HTTP_401_UNAUTHORIZED)
    if serializer.is_valid():
        serializer.save()
        user = User.objects.get(username=data['username'])
        user.set_password(data['password'])
        user.email = data['email']
        user.save()
        token = Token.objects.get(user=user)
        return JsonResponse({"token":token.key, "user":serializer.data},status=status.HTTP_200_OK)
    return JsonResponse(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

@api_view(['POST'])
def get_user(request):
    data = JSONParser().parse(request)
    try:
        token = Token.objects.get(key=data['token'])
        user = UserSerializer(token.user)
        return Response(user.data)
    except:
        return JsonResponse({"error":"invalid token"})
