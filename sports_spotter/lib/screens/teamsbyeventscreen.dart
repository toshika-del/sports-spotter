import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:sports_spotter/constants.dart';
import 'package:sports_spotter/models/event.dart';
import 'package:sports_spotter/models/team_model.dart';
import 'package:sports_spotter/models/user_model.dart';
import 'package:sports_spotter/widgets/nothing_to_show.dart';
import 'package:sports_spotter/widgets/team_details.dart';

class TeamsByEventScreen extends StatefulWidget {
  final EventModel model;
  const TeamsByEventScreen({super.key, required this.model});

  @override
  State<TeamsByEventScreen> createState() => _TeamsByEventScreenState();
}

class _TeamsByEventScreenState extends State<TeamsByEventScreen> {
  late Future<List<TeamModel?>?> teamsData;
  @override
  void initState() {
    teamsData = TeamModel.getTeamsByEvent(widget.model.id);
    super.initState();
  }

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
            future: teamsData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final teams = snapshot.data!;
                if (teams.isEmpty) {
                  return NothingToShow(refresh: () {
                    setState(() {
                      teamsData = TeamModel.getTeamsByEvent(widget.model.id);
                    });
                  });
                }
                return LiquidPullToRefresh(
                  showChildOpacityTransition: false,
                  color: primaryColor,
                  onRefresh: () async {
                    setState(() {
                      teamsData = TeamModel.getTeamsByEvent(widget.model.id);
                    });
                  },
                  child: ListView.separated(
                      itemCount: teams.length,
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, index) => ListTile(
                            onTap: () async {
                              UserModel.getCurrentUser().then((user) {
                                if (user == null) {
                                  return;
                                }
                                showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    useSafeArea: true,
                                    showDragHandle: true,
                                    builder: (context) => Container(
                                        width: double.maxFinite,
                                        padding: paddingAll24,
                                        child: TeamDetails(
                                          model: teams[index]!,
                                          user: user,
                                          callback: () {
                                            setState(() {
                                              teamsData =
                                                  TeamModel.getTeamsByEvent(
                                                      widget.model.id);
                                            });
                                          },
                                        )));
                              });
                            },
                            title: Text(teams[index]!.name),
                            leading: const Icon(FontAwesomeIcons.users),
                            subtitle: Text(teams[index]!.captain.username),
                          )),
                );
              }
              return loader;
            }),
      ),
    );
  }
}
