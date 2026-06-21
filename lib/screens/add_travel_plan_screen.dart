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
    // TODO: call service to create travel idea
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
              ),

              const SizedBox(height: 20),

              const _FieldLabel('Duration'),
              const SizedBox(height: 8),
              TextFormField(
                controller: _durationController,
                decoration: const InputDecoration(hintText: 'e.g. 2-3 days'),
              ),
              const SizedBox(height: 20),

              const _FieldLabel('Category'),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _availableCategories.map((category) {
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
                }).toList(),
              ),
              const SizedBox(height: 20),

              const _FieldLabel('Places to Visit'),
              const SizedBox(height: 8),
              TextFormField(
                controller: _placesController,
                maxLines: 3,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  hintText: 'e.g. Old Town, Bratislava Castle, Danube River',
                  alignLabelWithHint: true,
                ),
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
                onPressed: _onSubmit,
                icon: const Icon(Icons.send),
                label: const Text(
                  'Share Travel Idea',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
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
