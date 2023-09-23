import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sports_spotter/constants.dart';
import 'package:sports_spotter/models/event.dart';
import 'package:sports_spotter/models/team_model.dart';
import 'package:sports_spotter/widgets/nothing_to_show.dart';
import 'package:sports_spotter/widgets/team_details.dart';

class TeamsByEventScreen extends StatefulWidget {
  final EventModel model;
  const TeamsByEventScreen({super.key, required this.model});

  @override
  State<TeamsByEventScreen> createState() => _TeamsByEventScreenState();
}

class _TeamsByEventScreenState extends State<TeamsByEventScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        '${widget.model.title} Teams',
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontWeight: FontWeight.bold),
      )),
      body: Center(
        child: FutureBuilder(
            future: TeamModel.getTeamsByEvent(widget.model.id),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final teams = snapshot.data!;
                if (teams.isEmpty) {
                  return NothingToShow(refresh: () {});
                }
                return ListView.separated(
                    itemCount: teams.length,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) => ListTile(
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                useSafeArea: true,
                                showDragHandle: true,
                                builder: (context) => Container(
                                    width: double.maxFinite,
                                    padding: paddingAll24,
                                    child: TeamDetails(model: teams[index]!)));
                          },
                          title: Text(teams[index]!.name),
                          leading: const Icon(FontAwesomeIcons.users),
                          subtitle: Text(teams[index]!.captain.username),
                        ));
              }
              return loader;
            }),
      ),
    );
  }
}
