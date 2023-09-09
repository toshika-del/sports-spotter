import 'package:http/http.dart' as http;
import 'package:sports_spotter/constants.dart';
import 'dart:convert';

Future<List?> fetchAlerts() async {
  const headers = {
    'Authorization': 'Token 04307c770ead0e4eefe3ecb52b70eea49a0ba1fd'
  };
  final response =
      await http.get(Uri.parse('$baseUrl/alerts/'), headers: headers);
  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body)['data'];
    final content = data.map((item) => item['attributes']).toList();
    return content;
  }
  return null;
}
