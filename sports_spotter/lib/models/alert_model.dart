class AlertModel {
  final String id;
  final String title;
  final String description;
  final DateTime sentOn;
  late String timeAgo;
  AlertModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.sentOn}) {
    final now = DateTime.now();
    if (sentOn.difference(sentOn).inDays != 0) {
      timeAgo = '${now.difference(sentOn).inDays.toString()} Days ago';
    } else if (now.difference(sentOn).inHours != 0) {
      timeAgo = '${now.difference(sentOn).inHours.toString()} Hours ago';
    } else if (now.difference(sentOn).inMinutes != 0) {
      timeAgo = '${now.difference(sentOn).inMinutes.toString()} Minutes ago';
    } else {
      timeAgo = 'Now';
    }
  }
}
