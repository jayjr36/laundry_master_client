class OrderModel {
  final String item;
  final int quantity;
  final double price;
  double get total => price * quantity;

  OrderModel({required this.item, required this.quantity, required this.price});
}
