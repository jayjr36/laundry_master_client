import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:laundry_master/views/history.dart';
import 'package:laundry_master/views/order_screen.dart';
import 'package:laundry_master/views/order_tracking_screen.dart';
import 'package:laundry_master/views/price_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Banner
            Container(
              padding: EdgeInsets.only(
                  left: 20, right: 30, top: h * 0.08, bottom: h * 0.03),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.blue, Colors.lightBlueAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 5),
                    blurRadius: 15,
                    color: Colors.blue.withOpacity(0.3),
                  ),
                ],
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.local_laundry_service,
                        color: Colors.white,
                        size: 40,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Laundry Master',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Fast, reliable, and affordable laundry services at your fingertips.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Quick Actions
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Quick Actions',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent),
              ),
            ),
            const SizedBox(height: 15),

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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PricesScreen()));
                  },
                  color: Colors.blueAccent,
                ),
                _buildActionTile(
                  icon: Icons.shopping_cart,
                  label: 'Request Service',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MakeOrderScreen()));
                  },
                  color: Colors.greenAccent,
                ),
                _buildActionTile(
                  icon: Icons.track_changes,
                  label: 'Track Order',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OrderTrackingScreen()));
                  },
                  color: Colors.orangeAccent,
                ),
                _buildActionTile(
                  icon: Icons.history,
                  label: 'History',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                OrderHistoryScreen(userId: userId)));
                  },
                  color: Colors.purpleAccent,
                ),
              ],
            ),

            const SizedBox(height: 30),

            // About Section
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(0, 2),
                    blurRadius: 4,
                    color: Colors.black12,
                  ),
                ],
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    'About Us',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent),
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
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color, width: 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 35),
            const SizedBox(height: 10),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
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
