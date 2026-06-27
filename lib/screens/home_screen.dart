import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../services/auth_service.dart';
import 'add_travel_plan_screen.dart';
import 'auth/login_screen.dart';
import 'travel_plan_list_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const routeName = '/home';

  void _showErasmusTipsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.lightbulb_outline, color: Colors.purple.shade700, size: 28),
                    const SizedBox(width: 12),
                    Text(
                      'Erasmus Travel Tips',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const _TipItem(
                  icon: Icons.train_outlined,
                  title: 'Eurail/Interrail Pass',
                  description: 'Get discount passes if you plan to travel across multiple European countries by train.',
                ),
                const SizedBox(height: 16),
                const _TipItem(
                  icon: Icons.badge_outlined,
                  title: 'ISIC Student Card',
                  description: 'Always carry your international student identity card for huge discounts on museums and transport.',
                ),
                const SizedBox(height: 16),
                const _TipItem(
                  icon: Icons.groups_outlined,
                  title: 'ESN Events',
                  description: 'Join local Erasmus Student Network groups for budget-friendly student trips and social events.',
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Got it!'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final currentUser = AuthService().currentUser;
    final email = currentUser?.email ?? 'Student';
    final displayName = currentUser?.displayName ?? email.split('@').first;
    final capitalizedName = displayName.isNotEmpty
        ? '${displayName[0].toUpperCase()}${displayName.substring(1)}'
        : 'Student';

    return Scaffold(
      appBar: AppBar(
        title: const Text('ErasmusBuddy'),
        actions: [
          IconButton(
            tooltip: 'My Profile',
            icon: const Icon(Icons.person_outline),
            onPressed: () {
              Navigator.pushNamed(context, ProfileScreen.routeName);
            },
          ),
          IconButton(
            tooltip: 'Logout',
            icon: const Icon(Icons.logout),
            onPressed: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Confirm Logout'),
                  content: const Text('Are you sure you want to log out of ErasmusBuddy?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text('Cancel'),
                    ),
                    FilledButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: const Text('Logout'),
                    ),
                  ],
                ),
              );

              if (confirm == true) {
                try {
                  await AuthService().logout();
                  if (context.mounted) {
                    Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                  }
                } catch (error) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Logout failed: ${error.toString()}'),
                      ),
                    );
                  }
                }
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Welcome & Profile Section ──
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, ProfileScreen.routeName);
                  },
                  child: CircleAvatar(
                    radius: 28,
                    backgroundColor: colorScheme.primary.withValues(alpha: 0.1),
                    child: Text(
                      capitalizedName.isNotEmpty ? capitalizedName[0].toUpperCase() : 'S',
                      style: TextStyle(
                        color: colorScheme.primary,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome back,',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, ProfileScreen.routeName);
                        },
                        child: Text(
                          capitalizedName,
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              'Discover and share travel plan ideas with fellow Erasmus students.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 28),

            // ── Quick Stats ──
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('travelIdeas').snapshots(),
              builder: (context, snapshot) {
                final totalIdeasCount = snapshot.hasData ? snapshot.data!.docs.length : 0;
                final myIdeasCount = snapshot.hasData
                    ? snapshot.data!.docs
                        .where((doc) => doc.get('createdBy') == (currentUser?.email ?? ''))
                        .length
                    : 0;

                return Row(
                  children: [
                    Expanded(
                      child: _StatCard(
                        title: 'Total Ideas',
                        value: '$totalIdeasCount',
                        icon: Icons.travel_explore,
                        color: Colors.blue.shade50,
                        iconColor: Colors.blue.shade700,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _StatCard(
                        title: 'My Shared Plans',
                        value: '$myIdeasCount',
                        icon: Icons.share_arrival_time_outlined,
                        color: Colors.teal.shade50,
                        iconColor: Colors.teal.shade700,
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 28),

            // ── Navigation Grid ──
            Text(
              'Quick Actions',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.15,
              children: [
                _GridNavigationCard(
                  icon: Icons.explore_outlined,
                  title: 'Explore Ideas',
                  subtitle: 'Browse all plans',
                  color: Colors.indigo.shade50,
                  iconColor: Colors.indigo.shade700,
                  onTap: () {
                    Navigator.pushNamed(context, TravelPlanListScreen.routeName);
                  },
                ),
                _GridNavigationCard(
                  icon: Icons.add_circle_outline,
                  title: 'Add Travel Idea',
                  subtitle: 'Share new trip',
                  color: Colors.green.shade50,
                  iconColor: Colors.green.shade700,
                  onTap: () {
                    Navigator.pushNamed(context, AddTravelPlanScreen.routeName);
                  },
                ),
                _GridNavigationCard(
                  icon: Icons.person_outline,
                  title: 'My Profile',
                  subtitle: 'Edit details & stats',
                  color: Colors.amber.shade50,
                  iconColor: Colors.amber.shade800,
                  onTap: () {
                    Navigator.pushNamed(context, ProfileScreen.routeName);
                  },
                ),
                _GridNavigationCard(
                  icon: Icons.lightbulb_outline,
                  title: 'Erasmus Guide',
                  subtitle: 'Travel tips & tricks',
                  color: Colors.purple.shade50,
                  iconColor: Colors.purple.shade700,
                  onTap: () {
                    _showErasmusTipsBottomSheet(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final Color iconColor;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: 20),
          const SizedBox(height: 12),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: iconColor,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: iconColor.withValues(alpha: 0.8),
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
    );
  }
}

class _GridNavigationCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final Color iconColor;
  final VoidCallback onTap;

  const _GridNavigationCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: iconColor, size: 24),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TipItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _TipItem({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.purple.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.purple.shade700, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
