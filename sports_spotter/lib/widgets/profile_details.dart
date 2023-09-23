import 'package:flutter/material.dart';
import 'package:sports_spotter/constants.dart';
import 'package:sports_spotter/models/user_model.dart';

class ProfileDetails extends StatelessWidget {
  final UserModel user;
  const ProfileDetails({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: paddingAll16,
      child: Column(
        children: [
          Text(
            '${user.firstName} ${user.lastName}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            user.username,
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
          Text(user.email),
        ],
      ),
    );
  }
}
