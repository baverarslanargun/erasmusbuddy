import 'package:flutter/material.dart';

class TravelPlanDetailScreen extends StatelessWidget {
  const TravelPlanDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plan Detail'),
        backgroundColor: const Color(0xFF1E6BB8),
        foregroundColor: Colors.white,
        actions: [
          IconButton(icon: const Icon(Icons.bookmark_border), onPressed: () {}),
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Plan Title',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Country • Duration', style: TextStyle(color: Colors.grey)),
            SizedBox(height: 24),
            Text('Cities', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('City list goes here'),
            SizedBox(height: 24),
            Text(
              'Places to Visit',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Places list goes here'),
            SizedBox(height: 24),
            Text('Note', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Note goes here'),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: const Color(0xFF1E6BB8),
            foregroundColor: Colors.white,
          ),
          child: const Text("I'm Interested", style: TextStyle(fontSize: 16)),
        ),
      ),
    );
  }
}
