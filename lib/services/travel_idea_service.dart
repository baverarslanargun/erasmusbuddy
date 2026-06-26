import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:erasmusbuddy/models/travel_idea.dart';

class TravelIdeaService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String _collectionName = 'travelIdeas';

  Future<void> createTravelIdea(TravelIdea idea) async {
    try {
      final docRef = _firestore.collection(_collectionName).doc();
      final data = idea.toMap();
      data['id'] = docRef.id;

      await docRef.set(data);
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
          .map((doc) {
            final data = doc.data();
            data['id'] = doc.id;
            return TravelIdea.fromMap(data);
          })
          .toList();
    });
  }

  Future<TravelIdea?> getTravelIdeaById(String id) async {
    try {
      final doc = await _firestore.collection(_collectionName).doc(id).get();
      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return TravelIdea.fromMap(data);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to fetch travel idea: $e');
    }
  }
}
