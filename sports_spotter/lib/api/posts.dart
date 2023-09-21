import 'package:http/http.dart' as http;
import 'package:sports_spotter/api/auth.dart';
import 'package:sports_spotter/constants.dart';
import 'dart:convert';
import 'dart:io' show Platform;

import 'package:sports_spotter/models/event.dart';

Future<List<EventModel>?> fetchPosts() async {
  final headers = {'Authorization': 'Token ${Auth.token}'};
  final response = await http.get(
      Uri.parse('${Platform.isAndroid ? baseUrl : baseUrlIOS}/events/'),
      headers: headers);
  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body)['data'];
    final content = data
        .map((item) => EventModel(
            id: item['id'],
            title: item['attributes']['title'],
            description: item['attributes']['description'],
            imgUrl: item['attributes']['image_url']))
        .toList();
    return content;
  }
  return null;
}
