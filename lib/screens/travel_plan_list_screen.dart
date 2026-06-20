import 'package:flutter/material.dart';

import 'travel_plan_detail_screen.dart';

class TravelPlanListScreen extends StatelessWidget {
  const TravelPlanListScreen({super.key});
  
  static final List<Map<String, String>> _placeholderIdeas = [
  {
    'title': 'Budapest + Bratislava Weekend',
    'country': 'Hungary, Slovakia',
    'duration': '2-3 days',
    'description': 'A perfect idea to spend time at the weekends.',
  },
  {
    'title': 'Barcelona Beach Experience',
    'country': 'Spain',
    'duration': '4-5 days',
    'description': 'Explore the beautiful beaches and Gothic architecture.',
  },
  {
    'title': 'Alps Adventure',
    'country': 'Switzerland',
    'duration': '5-6 days',
    'description': 'Mountain hiking and scenic train rides through the Alps.',
  },
  {
    'title': 'Amsterdam Canals Tour',
    'country': 'Netherlands',
    'duration': '3-4 days',
    'description': 'Cycling through the charming streets and picturesque canals.',
  },
  {
    'title': 'Rome Historical Journey',
    'country': 'Italy',
    'duration': '3-4 days',
    'description': 'Visit ancient monuments and enjoy authentic Italian cuisine.',
  },
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
                    idea['title']!,
                    style: Theme.of(context).textTheme.titleMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    idea['country']!,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Duration: ${idea['duration']!}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    idea['description']!,
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
