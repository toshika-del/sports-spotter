import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sports_spotter/api/auth.dart';
import 'package:sports_spotter/constants.dart';
import 'package:sports_spotter/models/user_model.dart';
import 'package:sports_spotter/screens/myteamsscreen.dart';
import 'package:sports_spotter/screens/performancescreen.dart';
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
              future: UserModel.getCurrentUser(),
              builder: (context, snapshot) {
                final data = snapshot.data;
                if (data != null) {
                  return ProfileDetails(
                    user: snapshot.data!,
                  );
                }
                return loader;
              }),
          const Divider(),
          if (Auth.isStaff)
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, '/admin_panel/');
              },
              title: const Text('Admin panel'),
              subtitle: const Text('Manage events, alerts, results and more'),
            ),
          if (!Auth.isStaff)
            ListTile(
              title: const Text('Performane Tracking'),
              subtitle:
                  const Text('Track all time performance and perks in sports'),
              onTap: () async {
                UserModel.getCurrentUser().then((user) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              PerformanceScreen(user: user!)));
                });
              },
            ),
          ListTile(
            title: const Text('Results And Rankings'),
            subtitle: const Text('Check event results and rankings'),
            onTap: () {
              Navigator.pushNamed(context, '/results/');
            },
          ),
          if (!Auth.isStaff)
            ListTile(
              title: const Text('Teams'),
              subtitle: const Text('Teams created and joined by me'),
              onTap: () async {
                UserModel.getCurrentUser().then((user) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyTeamsScreen(user: user!)));
                });
              },
            ),
          const Divider(),
          ListTile(
            title: const Text('Contact Us'),
            subtitle:
                const Text('Contact sports department for any issue or query'),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) => Dialog(
                        child: Padding(
                          padding: paddingAll16,
                          child:
                              Column(mainAxisSize: MainAxisSize.min, children: [
                            const Text(
                              'Contact Us',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22),
                            ),
                            space8,
                            const Icon(
                              Icons.email,
                              size: 72,
                            ),
                            const Text(
                              'Email: email@example.com',
                              style: TextStyle(fontSize: 16),
                            ),
                            const Text('Phone: 9876543210',
                                style: TextStyle(fontSize: 16)),
                            space16,
                            FilledButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Close'))
                          ]),
                        ),
                      ));
            },
          ),
          ListTile(
            title: const Text('About Us'),
            subtitle: const Text('Know more about Sports Spotter'),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: const Text(
                          title,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        content: const Text(
                          intro,
                          textAlign: TextAlign.justify,
                        ),
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Close'))
                        ],
                      ));
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Feedback'),
            subtitle: const Text('Help us improve'),
            onTap: () {
              Navigator.pushNamed(context, '/feedback/');
            },
          ),
          ListTile(
            title: const Text('About App'),
            subtitle: const Text(version),
            onTap: () {
              showAboutDialog(
                  context: context,
                  applicationVersion: version,
                  applicationIcon: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'assets/launcher_icon.png',
                      height: 54,
                    ),
                  ));
            },
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
