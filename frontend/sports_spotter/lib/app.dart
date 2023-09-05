import 'package:flutter/material.dart';
import 'package:sports_spotter/constants.dart';
import 'package:sports_spotter/screens/homescreen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      home: const HomeScreen(),
      theme: ThemeData(
        useMaterial3: false,
      ),
    );
  }
}
