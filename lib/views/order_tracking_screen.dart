// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderTrackingScreen extends StatelessWidget {
  final TextEditingController cancellationReasonController =
      TextEditingController();

  final List<String> cancellationSuggestions = [
    "Change of mind",
    "Order delayed",
    "Other"
  ];

  OrderTrackingScreen({super.key});

  void cancelOrder(BuildContext context, String userId, String orderId) async {
    final reason = cancellationReasonController.text;

    if (reason.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please provide a cancellation reason!")),
      );
      return;
    }

    await FirebaseFirestore.instance
        .collection('orders')
        .doc(userId)
        .collection('myorders')
        .doc(orderId)
        .update({
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
    final userId = FirebaseAuth.instance.currentUser!
        .uid; // Replace with actual user ID retrieval logic

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Order Tracking",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('orders')
            .doc(userId)
            .collection('myorders')
            .where('status',
                whereIn: ['pending', 'received', 'in-progress']).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No active orders found."));
          }

          final orders = snapshot.data!.docs;

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              final orderId = order.id;
              final status = order['status'];
              final items = order['items'] as List<dynamic>;
              final totalPrice = order['totalPrice'];
              var timestamp = (order['timestamp'] as Timestamp).toDate();

              return Card(
                margin: const EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Date: ${DateFormat.yMMMd().add_jm().format(timestamp)}',
                            style: const TextStyle(color: Colors.grey),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: status == 'pending'
                                  ? Colors.orange
                                  : status == 'received'
                                      ? Colors.blue
                                      : Colors.green,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              status.toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 20),
                      ...items.map((item) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              item['item'],
                              style: const TextStyle(fontSize: 14),
                            ),
                            Text(
                              'x${item['quantity']}',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                      const Divider(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: TextButton(
                              onPressed: () => showDialog(
                                  context: context,
                                  builder: (ctx) {
                                    return AlertDialog(
                                      title: const Text(
                                        "Cancel Order",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Please enter the reason for cancellation",
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          TextField(
                                            controller:
                                                cancellationReasonController,
                                            decoration: InputDecoration(
                                              labelText: "Cancellation Reason",
                                              hintText:
                                                  "Enter reason for cancellation",
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Wrap(
                                            spacing: 10,
                                            runSpacing: 10,
                                            children: cancellationSuggestions
                                                .map((suggestion) {
                                              return Chip(
                                                label: Text(suggestion),
                                                onDeleted: () {
                                                  cancellationReasonController
                                                      .text = suggestion;
                                                },
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                backgroundColor: Colors.white,
                                                labelStyle: const TextStyle(
                                                  color: Colors.black,
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ],
                                      ),
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(ctx).pop();
                                            cancelOrder(
                                                context, userId, orderId);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.red,
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 20,
                                              vertical: 15,
                                            ),
                                          ),
                                          child: const Text(
                                            "CANCEL",
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 15,
                                ),
                              ),
                              child: const Text(
                                "Cancel",
                                style:
                                    TextStyle(fontSize: 14, color: Colors.red),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'Total: TZS ${totalPrice.toStringAsFixed(0)}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
