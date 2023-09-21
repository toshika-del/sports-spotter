import 'package:flutter/material.dart';
import 'package:sports_spotter/constants.dart';
import 'package:sports_spotter/models/event.dart';

class EventDetailScreen extends StatelessWidget {
  final EventModel model;
  const EventDetailScreen({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    print(model.toString());
    return Scaffold(
        // appBar: AppBar(
        //   title: Text(
        //     model.title,
        //     style: const TextStyle(fontWeight: FontWeight.bold),
        //   ),
        // ),
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
                    model.description,
                    style: const TextStyle(fontSize: 16),
                  ),
                  space8,
                  Text(
                    'Posted on: ${model.postedOn.toLocal().toString().substring(0, 16)}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                      'Last date: ${model.lastDate.toLocal().toString().substring(0, 16)}',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  space16,
                  Row(
                    children: [
                      Expanded(
                          child: FilledButton(
                              onPressed: () {},
                              child: const Text('Create team'))),
                      space16,
                      Expanded(
                          child: OutlinedButton(
                              onPressed: () {}, child: const Text('Join team')))
                    ],
                  )
                ],
              ),
            )));
  }
}
