import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:erasmusbuddy/models/travel_idea.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const baseData = {
    'id': 'idea-1',
    'title': 'Weekend in Prague',
    'destination': 'Prague, Czechia',
    'description': 'Explore the old town with fellow students.',
    'duration': '3 days',
    'budget': '€250',
    'createdBy': 'user-1',
    'createdByName': 'Alex',
  };

  group('TravelIdea.fromMap', () {
    test('reads a Firestore Timestamp', () {
      final createdAt = DateTime.utc(2026, 6, 29, 12, 30);
      final idea = TravelIdea.fromMap({
        ...baseData,
        'createdAt': Timestamp.fromDate(createdAt),
      });

      expect(idea.id, 'idea-1');
      expect(idea.createdAt.isAtSameMomentAs(createdAt), isTrue);
    });

    test('keeps compatibility with legacy ISO 8601 strings', () {
      const legacyCreatedAt = '2026-05-10T08:15:30.000Z';
      final idea = TravelIdea.fromMap({
        ...baseData,
        'createdAt': legacyCreatedAt,
      });

      expect(idea.createdAt, DateTime.parse(legacyCreatedAt));
    });
  });

  test('TravelIdea.toMap writes createdAt as a Firestore Timestamp', () {
    final createdAt = DateTime.utc(2026, 6, 29, 12, 30);
    final idea = TravelIdea(
      id: 'idea-1',
      title: 'Weekend in Prague',
      destination: 'Prague, Czechia',
      description: 'Explore the old town with fellow students.',
      duration: '3 days',
      budget: '€250',
      createdBy: 'user-1',
      createdByName: 'Alex',
      createdAt: createdAt,
    );

    final map = idea.toMap();

    expect(map['createdAt'], isA<Timestamp>());
    expect(
      (map['createdAt'] as Timestamp).toDate().isAtSameMomentAs(createdAt),
      isTrue,
    );
    expect(map['createdBy'], 'user-1');
  });
}
