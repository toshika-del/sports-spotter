import 'package:flutter/material.dart';
import 'package:sports_spotter/api/auth.dart';
import 'package:sports_spotter/constants.dart';
import 'package:sports_spotter/models/event.dart';
import 'package:sports_spotter/widgets/create_team.dart';
import 'package:sports_spotter/screens/teamsbyeventscreen.dart';

class EventDetailScreen extends StatelessWidget {
  final EventModel model;
  const EventDetailScreen({super.key, required this.model});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
            headerSliverBuilder: (context, scrolled) {
              return [
                SliverAppBar(
                    expandedHeight: 200,
                    title: Text(model.title),
                    floating: false,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Image.network(
                        model.imgUrl,
                        fit: BoxFit.fill,
                      ),
                    ))
              ];
            },
            body: SingleChildScrollView(
              padding: paddingAll24,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                  Text(
                      'Date: ${model.eventDate.toLocal().toString().substring(0, 16)}',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  space8,
                  Text(
                    model.description,
                    style: const TextStyle(fontSize: 16),
                  ),
                  space8,
                  Text(
                    'Posted on: ${model.postedOn.toLocal().toString().substring(0, 10)}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                      'Last registration date: ${model.lastDate.toLocal().toString().substring(0, 10)}',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  space16,
                  if (model.lastDate.compareTo(DateTime.now()) >= 0 &&
                      !Auth.isStaff)
                    Row(
                      children: [
                        Expanded(
                            child: FilledButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                      useSafeArea: true,
                                      showDragHandle: true,
                                      context: context,
                                      builder: (context) =>
                                          CreateTeamWidget(model: model));
                                },
                                child: const Text('Create team'))),
                        space16,
                        Expanded(
                            child: OutlinedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              TeamsByEventScreen(
                                                  model: model)));
                                },
                                child: const Text('Join team')))
                      ],
                    )
                ],
              ),
            )));
  }
}
