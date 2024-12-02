class OrderStatusModel {
  final String orderId;
  final String status; // e.g., 'Received', 'In Progress', 'Complete'
  final DateTime timestamp;

  OrderStatusModel({required this.orderId, required this.status, required this.timestamp});
}
