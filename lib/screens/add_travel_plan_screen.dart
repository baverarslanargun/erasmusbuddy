import 'package:flutter/material.dart';

class AddTravelPlanScreen extends StatelessWidget {
  const AddTravelPlanScreen({super.key});

  static const routeName = '/add-travel-idea';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Travel Idea')),
      body: const Center(
        child: Text('Add Travel Idea Screen'),
      ),
    );
  }
}
