import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';

class AddTravelPlanScreen extends StatefulWidget {
  const AddTravelPlanScreen({super.key});

  static const routeName = '/add-travel-idea';

  @override
  State<AddTravelPlanScreen> createState() => _AddTravelPlanScreenState();
}

class _AddTravelPlanScreenState extends State<AddTravelPlanScreen> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _countryController = TextEditingController();
  final _citiesController = TextEditingController();
  final _durationController = TextEditingController();
  final _placesController = TextEditingController();
  final _noteController = TextEditingController();

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
    super.dispose();
  }

  void _onSubmit() {
    if (!_formKey.currentState!.validate()) return;
    // TODO: call service to create travel idea

    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      setState(() => _isSubmitting = false);

      // Clear form
      _titleController.clear();
      _countryController.clear();
      _citiesController.clear();
      _durationController.clear();
      _placesController.clear();
      _noteController.clear();
      setState(() => _selectedCategories.clear());

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

              const _FieldLabel('Country'),
              const SizedBox(height: 8),
              TextFormField(
                controller: _countryController,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  hintText: 'e.g. Hungary, Slovakia',
                ),
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? 'Country is required'
                    : null,
              ),
              const SizedBox(height: 20),

              const _FieldLabel('Cities'),
              const SizedBox(height: 8),
              TextFormField(
                controller: _citiesController,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  hintText: 'e.g. Bratislava, Budapest',
                ),
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? 'At least one city is required'
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
                controller: _placesController,
                maxLines: 3,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  hintText: 'e.g. Low, Medium, High or ~EUR 200',
                ),
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? 'Places to visit is required'
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
