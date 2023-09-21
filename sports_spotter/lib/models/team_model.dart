class TeamModel {
  final String id;
  final String name;
  final String captainUsername;
  final int size;
  final List<Object> members;

  TeamModel(
      {required this.id,
      required this.name,
      required this.size,
      required this.captainUsername,
      required this.members});
}
