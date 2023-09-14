import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:sports_spotter/constants.dart';

class Auth {
  static String? _token;

  static String? get token {
    return _token;
  }

  static Stream<String?> tokenChanges =
      Stream.periodic(const Duration(seconds: 1), (v) {
    return _token;
  });

  static Future<dynamic> login(String username, String password) async {
    final body = {"username": username, "password": password};
    final response = await http.post(
        Uri.parse('${Platform.isAndroid ? baseUrl : baseUrlIOS}/login/'),
        body: jsonEncode(body));
    if (response.statusCode == 200) {
      _token = '${jsonDecode(response.body)['token']}';
      return jsonDecode('{"status_code":200, "body": ${response.body}}');
    }
    return {"status_code": response.statusCode};
  }
}
