class EventModel {
  final String id;
  final String title;
  final String description;
  final String imgUrl;
  final DateTime postedOn;
  final DateTime lastDate;
  const EventModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imgUrl,
    required this.postedOn,
    required this.lastDate,
  });

  @override
  String toString() {
    return '$title $postedOn $lastDate';
  }
}
