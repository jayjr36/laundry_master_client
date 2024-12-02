import 'package:cloud_firestore/cloud_firestore.dart';

class PricesController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> fetchPrices() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('prices').get();
      return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    } catch (e) {
      throw Exception("Failed to fetch prices: $e");
    }
  }
}
