# Generated by Django 4.2.4 on 2023-09-18 09:05

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('events', '0006_remove_result_first_remove_result_second_and_more'),
    ]

    operations = [
        migrations.RenameModel(
            old_name='Post',
            new_name='Event',
        ),
        migrations.AlterModelOptions(
            name='event',
            options={'ordering': ['id'], 'verbose_name': 'Event', 'verbose_name_plural': 'Event'},
        ),
    ]