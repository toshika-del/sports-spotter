import 'package:flutter/material.dart';
import 'package:sports_spotter/api/posts.dart';
import 'package:sports_spotter/constants.dart';
import 'package:sports_spotter/models/event.dart';
import 'package:sports_spotter/screens/eventdetailscreen.dart';
import 'package:sports_spotter/widgets/error_widget.dart';
import 'package:table_calendar/table_calendar.dart';

class EventsCalandar extends StatefulWidget {
  const EventsCalandar({super.key});

  @override
  State<EventsCalandar> createState() => _EventsCalandarState();
}

class _EventsCalandarState extends State<EventsCalandar> {
  late DateTime _selectedDay;
  late DateTime _focusedDay;
  late CalendarFormat _calendarFormat;
  late ValueNotifier<List<EventModel>> _selectedDayEvents;
  @override
  void initState() {
    _selectedDay = DateTime.now();
    _focusedDay = DateTime.now();
    _calendarFormat = CalendarFormat.month;
    _selectedDayEvents = ValueNotifier(_getEventsForDay([], DateTime.now()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchPosts(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!;
            return Column(children: [
              TableCalendar<EventModel>(
                  calendarFormat: _calendarFormat,
                  rangeSelectionMode: RangeSelectionMode.disabled,
                  onDaySelected: (selected, focused) {
                    setState(() {
                      _selectedDay = selected;
                      _focusedDay = focused;
                    });
                    _selectedDayEvents.value = _getEventsForDay(data, selected);
                  },
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) {
                    return isSameDay(day, _selectedDay);
                  },
                  eventLoader: (day) {
                    return _getEventsForDay(data, day);
                  },
                  onFormatChanged: (format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  },
                  onHeaderTapped: (focusedDay) {
                    setState(() {
                      _selectedDay = DateTime.now();
                    });
                  },
                  calendarStyle: CalendarStyle(
                    selectedDecoration: BoxDecoration(
                        shape: BoxShape.circle, color: primaryColor),
                    todayDecoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: primaryColorLight,
                    ),
                    markerDecoration: BoxDecoration(
                        color: Colors.grey.shade700, shape: BoxShape.circle),
                  ),
                  firstDay: DateTime(2023),
                  lastDay: DateTime(2030)),
              const Divider(),
              Expanded(
                  child: ValueListenableBuilder<List<EventModel>>(
                      valueListenable: _selectedDayEvents,
                      builder: (context, value, _) {
                        if (value.isNotEmpty) {
                          return ListView.builder(
                              itemCount: value.length,
                              itemBuilder: (context, index) => ListTile(
                                    leading: const Icon(Icons.event),
                                    title: Text(value[index].title),
                                    subtitle: Text(value[index]
                                        .lastDate
                                        .toString()
                                        .substring(0, 16)),
                                    onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                EventDetailScreen(
                                                    model: value[index]))),
                                  ));
                        }
                        return Center(
                            child: Text(
                          'No events for ${_selectedDay.toString().substring(0, 10)}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ));
                      })),
            ]);
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return loader;
          }
          return ErrorMessage(refresh: () {});
        }));
  }

  List<EventModel> _getEventsForDay(List<EventModel> events, DateTime day) {
    return events
        .where((e) =>
            day.toString().substring(0, 10) ==
            e.lastDate.toString().substring(0, 10))
        .toList();
  }
}
