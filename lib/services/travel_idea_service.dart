import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:erasmusbuddy/models/travel_idea.dart';

class TravelIdeaService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createTravelIdea(TravelIdea idea) async {
    // TODO: Implement Firestore add logic here
  }

  Stream<List<TravelIdea>> getTravelIdeas() {
    // TODO: Implement Firestore stream mapping here
    throw UnimplementedError();
  }

  Future<TravelIdea?> getTravelIdeaById(String id) async {
    // TODO: Implement Firestore get document logic here
    return null;
  }
}