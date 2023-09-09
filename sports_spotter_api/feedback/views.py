from rest_framework import views, status
from .serializers import FeedbackSerializer
from rest_framework.parsers import JSONParser
from rest_framework.response import Response
from json import JSONDecodeError
from django.http import JsonResponse

class FeedbackApiView(views.APIView):
    
    serializer_class = FeedbackSerializer
    
    def get_serializer_context(self):
        return {
            'request': self.request,
            'format': self.format_kwarg,
            'view': self
        }
    
    def get_serializer(self, *args, **kwargs):
        kwargs['context'] = self.get_serializer_context()
        return self.serializer_class(*args, **kwargs)
    
    def post(self, request):
        try:
            data = JSONParser().parse(request)
            serializer = FeedbackSerializer(data=data)
            if serializer.is_valid(raise_exception=True):
                serializer.save()
                return Response(serializer.data)
            else:
                Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
        except JSONDecodeError:
            return JsonResponse({"result": "error", "message": "Json decoding error"}, status = 400)
