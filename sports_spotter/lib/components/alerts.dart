import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:sports_spotter/api/alerts.dart';
import 'package:sports_spotter/widgets/alert_item.dart';

class Alerts extends StatefulWidget {
  const Alerts({super.key});

  @override
  State<Alerts> createState() => _AlertsState();
}

class _AlertsState extends State<Alerts> {
  var response = fetchAlerts();
  @override
  Widget build(BuildContext context) {
    final refreshButton = IconButton(
        onPressed: () {
          setState(() {
            response = fetchAlerts();
          });
        },
        icon: const Icon(FontAwesomeIcons.arrowRotateRight));

    return LiquidPullToRefresh(
      color: Colors.blue.shade700,
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
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'There is nothing to show',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.blue.shade600,
                            fontWeight: FontWeight.bold),
                      ),
                      refreshButton
                    ],
                  );
                }
                final data = snapshot.data!;
                return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return AlertItem(
                          title: data[index]['title'],
                          description: data[index]['description']);
                    });
              }
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Some error occured',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.red.shade400,
                        fontWeight: FontWeight.bold),
                  ),
                  refreshButton
                ],
              );
            })),
      ),
    );
  }
}
