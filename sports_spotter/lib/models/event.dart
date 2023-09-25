import 'dart:convert';
import 'package:sports_spotter/api/auth.dart';
import 'package:sports_spotter/constants.dart';
import 'package:http/http.dart' as http;

class EventModel {
  final String id;
  final String title;
  final String description;
  final String imgUrl;
  final DateTime postedOn;
  final DateTime lastDate;
  final DateTime eventDate;
  const EventModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imgUrl,
    required this.postedOn,
    required this.lastDate,
    required this.eventDate,
  });

  @override
  String toString() {
    return '$title $postedOn $lastDate';
  }

  static Future<EventModel?> getEvent(String id) async {
    final headers = {'Authorization': 'Token ${Auth.token}'};
    final response =
        await http.get(Uri.parse('$baseUrl/events/$id/'), headers: headers);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
      return EventModel(
          id: data['id'],
          title: data['attributes']['title'],
          description: data['attributes']['description'],
          imgUrl: data['attributes']['image_url'],
          postedOn: DateTime.parse(data['attributes']['activate_date']),
          lastDate: DateTime.parse(data['attributes']['deactivate_date']),
          eventDate: DateTime.parse(data['attributes']['event_date']));
    }
    return null;
  }
}
