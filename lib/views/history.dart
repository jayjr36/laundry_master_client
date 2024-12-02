import 'package:flutter/material.dart';
import 'package:laundry_master/models/order_status.dart';

class OrderHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Order History')),
      body: FutureBuilder<List<OrderStatusModel>>(
        future: fetchOrderHistory(), // Fetch from Firebase
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData) {
            return const Center(child: Text('No orders found.'));
          }
          var orders = snapshot.data!;
          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('Order ID: ${orders[index].orderId}'),
                subtitle: Text('Status: ${orders[index].status}'),
              );
            },
          );
        },
      ),
    );
  }

  Future<List<OrderStatusModel>> fetchOrderHistory() async {
    // Fetch order history from Firebase
    return [
      OrderStatusModel(orderId: '123', status: 'Complete', timestamp: DateTime.now()),
      OrderStatusModel(orderId: '124', status: 'In Progress', timestamp: DateTime.now().subtract(const Duration(days: 1))),
    ];
  }
}
