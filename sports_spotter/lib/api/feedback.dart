import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sports_spotter/constants.dart';

class FeedbackApi {
  static Future<int> postFeedback(
      String title, String description, String email) async {
    final body = {"title": title, "description": description, "email": email};
    final response = await http.post(Uri.parse('$baseUrl/feedback/'),
        body: jsonEncode(body));
    return response.statusCode;
  }
}
