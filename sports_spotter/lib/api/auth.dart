import 'dart:convert';
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
    final response =
        await http.post(Uri.parse('$baseUrl/login/'), body: jsonEncode(body));
    if (response.statusCode == 200) {
      _token = '${jsonDecode(response.body)['token']}';
      return jsonDecode('{"status_code":200, "body": ${response.body}}');
    }
    return {"status_code": response.statusCode};
  }

  static Future<dynamic> logout() async {
    _token = null;
    return {"status_code": 200, "message": "logged out"};
  }

  static Future<dynamic> getUser() async {
    final body = {"token": _token};
    final response = await http.post(Uri.parse('$baseUrl/get_user/'),
        body: jsonEncode(body));
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data']['attributes'];
    }
    return null;
  }

  static Future<dynamic> register(String username, String email,
      String password, String firstName, String lastName) async {
    final body = {
      "username": username,
      "password": password,
      "email": email,
      "first_name": firstName,
      "last_name": lastName
    };
    final response = await http.post(Uri.parse('$baseUrl/register/'),
        body: jsonEncode(body));
    if (response.statusCode == 200) {
      _token = jsonDecode(response.body)['token'];
      return jsonDecode('{"status_code":200, "body": ${response.body}}');
    }
    return {"status_code": response.statusCode};
  }
}
