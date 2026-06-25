// SONRA:
import 'package:flutter/material.dart';

import 'travel_plan_detail_screen.dart';
import '../core/theme/app_colors.dart';
import '../models/travel_idea.dart';

class TravelPlanListScreen extends StatelessWidget {
  const TravelPlanListScreen({super.key});

  static final List<TravelIdea> _placeholderIdeas = [
    TravelIdea(
      id: '1',
      title: 'Budapest + Bratislava Weekend',
      destination: 'Hungary, Slovakia',
      duration: '2-3 days',
      description: 'A perfect idea to spend time at the weekends.',
      budget: '',
      createdBy: '',
      createdAt: DateTime(2025, 1, 1),
    ),
    TravelIdea(
      id: '2',
      title: 'Barcelona Beach Experience',
      destination: 'Spain',
      duration: '4-5 days',
      description: 'Explore the beautiful beaches and Gothic architecture.',
      budget: '',
      createdBy: '',
      createdAt: DateTime(2025, 1, 1),
    ),
    TravelIdea(
      id: '3',
      title: 'Alps Adventure',
      destination: 'Switzerland',
      duration: '5-6 days',
      description: 'Mountain hiking and scenic train rides through the Alps.',
      budget: '',
      createdBy: '',
      createdAt: DateTime(2025, 1, 1),
    ),
    TravelIdea(
      id: '4',
      title: 'Amsterdam Canals Tour',
      destination: 'Netherlands',
      duration: '3-4 days',
      description: 'Cycling through the charming streets and picturesque canals.',
      budget: '',
      createdBy: '',
      createdAt: DateTime(2025, 1, 1),
    ),
    TravelIdea(
      id: '5',
      title: 'Rome Historical Journey',
      destination: 'Italy',
      duration: '3-4 days',
      description: 'Visit ancient monuments and enjoy authentic Italian cuisine.',
      budget: '',
      createdBy: '',
      createdAt: DateTime(2025, 1, 1),
    ),
  ];

  static const routeName = '/travel-ideas';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Travel Ideas')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _placeholderIdeas.length,
        itemBuilder: (context, index) {
          final idea = _placeholderIdeas[index];
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, TravelPlanDetailScreen.routeName);
            },
            child: Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    idea.title,
                    style: Theme.of(context).textTheme.titleMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 16,
                      color: AppColors.secondary,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        idea.destination,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today,
                      size: 16,
                      color: AppColors.secondary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      idea.duration,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                  const SizedBox(height: 8),
                  Text(
                    idea.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
          );
        },
      ),
    );
  }
}
