import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../models/travel_idea.dart';
import '../services/auth_service.dart';
import '../services/travel_idea_service.dart';

class AddTravelPlanScreen extends StatefulWidget {
  const AddTravelPlanScreen({super.key});

  static const routeName = '/add-travel-idea';

  @override
  State<AddTravelPlanScreen> createState() => _AddTravelPlanScreenState();
}

class _AddTravelPlanScreenState extends State<AddTravelPlanScreen> {
  final _formKey = GlobalKey<FormState>();
  final _authService = AuthService();
  final _travelIdeaService = TravelIdeaService();

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

  Future<void> _onSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    final currentUser = _authService.currentUser;
    if (currentUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Your session has expired. Please sign in again.'),
        ),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    final profileName = currentUser.displayName?.trim();
    final createdByName = profileName != null && profileName.isNotEmpty
        ? profileName
        : currentUser.email?.split('@').first ?? 'Erasmus student';
    final travelIdea = TravelIdea(
      id: '',
      title: _titleController.text.trim(),
      destination: _destinationController.text.trim(),
      duration: _durationController.text.trim(),
      budget: _budgetController.text.trim(),
      description: _descriptionController.text.trim(),
      createdBy: currentUser.uid,
      createdByName: createdByName,
      createdAt: DateTime.now(),
    );

    try {
      await _travelIdeaService.createTravelIdea(travelIdea);

      if (!mounted) return;

      _titleController.clear();
      _destinationController.clear();
      _durationController.clear();
      _budgetController.clear();
      _descriptionController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Travel idea shared successfully!'),
          backgroundColor: AppColors.secondary,
        ),
      );
    } catch (_) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to share travel idea.')),
      );
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
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
                maxLength: 100,
                decoration: const InputDecoration(
                  hintText: 'e.g. Budapest + Bratislava Weekend',
                ),
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? 'Please enter a title for your travel idea'
                    : null,
              ),

              const SizedBox(height: 20),

              const _FieldLabel('Destination'),
              const SizedBox(height: 8),
              TextFormField(
                controller: _destinationController,
                textCapitalization: TextCapitalization.words,
                maxLength: 100,
                decoration: const InputDecoration(
                  hintText: 'e.g. Budapest, Hungary',
                ),
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? 'Please enter the destination (city and country)'
                    : null,
              ),

              const SizedBox(height: 20),

              const _FieldLabel('Duration'),
              const SizedBox(height: 8),
              TextFormField(
                controller: _durationController,
                maxLength: 50,
                decoration: const InputDecoration(hintText: 'e.g. 2-3 days'),
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? 'Please enter the trip duration (e.g. 2-3 days)'
                    : null,
              ),
              const SizedBox(height: 20),

              const _FieldLabel('Budget'),
              const SizedBox(height: 8),
              TextFormField(
                controller: _budgetController,
                maxLength: 50,
                decoration: const InputDecoration(
                  hintText: 'e.g. Low, Medium, High or ~EUR 200',
                ),
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? 'Please enter an estimated budget (e.g. Low, ~200€)'
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
                    ? 'Please add a short description of your trip'
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
