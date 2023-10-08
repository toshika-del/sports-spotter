import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sports_spotter/constants.dart';
import 'package:sports_spotter/models/result_model.dart';
import 'package:sports_spotter/models/user_model.dart';
import 'package:sports_spotter/widgets/nothing_to_show.dart';

class PerformanceScreen extends StatelessWidget {
  final UserModel user;
  const PerformanceScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final ValueNotifier destination = ValueNotifier(0);
    return Scaffold(
      appBar: AppBar(title: const Text('Performance')),
      body: ValueListenableBuilder(
        valueListenable: destination,
        builder: (context, value, _) => Column(
          children: [
            NavigationBar(
                onDestinationSelected: (d) {
                  destination.value = d;
                },
                selectedIndex: value,
                destinations: const [
                  NavigationDestination(
                      icon: Icon(FontAwesomeIcons.trophy), label: 'Victories'),
                  NavigationDestination(
                      icon: Icon(FontAwesomeIcons.medal), label: 'Overview')
                ]),
            Expanded(
              child: IndexedStack(
                index: value,
                children: [
                  Victories(
                    user: user,
                  ),
                  const Overview()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Victories extends StatelessWidget {
  final UserModel user;
  const Victories({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder(
          future: ResultModel.getResults(),
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data!
                  .where((res) => res.winner!.isMyTeam(user))
                  .toList();
              if (data.isEmpty) {
                return NothingToShow(refresh: () {});
              }
              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) => ListTile(
                        leading: const Icon(FontAwesomeIcons.trophy),
                        title: Text(data[index].event!.title),
                        subtitle: Text(data[index]
                            .event!
                            .eventDate
                            .toString()
                            .substring(0, 10)),
                      ));
            }
            return loader;
          })),
    );
  }
}

class Overview extends StatelessWidget {
  const Overview({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView();
  }
}
