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
  final _countryController = TextEditingController();
  final _citiesController = TextEditingController();
  final _durationController = TextEditingController();
  final _placesController = TextEditingController();
  final _noteController = TextEditingController();
  final _destinationController = TextEditingController();
  final _budgetController = TextEditingController();
  final _descriptionController = TextEditingController();

  final List<String> _availableCategories = [
    'travel',
    'history',
    'food',
    'nature',
    'art',
  ];
  final List<String> _selectedCategories = [];

  bool _isSubmitting = false;

  @override
  void dispose() {
    _titleController.dispose();
    _countryController.dispose();
    _citiesController.dispose();
    _durationController.dispose();
    _placesController.dispose();
    _noteController.dispose();
    _destinationController.dispose();
    _budgetController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

	Future<void> _onSubmit() async {
		if (!_formKey.currentState!.validate()) return;

		setState(() => _isSubmitting = true);

		final currentUser = _authService.currentUser;
		final profileName = currentUser?.displayName?.trim();
		final createdByName = profileName != null && profileName.isNotEmpty
			? profileName
			: currentUser?.email?.split('@').first ?? 'Erasmus student';
		final travelIdea = TravelIdea(
			id: '',
			title: _titleController.text.trim(),
			destination: _destinationController.text.trim(),
			duration: _durationController.text.trim(),
            budget: _budgetController.text.trim(),
            description: _noteController.text.trim(),
			createdBy: currentUser?.uid ?? 'anonymous',
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
            _noteController.clear();

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

              const _FieldLabel('Country'),
              const SizedBox(height: 8),
              TextFormField(
                controller: _countryController,
                textCapitalization: TextCapitalization.words,
                maxLength: 100,
                decoration: const InputDecoration(
                  hintText: 'e.g. Hungary, Slovakia',
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

              const _FieldLabel('Category'),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  ..._availableCategories.map((category) {
                    final isSelected = _selectedCategories.contains(category);
                    return FilterChip(
                      label: Text(category),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            _selectedCategories.add(category);
                          } else {
                            _selectedCategories.remove(category);
                          }
                        });
                      },
                      selectedColor: AppColors.primary.withValues(alpha: 0.15),
                      checkmarkColor: AppColors.primary,
                      labelStyle: TextStyle(
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.textSecondary,
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.normal,
                      ),
                    );
                  }),
                  ActionChip(
                    label: const Icon(Icons.add, size: 16),
                    onPressed: () async {
                      final controller = TextEditingController();
                      final result = await showDialog<String>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Add Category'),
                          content: TextField(
                            controller: controller,
                            autofocus: true,
                            decoration: const InputDecoration(
                              hintText: 'e.g. beach, winter, budget',
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Cancel'),
                            ),
                            FilledButton(
                              onPressed: () => Navigator.pop(
                                context,
                                controller.text.trim(),
                              ),
                              child: const Text('Add'),
                            ),
                          ],
                        ),
                      );
                      if (result != null && result.isNotEmpty) {
                        setState(() {
                          if (!_availableCategories.contains(result)) {
                            _availableCategories.add(result);
                          }
                          _selectedCategories.add(result);
                        });
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),

              const _FieldLabel('Places to Visit'),
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

              const _FieldLabel('Note'),
              const SizedBox(height: 8),
              TextFormField(
                controller: _noteController,
                maxLines: 4,
                maxLength: 300,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  hintText:
                      'Share a short tip or personal note about this trip...',
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
