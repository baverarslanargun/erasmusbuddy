import 'package:flutter/material.dart';
import 'travel_plan_detail_screen.dart';

class TravelPlanListScreen extends StatelessWidget {
  const TravelPlanListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ErasmusBuddy'),
        backgroundColor: const Color(0xFF1E6BB8),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: implement search
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              title: Text(
                'Travel Plan #$index',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text('Country • 2-3 days'),
              trailing: const Icon(Icons.bookmark_border),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const TravelPlanDetailScreen(),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
