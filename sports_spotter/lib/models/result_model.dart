import 'dart:convert';

import 'package:sports_spotter/constants.dart';
import 'package:sports_spotter/models/event.dart';
import 'package:sports_spotter/models/team_model.dart';
import 'package:http/http.dart' as http;

class ResultModel {
  final String id;
  final TeamModel? winner;
  final EventModel? event;
  final DateTime declareDate;
  const ResultModel(
      {required this.id,
      required this.winner,
      required this.declareDate,
      required this.event});

  static Future<List<ResultModel>?> getResults() async {
    final response = await http.get(Uri.parse('$baseUrl/results/'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['data'];
      final results = List<ResultModel>.empty(growable: true);
      for (var res in data) {
        final item = ResultModel(
            id: res['id'],
            winner: await TeamModel.getTeam(
                res['relationships']['winner']['data']['id']),
            declareDate: DateTime.parse(res['attributes']['declare_date']),
            event: await EventModel.getEvent(
                res['relationships']['event']['data']['id']));
        results.add(item);
      }
      return results;
    }
    return null;
  }

  static Future<ResultModel?> getResult(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/results/$id'));
    if (response.statusCode == 200) {
      final res = jsonDecode(response.body)['data'];
      return ResultModel(
          id: res['id'],
          winner: await TeamModel.getTeam(
              res['relationships']['winner']['data']['id']),
          declareDate: DateTime.parse(res['attributes']['declare_date']),
          event: await EventModel.getEvent(
              res['relationships']['event']['data']['id']));
    }
    return null;
  }

  @override
  String toString() {
    return '${event?.title ?? 'Event'} result';
  }
}
