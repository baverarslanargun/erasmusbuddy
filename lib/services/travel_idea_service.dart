import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:erasmusbuddy/models/travel_idea.dart';

class TravelIdeaService {
  static const String _collectionName = 'travelIdeas';

  TravelIdeaService({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _travelIdeas =>
      _firestore.collection(_collectionName);

  Future<void> createTravelIdea(TravelIdea idea) async {
    try {
      final docRef = _travelIdeas.doc();
      final data = idea.toMap();
      data['id'] = docRef.id;
      data['createdAt'] = FieldValue.serverTimestamp();

      await docRef.set(data);
    } catch (e) {
      throw Exception('Failed to create travel idea: $e');
    }
  }

  Stream<List<TravelIdea>> getTravelIdeas() {
    return _travelIdeas.snapshots().map(_mapTravelIdeas);
  }

  Stream<int> getTravelIdeaCount() {
    return _travelIdeas.snapshots().map((snapshot) => snapshot.docs.length);
  }

  Stream<List<TravelIdea>> getUserTravelIdeas(String userId) {
    return _travelIdeas
        .where('createdBy', isEqualTo: userId)
        .snapshots()
        .map(_mapTravelIdeas);
  }

  Stream<int> getUserTravelIdeaCount(String userId) {
    return getUserTravelIdeas(userId).map((ideas) => ideas.length);
  }

  Future<TravelIdea?> getTravelIdeaById(String id) async {
    try {
      final doc = await _travelIdeas.doc(id).get();
      if (doc.exists) {
        return TravelIdea.fromMap({...?doc.data(), 'id': doc.id});
      }
      return null;
    } catch (e) {
      throw Exception('Failed to fetch travel idea: $e');
    }
  }

  List<TravelIdea> _mapTravelIdeas(
    QuerySnapshot<Map<String, dynamic>> snapshot,
  ) {
    return snapshot.docs
        .map((doc) => TravelIdea.fromMap({...doc.data(), 'id': doc.id}))
        .toList();
  }
}
