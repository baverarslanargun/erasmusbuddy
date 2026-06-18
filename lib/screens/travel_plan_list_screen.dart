import 'package:flutter/material.dart';

import 'travel_plan_detail_screen.dart';

class TravelPlanListScreen extends StatelessWidget {
  const TravelPlanListScreen({super.key});

  static const routeName = '/travel-ideas';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Travel Ideas')),
      body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Sample Travel Idea',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ),
      ],
    ),
    );
  }
}
