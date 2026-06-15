import 'package:flutter/material.dart';

import 'add_travel_plan_screen.dart';
import 'travel_plan_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Home Screen'),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () {
                Navigator.pushNamed(context, TravelPlanListScreen.routeName);
              },
              child: const Text('Explore travel ideas'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, AddTravelPlanScreen.routeName);
              },
              child: const Text('Add travel idea'),
            ),
          ],
        ),
      ),
    );
  }
}
