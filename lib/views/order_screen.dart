// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:laundry_master/models/price.dart';

class MakeOrderScreen extends StatefulWidget {
  const MakeOrderScreen({super.key});

  @override
  _MakeOrderScreenState createState() => _MakeOrderScreenState();
}

class _MakeOrderScreenState extends State<MakeOrderScreen> {
  Map<String, int> _quantities = {};
  List<PriceModel> _prices = [];
  double _totalPrice = 0.0;

  @override
  void initState() {
    super.initState();
    _fetchPrices();
  }

  Future<void> _fetchPrices() async {
    var prices = await PriceModel.fetchPrices();
    setState(() {
      _prices = prices;
      for (var price in prices) {
        _quantities[price.item] = 0;
      }
    });
  }

  void _updateTotalPrice() {
    setState(() {
      _totalPrice = _prices.fold(
        0.0,
        (sum, price) => sum + (price.price * (_quantities[price.item] ?? 0)),
      );
    });
  }

  final userId = FirebaseAuth.instance.currentUser!.uid;

  Future<void> _submitOrder() async {
    try {
      final orderData = {
        'items': _quantities.entries
            .where((entry) => entry.value > 0)
            .map((entry) => {
                  'item': entry.key,
                  'quantity': entry.value,
                })
            .toList(),
        'totalPrice': _totalPrice,
        'status': 'pending',
        'timestamp': Timestamp.now(),
      };

      await FirebaseFirestore.instance
          .collection('orders')
          .doc(userId)
          .collection('myorders')
          .add(orderData);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Order submitted successfully!')),
      );

      setState(() {
        for (var key in _quantities.keys) {
          _quantities[key] = 0;
        }
        _totalPrice = 0.0;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to submit order!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'New Order',
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
      body: _prices.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: _prices.length,
                    itemBuilder: (context, index) {
                      final price = _prices[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: ListTile(
                          leading: price.imagePath != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.network(
                                    price.imagePath!,
                                    height: 60,
                                    width: 60,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : const Icon(Icons.image_not_supported),
                          title: Text(
                            price.item,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            'Price: TZS ${price.price.toStringAsFixed(0)}',
                            style: const TextStyle(color: Colors.grey),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove_circle_outline),
                                onPressed: () {
                                  setState(() {
                                    if (_quantities[price.item]! > 0) {
                                      _quantities[price.item] =
                                          _quantities[price.item]! - 1;
                                    }
                                  });
                                  _updateTotalPrice();
                                },
                              ),
                              Text(
                                '${_quantities[price.item] ?? 0}',
                                style: const TextStyle(fontSize: 16),
                              ),
                              IconButton(
                                icon: const Icon(Icons.add_circle_outline),
                                onPressed: () {
                                  setState(() {
                                    _quantities[price.item] =
                                        _quantities[price.item]! + 1;
                                  });
                                  _updateTotalPrice();
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'Total: TZS ${_totalPrice.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 15),
                          textStyle: const TextStyle(fontSize: 16),
                        ),
                        onPressed:
                            _totalPrice > 0 ? _showConfirmationModal : null,
                        child: const Text('Submit Order'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  void _showConfirmationModal() {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text(
            'Confirm Order',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Selected Items:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ..._quantities.entries
                  .where((entry) => entry.value > 0)
                  .map((entry) => Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          '${entry.key}: ${entry.value}',
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ))
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                _submitOrder();
              },
              child: const Text(
                'Confirm',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
