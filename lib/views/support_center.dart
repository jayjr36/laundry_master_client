import 'package:flutter/material.dart';


class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Support")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListTile(
            leading: const Icon(Icons.chat),
            title: const Text("Chat with Support"),
            onTap: () {
              // Open chat page
            },
          ),
          ListTile(
            leading: const Icon(Icons.email),
            title: const Text("Email Support"),
            onTap: () {
              // Launch email client
            },
          ),
          ListTile(
            leading: const Icon(Icons.phone),
            title: const Text("Call Support"),
            onTap: () {
              // Initiate phone call
            },
          ),
        ],
      ),
    );
  }
}
