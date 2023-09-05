import 'package:flutter/material.dart';
import 'package:sports_spotter/constants.dart';
import 'package:sports_spotter/widgets/event_card.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: paddingAll8,
      children: const [
        EventCard(
          image: NetworkImage(
              'https://upload.wikimedia.org/wikipedia/commons/a/ad/Football_in_Bloomington%2C_Indiana%2C_1996.jpg'),
          title: 'Football',
          description: 'Inter-Collage Football championship',
        ),
        EventCard(
          image: NetworkImage(
              'https://upload.wikimedia.org/wikipedia/commons/a/ad/Football_in_Bloomington%2C_Indiana%2C_1996.jpg'),
          title: 'Football',
          description: 'Inter-Collage Football championship',
        ),
        EventCard(
          image: NetworkImage(
              'https://upload.wikimedia.org/wikipedia/commons/a/ad/Football_in_Bloomington%2C_Indiana%2C_1996.jpg'),
          title: 'Football',
          description: 'Inter-Collage Football championship',
        ),
      ],
    );
  }
}
