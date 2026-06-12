import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: const Color(0xFF1E6BB8),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 32,
                  backgroundColor: Color(0xFF1E6BB8),
                  child: Icon(Icons.person, size: 32, color: Colors.white),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'User Name',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'user@email.com',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 32),
            DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  const TabBar(
                    labelColor: Color(0xFF1E6BB8),
                    tabs: [
                      Tab(text: 'My Plans'),
                      Tab(text: 'Saved'),
                    ],
                  ),
                  SizedBox(
                    height: 300,
                    child: TabBarView(
                      children: [
                        const Center(child: Text('No plans created yet')),
                        const Center(child: Text('No saved plans yet')),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
