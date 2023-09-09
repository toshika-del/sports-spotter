import 'package:flutter/material.dart';
import 'package:sports_spotter/constants.dart';

class AlertItem extends StatelessWidget {
  final String title;
  final String description;
  const AlertItem({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: paddingAll16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
