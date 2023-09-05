import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sports_spotter/components/alerts.dart';
import 'package:sports_spotter/components/events_calandar.dart';
import 'package:sports_spotter/components/home.dart';
import 'package:sports_spotter/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var navIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(title),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                FontAwesomeIcons.magnifyingGlass,
                size: 20,
              ))
        ],
      ),
      body: IndexedStack(
        index: navIndex,
        children: const [Home(), EventsCalandar(), Alerts()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navIndex,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.house), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.calendar), label: 'Calandar'),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.bell), label: 'Notifications'),
        ],
        onTap: (value) {
          setState(() {
            navIndex = value;
          });
        },
      ),
    );
  }
}
