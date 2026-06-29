import 'package:cloud_firestore/cloud_firestore.dart';

class TravelIdea {
  const TravelIdea({
    required this.id,
    required this.title,
    required this.destination,
    required this.description,
    required this.duration,
    required this.budget,
    required this.createdBy,
    required this.createdByName,
    required this.createdAt,
  });

  final String id;
  final String title;
  final String destination;
  final String description;
  final String duration;
  final String budget;
  final String createdBy;
  final String createdByName;
  final DateTime createdAt;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'destination': destination,
      'description': description,
      'duration': duration,
      'budget': budget,
      'createdBy': createdBy,
      'createdByName': createdByName,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  static DateTime parseCreatedAt(dynamic value) {
    if (value is Timestamp) {
      return value.toDate();
    }

    if (value is DateTime) {
      return value;
    }

    if (value is String) {
      return DateTime.tryParse(value) ?? DateTime.now();
    }

    return DateTime.now();
  }

  factory TravelIdea.fromMap(Map<String, dynamic> map) {
    return TravelIdea(
      id: map['id'] as String? ?? '',
      title: map['title'] as String? ?? '',
      destination: map['destination'] as String? ?? '',
      description: map['description'] as String? ?? '',
      duration: map['duration'] as String? ?? '',
      budget: map['budget'] as String? ?? '',
      createdBy: map['createdBy'] as String? ?? '',
      createdByName: map['createdByName'] as String? ?? 'Erasmus student',
      createdAt: parseCreatedAt(map['createdAt']),
    );
  }
}
