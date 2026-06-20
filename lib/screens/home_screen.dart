import 'package:flutter/material.dart';

import 'add_travel_plan_screen.dart';
import 'travel_plan_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('ErasmusBuddy')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Welcome Section ──
            const SizedBox(height: 8),
            Text(
              'Welcome to ErasmusBuddy!',
              style: theme.textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'Discover and share travel ideas with fellow Erasmus students.',
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 32),

            // ── Navigation Cards ──
            _NavigationCard(
              icon: Icons.explore_outlined,
              title: 'Explore Travel Ideas',
              subtitle: 'Browse travel plans shared by other students',
              backgroundColor: colorScheme.primaryContainer,
              iconColor: colorScheme.onPrimaryContainer,
              onTap: () {
                Navigator.pushNamed(context, TravelPlanListScreen.routeName);
              },
            ),
            const SizedBox(height: 16),
            _NavigationCard(
              icon: Icons.add_circle_outline,
              title: 'Add Travel Idea',
              subtitle: 'Create and share your own travel plan',
              backgroundColor: colorScheme.secondaryContainer,
              iconColor: colorScheme.onSecondaryContainer,
              onTap: () {
                Navigator.pushNamed(context, AddTravelPlanScreen.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// A simple card widget used for navigation on the home screen.
class _NavigationCard extends StatelessWidget {
  const _NavigationCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.backgroundColor,
    required this.iconColor,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color backgroundColor;
  final Color iconColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: iconColor),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
