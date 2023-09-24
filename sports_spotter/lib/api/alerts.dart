import 'package:http/http.dart' as http;
import 'package:sports_spotter/api/auth.dart';
import 'package:sports_spotter/constants.dart';
import 'dart:convert';

import 'package:sports_spotter/models/alert_model.dart';

Future<List<AlertModel>?> fetchAlerts() async {
  final headers = {'Authorization': 'Token ${Auth.token}'};
  final response =
      await http.get(Uri.parse('$baseUrl/alerts/'), headers: headers);
  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body)['data'];
    final content = data
        .map((item) => AlertModel(
              id: item['id'],
              title: item['attributes']['title'],
              description: item['attributes']['description'],
              sentOn: DateTime.parse(item['attributes']['activate_date']),
            ))
        .toList();
    return content;
  }
  return null;
}
