import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:erasmusbuddy/models/travel_idea.dart';

class TravelIdeaService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String _collectionName = 'travel_ideas';

  Future<void> createTravelIdea(TravelIdea idea) async {
    try {
      await _firestore.collection(_collectionName).doc(idea.id).set(idea.toMap());
    } catch (e) {
      throw Exception('Failed to create travel idea: $e');
    }
  }

  Stream<List<TravelIdea>> getTravelIdeas() {
    return _firestore
        .collection(_collectionName)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => TravelIdea.fromMap(doc.data()))
          .toList();
    });
  }

  Future<TravelIdea?> getTravelIdeaById(String id) async {
    try {
      final doc = await _firestore.collection(_collectionName).doc(id).get();
      if (doc.exists) {
        return TravelIdea.fromMap(doc.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to fetch travel idea: $e');
    }
  }
}