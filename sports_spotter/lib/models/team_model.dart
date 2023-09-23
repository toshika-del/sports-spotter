import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:sports_spotter/constants.dart';
import 'package:sports_spotter/models/user_model.dart';

class TeamModel {
  final String eventId;
  final String name;
  final UserModel captain;
  final int size;
  final List<UserModel?> members;
  final String id;

  TeamModel(
      {required this.id,
      required this.eventId,
      required this.name,
      required this.size,
      required this.captain,
      required this.members});

  static Future<TeamModel?> createTeam(
      {required String name,
      required String captainUsername,
      required String eventId,
      required int size}) async {
    final body = {
      "name": name,
      "captain_username": captainUsername,
      "event_id": eventId,
      "size": size
    };
    final response = await http.post(
        Uri.parse('${Platform.isAndroid ? baseUrl : baseUrlIOS}/create-team/'),
        body: jsonEncode(body));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return await TeamModel.getTeam(data['id']);
    }
    return null;
  }

  Future<TeamModel?> addMember(String username) async {
    final body = {"username": username};
    final response = await http.post(
        Uri.parse(
            '${Platform.isAndroid ? baseUrl : baseUrlIOS}/teams/$id/add-member/'),
        body: jsonEncode(body));
    if (response.statusCode == 200) {
      return this;
    }
    return null;
  }

  Future<TeamModel?> removeMember(String username) async {
    final body = {"username": username};
    final response = await http.post(
        Uri.parse(
            '${Platform.isAndroid ? baseUrl : baseUrlIOS}/teams/$id/remove-member/'),
        body: jsonEncode(body));
    if (response.statusCode == 200) {
      return this;
    }
    return null;
  }

  static Future<TeamModel?> getTeam(String id) async {
    final response = await http.get(
        Uri.parse('${Platform.isAndroid ? baseUrl : baseUrlIOS}/teams/$id/'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'];
      final captain = await UserModel.getUserById(
          data['relationships']['captain']['data']['id']);
      List<UserModel?> members = List.empty(growable: true);
      for (var member
          in (data['relationships']['members']['data'] as List<dynamic>)) {
        members.add(await UserModel.getUserById(member['id']));
      }
      return TeamModel(
          id: data['id'],
          eventId: data['relationships']['event']['data']['id'],
          name: data['attributes']['name'],
          size: data['attributes']['size'],
          captain: captain!,
          members: members);
    }
    return null;
  }

  static Future<List<TeamModel?>?> getAllTeams() async {
    final response = await http
        .get(Uri.parse('${Platform.isAndroid ? baseUrl : baseUrlIOS}/teams/'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['data'];
      final List<TeamModel?> teams = List.empty(growable: true);
      for (var element in data) {
        teams.add(await TeamModel.getTeam(element['id']));
      }
      return teams;
    }
    return null;
  }

  static Future<List<TeamModel?>?> getTeamsByEvent(String eventId) async {
    final response = await http
        .get(Uri.parse('${Platform.isAndroid ? baseUrl : baseUrlIOS}/teams/'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['data'];
      final List<TeamModel?> teams = List.empty(growable: true);
      for (var element in data) {
        teams.add(await TeamModel.getTeam(element['id']));
      }
      return teams.where((element) => element?.eventId == eventId).toList();
    }
    return null;
  }

  static Future<List<TeamModel?>?> getTeamsByCaptain(String username) async {
    final response = await http
        .get(Uri.parse('${Platform.isAndroid ? baseUrl : baseUrlIOS}/teams/'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['data'];
      final List<TeamModel?> teams = List.empty(growable: true);
      for (var element in data) {
        teams.add(await TeamModel.getTeam(element['id']));
      }
      return teams
          .where((element) => element?.captain.username == username)
          .toList();
    }
    return null;
  }

  static Future<List<TeamModel?>?> getTeamsByMember(String username) async {
    final response = await http
        .get(Uri.parse('${Platform.isAndroid ? baseUrl : baseUrlIOS}/teams/'));
    if (response.statusCode == 200) {
      final List<TeamModel?>? allTeams = await TeamModel.getAllTeams();
      final List<TeamModel?> myTeams = List.empty(growable: true);
      for (TeamModel? team in allTeams ?? []) {
        if (team!.members.any((element) => element?.username == username)) {
          myTeams.add(team);
        }
      }
      return myTeams;
    }
    return null;
  }

  bool isMyTeam(UserModel user) {
    return members.any((member) => member?.username == user.username);
  }

  bool isCreatedByMe(UserModel user) {
    return captain.username == user.username;
  }

  Future<void> deleteTeam() async {}

  @override
  String toString() {
    return name;
  }
}
