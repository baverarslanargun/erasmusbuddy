import 'package:flutter/material.dart';

class TravelPlanDetailScreen extends StatelessWidget {
  const TravelPlanDetailScreen({super.key});

  static const routeName = '/travel-idea-detail';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Travel Idea Detail')),
      body: const Center(
        child: Text('Travel Idea Detail Screen'),
      ),
    );
  }
}
