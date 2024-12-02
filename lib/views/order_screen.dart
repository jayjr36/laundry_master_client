import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:laundry_master/models/price.dart';


// class MakeOrderScreen extends StatefulWidget {
//   @override
//   _MakeOrderScreenState createState() => _MakeOrderScreenState();
// }

// class _MakeOrderScreenState extends State<MakeOrderScreen> {
//   final TextEditingController specialInstructionsController =
//       TextEditingController();
//   final TextEditingController clothCountController = TextEditingController();

//   DateTime? pickupDate;
//   DateTime? deliveryDate;
//   double pricePerCloth = 5.0;
//   double totalPrice = 0.0;

//   void calculateTotalPrice() {
//     final count = int.tryParse(clothCountController.text) ?? 0;
//     setState(() {
//       totalPrice = count * pricePerCloth;
//     });
//   }

//   void submitOrder() async {
//     final data = {
//       'userId': FirebaseAuth.instance.currentUser!.uid,
//       'specialInstructions': specialInstructionsController.text,
//       'pickupDate': pickupDate?.toIso8601String(),
//       'deliveryDate': deliveryDate?.toIso8601String(),
//       'totalPrice': totalPrice,
//       'status': 'Pending',
//     };

//     await FirebaseFirestore.instance.collection('orders').add(data);

//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text("Order submitted successfully!")),
//     );
//     Navigator.pop(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Make an Order")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: ListView(
//           children: [
//             TextField(
//               controller: clothCountController,
//               keyboardType: TextInputType.number,
//               decoration: const InputDecoration(
//                 labelText: "Number of Clothes",
//                 hintText: "Enter the number of clothes for laundry",
//               ),
//               onChanged: (_) => calculateTotalPrice(),
//             ),
//             const SizedBox(height: 10),
//             Text("Estimated Price: \$${totalPrice.toStringAsFixed(2)}"),
//             const SizedBox(height: 10),
//             TextField(
//               controller: specialInstructionsController,
//               decoration: const InputDecoration(
//                 labelText: "Special Instructions",
//                 hintText: "E.g., Hand wash only",
//               ),
//             ),
//             const SizedBox(height: 10),
//             TextButton(
//               onPressed: () async {
//                 final selectedDate = await showDatePicker(
//                   context: context,
//                   initialDate: DateTime.now(),
//                   firstDate: DateTime.now(),
//                   lastDate: DateTime(2101),
//                 );
//                 if (selectedDate != null) setState(() => pickupDate = selectedDate);
//               },
//               child: Text(
//                 pickupDate == null
//                     ? "Select Pickup Date"
//                     : "Pickup Date: ${pickupDate!.toLocal().toString().split(' ')[0]}",
//               ),
//             ),
//             TextButton(
//               onPressed: () async {
//                 final selectedDate = await showDatePicker(
//                   context: context,
//                   initialDate: DateTime.now(),
//                   firstDate: DateTime.now(),
//                   lastDate: DateTime(2101),
//                 );
//                 if (selectedDate != null) setState(() => deliveryDate = selectedDate);
//               },
//               child: Text(
//                 deliveryDate == null
//                     ? "Select Delivery Date"
//                     : "Delivery Date: ${deliveryDate!.toLocal().toString().split(' ')[0]}",
//               ),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: submitOrder,
//               child: const Text("Submit Order"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


class MakeOrderScreen extends StatefulWidget {
  @override
  _MakeOrderScreenState createState() => _MakeOrderScreenState();
}

class _MakeOrderScreenState extends State<MakeOrderScreen> {
  final Map<String, int> _quantities = {'Shirt': 0, 'Pants': 0, 'Jacket': 0};
  final List<PriceModel> _prices = [
    PriceModel(item: 'Shirt', price: 5.0),
    PriceModel(item: 'Pants', price: 7.0),
    PriceModel(item: 'Jacket', price: 10.0)
  ];

  double _totalPrice = 0.0;

  void _updateTotalPrice() {
    setState(() {
      _totalPrice = _prices.fold(0.0, (sum, price) {
        return sum + (price.price * _quantities[price.item]!);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Make an Order')),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: _prices.length,
              itemBuilder: (context, index) {
                final price = _prices[index];
                return ListTile(
                  title: Text(price.item),
                  subtitle: Text('Price: \$${price.price.toStringAsFixed(2)}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
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
                      Text('${_quantities[price.item]!}'),
                      IconButton(
                        icon: const Icon(Icons.add),
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
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Total: \$${_totalPrice.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Submit order logic
            },
            child: const Text('Submit Order'),
          ),
        ],
      ),
    );
  }
}
