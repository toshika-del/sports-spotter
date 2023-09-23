import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:sports_spotter/constants.dart';
import 'package:sports_spotter/models/team_model.dart';
import 'package:sports_spotter/models/user_model.dart';
import 'package:sports_spotter/widgets/nothing_to_show.dart';
import 'package:sports_spotter/widgets/team_details.dart';

class MyTeamsScreen extends StatefulWidget {
  final UserModel user;
  const MyTeamsScreen({
    super.key,
    required this.user,
  });

  @override
  State<MyTeamsScreen> createState() => _MyTeamsScreenState();
}

class _MyTeamsScreenState extends State<MyTeamsScreen> {
  int _selectedFilter = 0;
  late Future<List<TeamModel?>?> _teams;
  @override
  void initState() {
    _teams = getTeams(_selectedFilter);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> filters = [
      'Joined by me',
      'Created by me',
    ];
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        'My Teams',
      )),
      body: Column(
        children: [
          Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: paddingAll8,
                child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: filters.map((e) {
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ActionChip(
                          label: Text(
                            e,
                            style: TextStyle(
                              color: _selectedFilter == filters.indexOf(e)
                                  ? Colors.white
                                  : null,
                            ),
                          ),
                          backgroundColor: _selectedFilter == filters.indexOf(e)
                              ? primaryColor
                              : null,
                          onPressed: () {
                            setState(() {
                              _selectedFilter = filters.indexOf(e);
                              _teams = getTeams(_selectedFilter);
                            });
                          },
                        ),
                      );
                    }).toList()),
              ),
            ),
          ),
          Expanded(
              child: FutureBuilder(
            future: _teams,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final data = snapshot.data!;
                if (data.isEmpty) {
                  return NothingToShow(refresh: () {
                    setState(() {
                      _teams = getTeams(_selectedFilter);
                    });
                  });
                }
                return LiquidPullToRefresh(
                  showChildOpacityTransition: false,
                  color: primaryColor,
                  onRefresh: () async {
                    setState(() {
                      _teams = getTeams(_selectedFilter);
                    });
                  },
                  child: ListView.separated(
                      itemCount: data.length,
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
                                      child: TeamDetails(
                                        model: data[index]!,
                                        user: widget.user,
                                        callback: () {
                                          setState(() {
                                            _teams = getTeams(_selectedFilter);
                                          });
                                        },
                                      )));
                            },
                            title: Text(data[index]!.name),
                            leading: const Icon(FontAwesomeIcons.users),
                            subtitle: Text(data[index]!.captain.username),
                          )),
                );
              }
              return loader;
            },
          ))
        ],
      ),
    );
  }

  Future<List<TeamModel?>?> getTeams(int filter) async {
    switch (filter) {
      case 0:
        return TeamModel.getTeamsByMember(widget.user.username);
      case 1:
        return TeamModel.getTeamsByCaptain(widget.user.username);
    }
    return null;
  }
}
