import 'package:flutter/material.dart';
import 'package:sports_spotter/constants.dart';
import 'package:sports_spotter/models/result_model.dart';

class ResultView extends StatelessWidget {
  final ResultModel result;
  const ResultView({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text(
            '${result.event!.title} result',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
          Text(
              'Event date: ${result.event?.lastDate.toString().substring(0, 10)}'),
          Text(
              'Declared on: ${result.declareDate.toString().substring(0, 10)}'),
          const Divider(),
          space16,
          Image.asset(
            'assets/trophy.png',
            height: 160,
          ),
          space16,
          if (result.winner != null)
            Text(
              '#1 ${result.winner?.name}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
          space16,
          space16,
          ElevatedButton(
              onPressed: () {},
              child: const Text(
                'Close',
                style: TextStyle(fontWeight: FontWeight.bold),
              ))
        ],
      ),
    );
  }
}
