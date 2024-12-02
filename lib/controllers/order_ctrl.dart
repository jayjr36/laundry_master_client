import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OrdersController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> createOrder(List<Map<String, dynamic>> items, double total) async {
    try {
      await _firestore.collection('orders').add({
        'userId': _auth.currentUser!.uid,
        'items': items,
        'status': 'Received', // Initial status
        'total': total,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception("Failed to create order: $e");
    }
  }

  Future<List<Map<String, dynamic>>> fetchOrderHistory() async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('orders')
          .where('userId', isEqualTo: _auth.currentUser!.uid)
          .orderBy('timestamp', descending: true)
          .get();

      return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    } catch (e) {
      throw Exception("Failed to fetch order history: $e");
    }
  }

  Future<void> updateOrderStatus(String orderId, String status) async {
    try {
      await _firestore.collection('orders').doc(orderId).update({'status': status});
    } catch (e) {
      throw Exception("Failed to update order status: $e");
    }
  }


  Stream<Map<String, dynamic>> trackOrder(String orderId) {
    return _firestore.collection('orders').doc(orderId).snapshots().map((doc) {
      return doc.data() as Map<String, dynamic>;
    });
  }
}
