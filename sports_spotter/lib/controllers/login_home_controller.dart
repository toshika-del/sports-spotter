import 'package:flutter/material.dart';
import 'package:sports_spotter/api/auth.dart';
import 'package:sports_spotter/screens/homescreen.dart';
import 'package:sports_spotter/screens/loginscreen.dart';

class LoginHomeController extends StatefulWidget {
  const LoginHomeController({super.key});

  @override
  State<LoginHomeController> createState() => _LoginHomeControllerState();
}

class _LoginHomeControllerState extends State<LoginHomeController> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Auth.tokenChanges,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomeScreen();
          }
          return const LoginScreen();
        });
  }
}
