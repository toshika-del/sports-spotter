import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sports_spotter/constants.dart';
import 'package:sports_spotter/models/event.dart';
import 'package:sports_spotter/models/team_model.dart';
import 'package:sports_spotter/models/user_model.dart';

class CreateTeamWidget extends StatefulWidget {
  final EventModel model;
  const CreateTeamWidget({super.key, required this.model});

  @override
  State<CreateTeamWidget> createState() => _CreateTeamWidgetState();
}

class _CreateTeamWidgetState extends State<CreateTeamWidget> {
  final name = TextEditingController();
  final size = TextEditingController();
  bool enableCreateTeamButton = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: paddingAll24,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            onChanged: (value) {
              setState(() {
                enableCreateTeamButton =
                    value.isNotEmpty && size.text.isNotEmpty;
              });
            },
            controller: name,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
                hintText: 'Team name',
                prefixIcon: Icon(FontAwesomeIcons.users)),
          ),
          space16,
          TextField(
            onChanged: (value) {
              setState(() {
                enableCreateTeamButton =
                    value.isNotEmpty && name.text.isNotEmpty;
              });
            },
            controller: size,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
                hintText: 'Team size', prefixIcon: Icon(Icons.numbers)),
          ),
          space16,
          ElevatedButton(
              onPressed: enableCreateTeamButton
                  ? () async {
                      TeamModel.createTeam(
                              name: name.text.trim(),
                              captainUsername:
                                  (await UserModel.getCurrentUser())!.username,
                              eventId: widget.model.id,
                              size: int.parse(size.text.trim()))
                          .then((value) {
                        Navigator.pop(context);
                      });
                    }
                  : null,
              child: const Text('Create Team'))
        ],
      ),
    );
  }
}
