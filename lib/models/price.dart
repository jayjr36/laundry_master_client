class PriceModel {
  final String item;
  final double price;

  PriceModel({required this.item, required this.price});

  static Future<List<PriceModel>> fetchPrices() async {
    // Fetch prices from Firebase or static data
    var prices = [
      PriceModel(item: 'Shirt', price: 5.0),
      PriceModel(item: 'Pants', price: 7.0),
      PriceModel(item: 'Jacket', price: 10.0),
    ];
    return prices;
  }
}
