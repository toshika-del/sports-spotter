import 'package:flutter/material.dart';
import 'package:sports_spotter/constants.dart';
import 'package:table_calendar/table_calendar.dart';

class EventsCalandar extends StatefulWidget {
  const EventsCalandar({super.key});

  @override
  State<EventsCalandar> createState() => _EventsCalandarState();
}

class _EventsCalandarState extends State<EventsCalandar> {
  late DateTime _selectedDay;
  late DateTime _focusedDay;
  @override
  void initState() {
    _selectedDay = DateTime.now();
    _focusedDay = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
            onDaySelected: (selected, focused) {
              setState(() {
                _selectedDay = selected;
                _focusedDay = focused;
              });
            },
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) {
              return isSameDay(day, _selectedDay);
            },
            eventLoader: (day) {
              return [];
            },
            calendarStyle: CalendarStyle(
                selectedDecoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.blue.shade300),
                todayDecoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: primaryColor,
                ),
                markerDecoration: BoxDecoration(color: primaryColor)),
            firstDay: DateTime(2023),
            lastDay: DateTime(2030)),
        Expanded(child: ListView()),
      ],
    );
  }
}
