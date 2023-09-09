import 'package:flutter/material.dart';
import 'package:sports_spotter/api/posts.dart';
import 'package:sports_spotter/widgets/event_card.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var response = fetchPosts();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder(
          future: response,
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return Text(
                  'There is nothing to show',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.blue.shade600,
                      fontWeight: FontWeight.bold),
                );
              }
              final data = snapshot.data!;
              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return EventCard(
                        image: NetworkImage(data[index]['image_url']),
                        title: data[index]['title'],
                        description: data[index]['description']);
                  });
            }
            return Text(
              'Some error occured',
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.red.shade400,
                  fontWeight: FontWeight.bold),
            );
          })),
    );
  }
}
