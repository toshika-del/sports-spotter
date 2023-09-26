from django.contrib import admin
from events.models import Event, Alert, Team, Result

admin.site.register(Alert)

@admin.register(Event)
class EventAdmin(admin.ModelAdmin):
    list_display = ('title', 'event_date', 'status')
    list_filter = ('event_date','status')

@admin.register(Team)
class TeamAdmin(admin.ModelAdmin):
    list_display = ('name', 'event', 'captain')
    list_filter = ('event','captain','members',)


@admin.register(Result)
class ResultAdmin(admin.ModelAdmin):
    list_display = ('event','declare_date')
    list_filter = ('event','declare_date')
