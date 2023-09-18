import 'package:flutter/material.dart';
import 'package:sports_spotter/constants.dart';

class ProfileDetails extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String username;
  final String email;
  const ProfileDetails(
      {super.key,
      required this.firstName,
      required this.lastName,
      required this.username,
      required this.email});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: paddingAll16,
      child: Column(
        children: [
          Text(
            '$firstName $lastName',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            username,
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
          Text(email),
        ],
      ),
    );
  }
}
