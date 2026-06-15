import 'package:flutter/material.dart';

import 'travel_plan_detail_screen.dart';

class TravelPlanListScreen extends StatelessWidget {
  const TravelPlanListScreen({super.key});

  static const routeName = '/travel-ideas';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Travel Ideas')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Travel Idea List Screen'),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () {
                Navigator.pushNamed(context, TravelPlanDetailScreen.routeName);
              },
              child: const Text('Open detail'),
            ),
          ],
        ),
      ),
    );
  }
}
