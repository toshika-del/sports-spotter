import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sports_spotter/api/auth.dart';
import 'package:sports_spotter/constants.dart';
import 'package:sports_spotter/widgets/profile_details.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: ListView(
        children: [
          const Image(
            image: AssetImage(
              'assets/login_avtar.png',
            ),
            height: 200,
          ),
          FutureBuilder(
              future: Auth.getUser(),
              builder: (context, snapshot) {
                final data = snapshot.data;
                if (data != null) {
                  return ProfileDetails(
                      firstName: data['first_name'],
                      lastName: data['last_name'],
                      username: data['username'],
                      email: data['email']);
                }
                return loader;
              }),
          const Divider(),
          ListTile(
            title: const Text('Performane Tracking'),
            subtitle:
                const Text('Track all time performance and perks in sports'),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Results And Rankings'),
            subtitle: const Text('Check event results and rankings'),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            title: const Text('Contact Us'),
            subtitle:
                const Text('Contact sports department for any issue or query'),
            onTap: () {},
          ),
          ListTile(
            title: const Text('About Us'),
            subtitle: const Text('Know more about Sports Spotter'),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            title: const Text('Feedback'),
            subtitle: const Text('Help us improve'),
            onTap: () {},
          ),
          ListTile(
            title: const Text('About App'),
            subtitle: const Text(version),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(FontAwesomeIcons.arrowRightFromBracket),
            iconColor: Colors.red.shade400,
            title: Text(
              'Log Out',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.red.shade400),
            ),
            onTap: () {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) => AlertDialog(
                        title: const Text('Logout?'),
                        content: const Text(
                            'Are you sure want to logout of Sports Spotter? You will no longer recive updates about sports events.'),
                        actions: [
                          TextButton(
                              style: TextButton.styleFrom(
                                  foregroundColor: Colors.red.shade400),
                              onPressed: () {
                                Auth.logout().then((value) {
                                  Navigator.pop(context);
                                  Navigator.popUntil(
                                      context, ModalRoute.withName('/home/'));
                                  showSnackbar(
                                      context, const Text('Logged out'));
                                });
                              },
                              child: const Text('Logout')),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Cancel'))
                        ],
                      ));
            },
          ),
        ],
      ),
    );
  }
}
