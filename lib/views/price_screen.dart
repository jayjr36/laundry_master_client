import 'package:flutter/material.dart';
import 'package:laundry_master/models/price.dart';

class PricesScreen extends StatelessWidget {
  const PricesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Laundry Prices')),
      body: FutureBuilder<List<PriceModel>>(
        future: PriceModel.fetchPrices(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData) {
            return Center(child: Text('No prices available.'));
          }
          var prices = snapshot.data!;
          return ListView.builder(
            itemCount: prices.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(prices[index].item),
                trailing: Text('\$${prices[index].price.toStringAsFixed(2)}'),
              );
            },
          );
        },
      ),
    );
  }
}

