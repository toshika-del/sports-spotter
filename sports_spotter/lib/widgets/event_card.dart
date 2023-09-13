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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16)),
            child: Image(
              image: image,
              height: 200,
              width: double.maxFinite,
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: paddingAll16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  description,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
