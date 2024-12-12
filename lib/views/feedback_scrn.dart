import 'package:flutter/material.dart';

class FeedbackScreen extends StatelessWidget {
  final TextEditingController feedbackController = TextEditingController();
  int rating = 3;

  FeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("Feedback")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text("Rate your experience:"),
            DropdownButton<int>(
              value: rating,
              items: [1, 2, 3, 4, 5].map((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text("$value Stars"),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) rating = value;
              },
            ),
            TextField(
              controller: feedbackController,
              decoration: const InputDecoration(
                labelText: "Write your feedback",
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            ElevatedButton(
              onPressed: () {
                saveFeedback(rating, feedbackController.text);
              },
              child: const Text("Submit Feedback"),
            ),
          ],
        ),
      ),
    );
  }

  void saveFeedback(int rating, String feedback) {
    // Save to Firebase logic here
  }
}
