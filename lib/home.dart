import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:laundry_master/views/history.dart';
import 'package:laundry_master/views/order_screen.dart';
import 'package:laundry_master/views/order_tracking_screen.dart';
import 'package:laundry_master/views/price_screen.dart';
import 'package:laundry_master/views/support_center.dart';

import 'views/feedback_scrn.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Laundry Master"),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.help),
//             onPressed: () => Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => const SupportScreen()),
//             ),
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Expanded(
//               child: ListView(
//                 children: [
//                   ListTile(
//                     leading: const Icon(Icons.local_laundry_service),
//                     title: const Text("Make an Order"),
//                     onTap: () => Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => MakeOrderScreen()),
//                     ),
//                   ),
//                   ListTile(
//                     leading: const Icon(Icons.history),
//                     title: const Text("Order History"),
//                     onTap: () => Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => OrderHistoryScreen()),
//                     ),
//                   ),
//                   ListTile(
//                     leading: const Icon(Icons.feedback),
//                     title: const Text("Leave Feedback"),
//                     onTap: () => Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => FeedbackScreen()),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
            // StreamBuilder(
            //   stream: FirebaseFirestore.instance
            //       .collection('orders')
            //       .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            //       .orderBy('createdAt', descending: true)
            //       .snapshots(),
            //   builder: (context, snapshot) {
            //     if (!snapshot.hasData) return const CircularProgressIndicator();

            //     final order = snapshot.data!.docs.first;
            //     final status = order['status'];

            //     return Card(
            //       child: ListTile(
            //         title: Text("Order Status: $status"),
            //         subtitle: const Text("Track your latest order here."),
            //         onTap: () => Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //               builder: (context) => OrderTrackingScreen(orderId: order.id)),
            //         ),
            //       ),
            //     );
            //   },
            // ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Laundry Master'),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Banner
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.deepPurpleAccent,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome to Laundry Master!',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Enjoy fast, reliable, and affordable laundry services at your fingertips.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Quick Actions
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Quick Actions',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),

            GridView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: 3 / 2,
              ),
              children: [
                _buildActionTile(
                  icon: Icons.local_offer,
                  label: 'View Prices',
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>  PricesScreen()));
                  },
                  color: Colors.blueAccent,
                ),
                _buildActionTile(
                  icon: Icons.shopping_cart,
                  label: 'Make an Order',
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> MakeOrderScreen()));
                  },
                  color: Colors.greenAccent,
                ),
                _buildActionTile(
                  icon: Icons.track_changes,
                  label: 'Track Order',
                  onTap: () {
                    Navigator.pushNamed(context, '/trackOrder');
                  },
                  color: Colors.orangeAccent,
                ),
                _buildActionTile(
                  icon: Icons.history,
                  label: 'Order History',
                  onTap: () {
                    Navigator.pushNamed(context, '/orderHistory');
                  },
                  color: Colors.purpleAccent,
                ),
              ],
            ),

            const SizedBox(height: 20),

            // About Section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'About Us',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Laundry Master is dedicated to providing top-notch laundry services. '
                    'We handle your clothes with care, ensuring they come back fresh, clean, and perfectly folded!',
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to build action tiles
  Widget _buildActionTile({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required Color color,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: color, width: 1.5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 30),
            const SizedBox(height: 10),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
