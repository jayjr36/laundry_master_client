class PriceModel {
  final String item;
  final double price;
  final String? imagePath;

  PriceModel({required this.item, required this.price, this.imagePath});

  static Future<List<PriceModel>> fetchPrices() async {
    // Fetch prices from Firebase or static data
    var prices = [
      PriceModel(item: 'Shirt', price: 1500.0, imagePath: 'https://www.3wisemen.co.nz/media/catalog/product/t/5/t50_236044_1.jpg?width=800&height=&canvas=800,&optimize=low&bg-color=255,255,255&fit=bounds'),
      PriceModel(item: 'Pants', price: 2500.0, imagePath: 'https://cdn.shopify.com/s/files/1/0630/6532/5726/files/Como_Suit_Pants-Pants-LDM501001-3434-Anthrazit_-6.jpg?v=1702994397&width=400&height=515&crop=center'),
      PriceModel(item: 'Jacket', price: 4000.0, imagePath: 'https://hooke.ca/cdn/shop/files/HOOKE-MEN-LIGHTWEIGHT-INSULATED-HOOD-JACKET-BLK-1.webp?v=1689773252&width=2500'),
      PriceModel(item: 'Dress', price: 5000.0, imagePath: 'https://img01.ztat.net/article/spp-media-p1/70c67513ae044eeeb220a3e03a8d8848/d91d970aa805496c90dbc45ca2a20067.jpg?imwidth=762&filter=packshot'),
      PriceModel(item: 'Shorts', price: 1000.0, imagePath: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTrIG_yX_NIe1ZsOb--DjsG3wWJZN1epOQgBQ&s'),
      PriceModel(item: 'Skirt', price: 3000.0, imagePath: 'https://n.nordstrommedia.com/id/f8e54206-e261-4730-bf25-2589e3ca73ec.jpeg?h=620&w=750'),
    ];
    return prices;
  }
}
