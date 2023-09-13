import 'dart:io' show Platform;
import 'package:http/http.dart' as http;
import 'package:sports_spotter/constants.dart';
import 'dart:convert';

Future<List?> fetchAlerts() async {
  const headers = {'Authorization': 'Token $token'};
  final response = await http.get(
      Uri.parse('${Platform.isAndroid ? baseUrl : baseUrlIOS}/posts/'),
      headers: headers);
  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body)['data'];
    final content = data.map((item) => item['attributes']).toList();
    return content;
  }
  return null;
}
