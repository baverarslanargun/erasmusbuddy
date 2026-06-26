import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../models/travel_idea.dart';

class AddTravelPlanScreen extends StatefulWidget {
  const AddTravelPlanScreen({super.key});

  static const routeName = '/add-travel-idea';

  @override
  State<AddTravelPlanScreen> createState() => _AddTravelPlanScreenState();
}

class _AddTravelPlanScreenState extends State<AddTravelPlanScreen> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _destinationController = TextEditingController();
  final _durationController = TextEditingController();
  final _budgetController = TextEditingController();
  final _descriptionController = TextEditingController();

  bool _isSubmitting = false;

  @override
  void dispose() {
    _titleController.dispose();
    _destinationController.dispose();
    _durationController.dispose();
    _budgetController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    // TODO: call service to create travel idea

    final travelIdea = TravelIdea(
      id: '',
      title: _titleController.text.trim(),
      destination: _destinationController.text.trim(),
      duration: _durationController.text.trim(),
      budget: _budgetController.text.trim(),
      description: _descriptionController.text.trim(),
      createdBy: 'anonymous',
      createdAt: DateTime.now(),
    );

    debugPrint('TravelIdea built: ${travelIdea.toMap()}');

    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      setState(() => _isSubmitting = false);

      // Clear form
      _titleController.clear();
      _destinationController.clear();
      _durationController.clear();
      _budgetController.clear();
      _descriptionController.clear();

      // Show success
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Travel idea shared successfully!'),
          backgroundColor: AppColors.secondary,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Add Travel Idea')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Share your travel idea', style: textTheme.headlineSmall),
              const SizedBox(height: 4),
              Text(
                'Describe your trip so other students can get inspired.',
                style: textTheme.bodyMedium,
              ),

              const SizedBox(height: 28),

              const _FieldLabel('Title'),
              const SizedBox(height: 8),
              TextFormField(
                controller: _titleController,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  hintText: 'e.g. Budapest + Bratislava Weekend',
                ),
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? 'Title is required'
                    : null,
              ),

              const SizedBox(height: 20),

              const _FieldLabel('Destination'),
              const SizedBox(height: 8),
              TextFormField(
                controller: _destinationController,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  hintText: 'e.g. Budapest, Hungary',
                ),
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? 'Destination is required'
                    : null,
              ),

              const SizedBox(height: 20),

              const _FieldLabel('Duration'),
              const SizedBox(height: 8),
              TextFormField(
                controller: _durationController,
                decoration: const InputDecoration(hintText: 'e.g. 2-3 days'),
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? 'Duration is required'
                    : null,
              ),
              const SizedBox(height: 20),

              const _FieldLabel('Budget'),
              const SizedBox(height: 8),
              TextFormField(
                controller: _budgetController,
                decoration: const InputDecoration(
                  hintText: 'e.g. Low, Medium, High or ~EUR 200',
                ),
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? 'Budget is required'
                    : null,
              ),
              const SizedBox(height: 20),

              const _FieldLabel('Description'),
              const SizedBox(height: 8),
              TextFormField(
                controller: _descriptionController,
                maxLines: 4,
                maxLength: 300,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  hintText:
                  'Share places to visit, tips, and any personal notes...',
                  alignLabelWithHint: true,
                ),
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? 'Description is required'
                    : null,
              ),
              const SizedBox(height: 32),

              FilledButton.icon(
                onPressed: _isSubmitting ? null : _onSubmit,
                icon: _isSubmitting
                    ? const SizedBox(
                  height: 16,
                  width: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.surface,
                  ),
                )
                    : const Icon(Icons.send),
                label: Text(
                  _isSubmitting ? 'Sharing...' : 'Share Travel Idea',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String label;
  const _FieldLabel(this.label);

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.text,
      ),
    );
  }
}