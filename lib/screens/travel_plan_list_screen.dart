import 'package:flutter/material.dart';

import 'travel_plan_detail_screen.dart';
import '../core/theme/app_colors.dart';
import '../models/travel_idea.dart';
import '../services/travel_idea_service.dart';

class TravelPlanListScreen extends StatefulWidget {
  const TravelPlanListScreen({super.key});

  static const routeName = '/travel-ideas';

  @override
  State<TravelPlanListScreen> createState() => _TravelPlanListScreenState();
}

class _TravelPlanListScreenState extends State<TravelPlanListScreen> {
  final TravelIdeaService _travelIdeaService = TravelIdeaService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Travel Ideas')),
      body: StreamBuilder<List<TravelIdea>>(
        stream: _travelIdeaService.getTravelIdeas(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Failed to load travel ideas.'),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () => setState(() {}),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          final ideas = snapshot.data ?? [];

          if (ideas.isEmpty) {
            return const Center(child: Text('No travel ideas yet.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: ideas.length,
            itemBuilder: (context, index) {
              final idea = ideas[index];
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, TravelPlanDetailScreen.routeName, arguments: idea.id);
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
          );
        },
      ),
    );
  }
}