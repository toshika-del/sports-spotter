import 'package:flutter/material.dart';
import 'package:sports_spotter/constants.dart';
import 'package:sports_spotter/models/team_model.dart';

class TeamDetails extends StatelessWidget {
  final TeamModel model;
  const TeamDetails({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          model.name,
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        Text(
            'By ${model.captain.firstName} ${model.captain.lastName} (${model.captain.username})'),
        Text(
          'Total members: ${model.members.length}/${model.size}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        space8,
        const Divider(),
        space8,
        Expanded(
            child: Scrollbar(
          child: ListView.builder(
              itemCount: model.members.length,
              itemBuilder: (context, index) => ListTile(
                    title: Text(model.members[index].toString()),
                    subtitle: Text(model.members[index]!.username),
                  )),
        )),
        FilledButton(
            onPressed: model.members.length < model.size ? () {} : null,
            child: const Text('Join Team')),
        space8,
        FilledButton(
            style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(errorColor)),
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Close'))
      ],
    );
  }
}
