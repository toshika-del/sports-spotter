import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:sports_spotter/constants.dart';

class Feedback {
  Future<dynamic> post(String title, String description, String email) async {
    final body = {"title": title, "description": description, "email": email};
    final response = await http.post(
        Uri.parse('${Platform.isAndroid ? baseUrl : baseUrlIOS}/alerts/'),
        body: body);
    return response.statusCode;
  }
}
