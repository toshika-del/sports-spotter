# Generated by Django 4.2.4 on 2023-09-25 20:07

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('events', '0012_alter_event_event_date'),
    ]

    operations = [
        migrations.AlterField(
            model_name='event',
            name='activate_date',
            field=models.DateField(null=True),
        ),
        migrations.AlterField(
            model_name='event',
            name='deactivate_date',
            field=models.DateField(null=True),
        ),
    ]
