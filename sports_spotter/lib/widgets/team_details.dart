import 'package:flutter/material.dart';
import 'package:sports_spotter/constants.dart';
import 'package:sports_spotter/models/team_model.dart';
import 'package:sports_spotter/models/user_model.dart';

class TeamDetails extends StatelessWidget {
  final TeamModel model;
  final UserModel user;
  final Function() callback;
  const TeamDetails(
      {super.key,
      required this.model,
      required this.user,
      required this.callback});

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
                    title: Text(
                      model.members[index].toString(),
                      style: TextStyle(
                          color: user.username == model.members[index]?.username
                              ? primaryColor
                              : null),
                    ),
                    subtitle: Text(
                      model.members[index]!.username,
                      style: TextStyle(
                          color: user.username == model.members[index]?.username
                              ? primaryColor
                              : null),
                    ),
                  )),
        )),
        Row(
          children: [
            Expanded(
              child: FilledButton(
                  onPressed: model.members.length < model.size &&
                          !model.isCreatedByMe(user)
                      ? () async {
                          showDialog(
                              context: context, builder: (context) => loader);
                          (model.isMyTeam(user)
                                  ? model.removeMember(user.username)
                                  : model.addMember(user.username))
                              .then((value) {
                            if (value != null) {
                              Navigator.pop(context);
                              Navigator.pop(context);
                              showSnackbar(context, const Text('Success!'),
                                  successColor);
                            } else {
                              Navigator.pop(context);
                              Navigator.pop(context);
                              showSnackbar(context,
                                  const Text('Some error occured'), errorColor);
                            }
                          });
                          callback();
                        }
                      : null,
                  child:
                      Text(model.isMyTeam(user) ? 'Leave Team' : 'Join Team')),
            ),
            if (model.isCreatedByMe(user)) space8,
            if (model.isCreatedByMe(user))
              Expanded(
                  child: FilledButton(
                      onPressed: () {
                        showDialog(
                            context: context, builder: (context) => loader);
                        model.deleteTeam().then((value) {
                          if (value == 200) {
                            showSnackbar(
                                context, Text('\'${model.name}\' deleted'));
                          } else if (value == 404) {
                            showSnackbar(
                                context,
                                Text('\'${model.name}\' not found'),
                                errorColor);
                          } else {
                            showSnackbar(context,
                                const Text('Some error occured'), errorColor);
                          }
                          Navigator.pop(context);
                          Navigator.pop(context);
                        });
                        callback();
                      },
                      child: const Text('Delete Team')))
          ],
        ),
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
