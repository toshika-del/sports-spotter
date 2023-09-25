import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:sports_spotter/api/alerts.dart';
import 'package:sports_spotter/constants.dart';
import 'package:sports_spotter/widgets/error_widget.dart';
import 'package:sports_spotter/widgets/nothing_to_show.dart';

class Alerts extends StatefulWidget {
  const Alerts({super.key});

  @override
  State<Alerts> createState() => _AlertsState();
}

class _AlertsState extends State<Alerts> {
  var response = fetchAlerts();
  @override
  Widget build(BuildContext context) {
    return LiquidPullToRefresh(
      color: primaryColor,
      showChildOpacityTransition: false,
      onRefresh: () async {
        setState(() {
          response = fetchAlerts();
        });
        return;
      },
      child: Center(
        child: FutureBuilder(
            future: response,
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.isEmpty) {
                  return NothingToShow(
                    refresh: () {
                      setState(() {});
                    },
                  );
                }
                final data = snapshot.data!;
                return ListView.separated(
                    padding: paddingAll8,
                    itemCount: data.length,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: const Icon(FontAwesomeIcons.solidBell),
                        title: Text(data[index].title),
                        subtitle: Text(
                            '${data[index].description}\n${data[index].timeAgo}'),
                      );
                    });
              }
              return ErrorMessage(
                refresh: () {
                  setState(() {});
                },
              );
            })),
      ),
    );
  }
}
