import 'package:flutter/material.dart';

class AddTravelPlanScreen extends StatefulWidget {
  const AddTravelPlanScreen({super.key});

  @override
  State<AddTravelPlanScreen> createState() => _AddTravelPlanScreenState();
}

class _AddTravelPlanScreenState extends State<AddTravelPlanScreen> {
  final _titleController = TextEditingController();
  final _countryController = TextEditingController();
  final _citiesController = TextEditingController();
  final _durationController = TextEditingController();
  final _placesController = TextEditingController();
  final _noteController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _countryController.dispose();
    _citiesController.dispose();
    _durationController.dispose();
    _placesController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    // TODO: implement create plan logic
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Plan'),
        backgroundColor: const Color(0xFF1E6BB8),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                hintText: 'e.g. Lisbon Weekend',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _countryController,
              decoration: const InputDecoration(
                labelText: 'Country',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _citiesController,
              decoration: const InputDecoration(
                labelText: 'Cities',
                hintText: 'e.g. Lisbon, Sintra, Cascais',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _durationController,
              decoration: const InputDecoration(
                labelText: 'Duration',
                hintText: 'e.g. 2-3 days',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _placesController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Places to Visit',
                hintText: 'e.g. Belém Tower, Sintra Palace',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _noteController,
              maxLines: 3,
              maxLength: 300,
              decoration: const InputDecoration(
                labelText: 'Note / Description',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _onSubmit,
              icon: const Icon(Icons.send),
              label: const Text('Share Plan', style: TextStyle(fontSize: 16)),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: const Color(0xFF1E6BB8),
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
