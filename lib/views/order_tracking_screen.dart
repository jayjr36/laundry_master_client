// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:laundry_master/models/order_status.dart';


class OrderTrackingScreen extends StatelessWidget {
  final String orderId;

  OrderTrackingScreen({super.key, required this.orderId});

  final TextEditingController cancellationReasonController =
      TextEditingController();

  void cancelOrder(BuildContext context) async {
    final reason = cancellationReasonController.text;

    await FirebaseFirestore.instance.collection('orders').doc(orderId).update({
      'status': 'Cancelled',
      'cancellationReason': reason,
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Order cancelled successfully!")),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Order Tracking")),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('orders')
            .doc(orderId)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const CircularProgressIndicator();

          final order = snapshot.data!;
          final status = order['status'];

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text("Order Status: $status"),
                if (status != 'Delivered' && status != 'Cancelled')
                  Column(
                    children: [
                      TextField(
                        controller: cancellationReasonController,
                        decoration: const InputDecoration(
                          labelText: "Cancellation Reason",
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => cancelOrder(context),
                        child: const Text("Cancel Order"),
                      ),
                    ],
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// class OrderTrackingScreen extends StatelessWidget {
//   final String orderId;

//   OrderTrackingScreen({required this.orderId});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Track Order')),
//       body: FutureBuilder<OrderStatusModel>(
//         future: fetchOrderStatus(orderId), // Fetch from Firebase
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           if (!snapshot.hasData) {
//             return const Center(child: Text('No status available.'));
//           }
//           final orderStatus = snapshot.data!;
//           return Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text('Order ID: ${orderStatus.orderId}'),
//               Text('Status: ${orderStatus.status}'),
//               Text('Last Updated: ${orderStatus.timestamp}'),
//             ],
//           );
//         },
//       ),
//     );
//   }

//   Future<OrderStatusModel> fetchOrderStatus(String orderId) async {
//     // Fetch from Firebase or a static source
//     return OrderStatusModel(orderId: orderId, status: 'In Progress', timestamp: DateTime.now());
//   }
// }
