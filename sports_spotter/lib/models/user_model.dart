import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:sports_spotter/api/auth.dart';
import 'package:sports_spotter/constants.dart';

class UserModel {
  final String username;
  final String email;
  final String id;
  final String firstName;
  final String lastName;

  UserModel(
      {required this.username,
      required this.email,
      required this.id,
      required this.firstName,
      required this.lastName});

  static Future<UserModel?> getUserById(String id) async {
    final response = await http.get(Uri.parse(
        '${Platform.isAndroid ? baseUrl : baseUrlIOS}/get-user-by-id/$id'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'];
      return UserModel(
          username: data['attributes']['username'],
          email: data['attributes']['email'],
          id: data['id'],
          firstName: data['attributes']['first_name'],
          lastName: data['attributes']['last_name']);
    }
    return null;
  }

  static Future<UserModel?> getCurrentUser() async {
    final body = {"token": Auth.token};
    final response = await http.post(
        Uri.parse('${Platform.isAndroid ? baseUrl : baseUrlIOS}/get_user/'),
        body: jsonEncode(body));
    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'];
      return UserModel(
          username: data['attributes']['username'],
          email: data['attributes']['email'],
          id: data['id'],
          firstName: data['attributes']['first_name'],
          lastName: data['attributes']['last_name']);
    }
    return null;
  }
}
