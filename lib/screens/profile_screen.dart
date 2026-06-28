import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../core/theme/app_colors.dart';
import '../models/travel_idea.dart';
import '../services/auth_service.dart';
import '../services/travel_idea_service.dart';
import 'auth/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  static const routeName = '/profile';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TravelIdeaService _travelIdeaService = TravelIdeaService();
  bool _isEditingName = false;
  late TextEditingController _nameController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final user = _auth.currentUser;
    final email = user?.email ?? 'Student';
    final defaultName = email.split('@').first;
    final capitalizedDefaultName = defaultName.isNotEmpty
        ? '${defaultName[0].toUpperCase()}${defaultName.substring(1)}'
        : 'Student';
    _nameController = TextEditingController(
      text: user?.displayName ?? capitalizedDefaultName,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _updateProfileName() async {
    final newName = _nameController.text.trim();
    if (newName.isEmpty) return;

    setState(() {
      _isLoading = true;
    });

    try {
      await _auth.currentUser?.updateDisplayName(newName);
      await _auth.currentUser?.reload();
      setState(() {
        _isEditingName = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile updated successfully!'),
            backgroundColor: AppColors.secondary,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update profile: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final user = _auth.currentUser;
    final email = user?.email ?? 'No email';
    final userId = user?.uid ?? '';
    final defaultName = email.split('@').first;
    final capitalizedDefaultName = defaultName.isNotEmpty
        ? '${defaultName[0].toUpperCase()}${defaultName.substring(1)}'
        : 'Student';
    final displayName = user?.displayName ?? capitalizedDefaultName;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        actions: [
          IconButton(
            tooltip: 'Logout',
            icon: const Icon(Icons.logout),
            onPressed: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Confirm Logout'),
                  content: const Text('Are you sure you want to log out?'),
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
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      LoginScreen.routeName,
                      (route) => false,
                    );
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Avatar
            CircleAvatar(
              radius: 50,
              backgroundColor: colorScheme.primary.withValues(alpha: 0.1),
              child: Text(
                displayName.isNotEmpty ? displayName[0].toUpperCase() : 'S',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.primary,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Profile info and editing
            if (_isEditingName)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Display Name',
                        isDense: true,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  if (_isLoading)
                    const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  else ...[
                    IconButton(
                      icon: const Icon(Icons.check, color: Colors.green),
                      onPressed: _updateProfileName,
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          _isEditingName = false;
                          _nameController.text =
                              user?.displayName ?? capitalizedDefaultName;
                        });
                      },
                    ),
                  ],
                ],
              )
            else
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      displayName,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit, size: 20),
                    onPressed: () {
                      setState(() {
                        _isEditingName = true;
                      });
                    },
                  ),
                ],
              ),

            Text(
              email,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 32),

            const Divider(),
            const SizedBox(height: 24),

            // Statistics Header
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'My Statistics',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Statistics Cards
            StreamBuilder<int>(
              stream: _travelIdeaService.getUserTravelIdeaCount(userId),
              builder: (context, snapshot) {
                final myIdeasCount = snapshot.data ?? 0;
                return SizedBox(
                  width: double.infinity,
                  child: _StatCard(
                    title: 'My Shared Ideas',
                    value: '$myIdeasCount',
                    icon: Icons.share,
                    color: Colors.blue.shade50,
                    iconColor: Colors.blue.shade700,
                  ),
                );
              },
            ),
            const SizedBox(height: 32),

            // User's Shared Ideas List Header
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'My Travel Ideas',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Stream list of user's own travel ideas
            StreamBuilder<List<TravelIdea>>(
              stream: _travelIdeaService.getUserTravelIdeas(userId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerHighest.withValues(
                        alpha: 0.3,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: colorScheme.outlineVariant),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.travel_explore,
                          size: 48,
                          color: colorScheme.onSurfaceVariant.withValues(
                            alpha: 0.5,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'You haven\'t shared any travel ideas yet.',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }

                final ideas = snapshot.data!;
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: ideas.length,
                  itemBuilder: (context, index) {
                    final idea = ideas[index];

                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        title: Text(idea.title),
                        subtitle: Text(
                          '${idea.destination} • ${idea.duration}',
                        ),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/travel-idea-detail',
                            arguments: idea.id,
                          );
                        },
                      ),
                    );
                  },
                );
              },
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
          Icon(icon, color: iconColor),
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
