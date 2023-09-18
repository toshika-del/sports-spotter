from django.contrib import admin
from events.models import Event, Alert, Team, Result

admin.site.register(Event)
admin.site.register(Alert)
admin.site.register(Team)
admin.site.register(Result)