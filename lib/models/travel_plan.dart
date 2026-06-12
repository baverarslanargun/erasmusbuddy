class TravelPlan {
  final String id;
  final String title;
  final String country;
  final List<String> cities;
  final String duration;
  final List<String> placesToVisit;
  final String note;
  final String createdBy;
  final DateTime createdAt;

  TravelPlan({
    required this.id,
    required this.title,
    required this.country,
    required this.cities,
    required this.duration,
    required this.placesToVisit,
    required this.note,
    required this.createdBy,
    required this.createdAt,
  });
}
