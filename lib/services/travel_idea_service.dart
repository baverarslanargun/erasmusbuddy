import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:erasmusbuddy/models/travel_idea.dart';

class TravelIdeaService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // 1. Yeni bir seyahat fikri oluşturma metodu
  Future<void> createTravelIdea(TravelIdea idea) async {
    // TODO: Implement Firestore add logic here
  }

  // 2. Tüm seyahat fikirlerini anlık (Stream) olarak getirme metodu
  Stream<List<TravelIdea>> getTravelIdeas() {
    // TODO: Implement Firestore stream mapping here
    throw UnimplementedError();
  }

  // 3. ID'ye göre tek bir seyahat fikri detayını getirme metodu
  Future<TravelIdea?> getTravelIdeaById(String id) async {
    // TODO: Implement Firestore get document logic here
    return null;
  }
}