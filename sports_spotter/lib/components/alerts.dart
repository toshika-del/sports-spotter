import 'package:flutter/material.dart';
import 'package:sports_spotter/constants.dart';
import 'package:sports_spotter/widgets/alert_item.dart';

class Alerts extends StatelessWidget {
  const Alerts({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: paddingAll8,
      children: const [
        AlertItem(title: 'Vollyball Match', description: 'Vollyball match'),
        AlertItem(title: 'Football Match', description: 'Football match'),
        AlertItem(title: 'Cricket Match', description: 'Cricket match'),
      ],
    );
  }
}
