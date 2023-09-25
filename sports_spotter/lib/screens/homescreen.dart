import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sports_spotter/api/auth.dart';
import 'package:sports_spotter/components/alerts.dart';
import 'package:sports_spotter/components/events_calandar.dart';
import 'package:sports_spotter/components/home.dart';
import 'package:sports_spotter/constants.dart';
import 'package:sports_spotter/widgets/add_event.dart';

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
        leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/profile/');
            },
            icon: const Icon(FontAwesomeIcons.solidUser)),
        // actions: [
        //   IconButton(
        //       onPressed: () {},
        //       icon: const Icon(
        //         FontAwesomeIcons.magnifyingGlass,
        //         size: 20,
        //       ))
        // ],
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
              icon: Icon(FontAwesomeIcons.solidCalendar), label: 'Calandar'),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.solidBell), label: 'Notifications'),
        ],
        onTap: (value) {
          setState(() {
            navIndex = value;
          });
        },
      ),
      floatingActionButton: Auth.isStaff && navIndex == 0
          ? FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () {
                showModalBottomSheet(
                    isScrollControlled: true,
                    useSafeArea: true,
                    showDragHandle: true,
                    context: context,
                    builder: (context) => const SingleChildScrollView(
                          child: Padding(
                            padding: paddingAll24,
                            child: AddEvent(),
                          ),
                        ));
              })
          : null,
    );
  }
}
