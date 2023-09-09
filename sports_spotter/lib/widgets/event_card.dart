import 'package:flutter/material.dart';
import 'package:sports_spotter/constants.dart';

class EventCard extends StatelessWidget {
  final ImageProvider image;
  final String title;
  final String description;
  const EventCard(
      {super.key,
      required this.image,
      required this.title,
      required this.description});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: paddingAll16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image(
                image: image,
                height: 200,
                width: double.maxFinite,
                fit: BoxFit.fitWidth,
              ),
            ),
            space8,
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              description,
              style: const TextStyle(fontSize: 16),
            )
          ],
        ),
      ),
    );
  }
}
