import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final String name;
  final String email;
  final String phoneNumber;
  final Function onEditProfile;

  const ProfilePage({
    super.key,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.onEditProfile,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Picture Section
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.deepPurpleAccent.withOpacity(0.3),
              child: const CircleAvatar(
                radius: 55,
                backgroundImage: AssetImage(
                    'assets/profile_placeholder.png'), // Add a placeholder image
              ),
            ),
            const SizedBox(height: 20),
            Text(
              name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              email,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              phoneNumber,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 30),

            // Divider
            const Divider(
              thickness: 1,
              color: Colors.grey,
              indent: 20,
              endIndent: 20,
            ),

            // Options Section
            ListTile(
              leading: const Icon(Icons.edit, color: Colors.deepPurpleAccent),
              title: const Text(
                'Edit Profile',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () => onEditProfile(),
            ),
            ListTile(
              leading:
                  const Icon(Icons.history, color: Colors.deepPurpleAccent),
              title: const Text(
                'Order History',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // Navigate to Order History page
                Navigator.pushNamed(context, '/orderHistory');
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.redAccent),
              title: const Text(
                'Log Out',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.redAccent),
              ),
              trailing: const Icon(Icons.arrow_forward_ios,
                  size: 16, color: Colors.redAccent),
              onTap: () {
                // Log out function
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Log Out'),
                    content: const Text('Are you sure you want to log out?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          // Log out logic
                          Navigator.pop(context);
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                        child: const Text('Log Out'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
