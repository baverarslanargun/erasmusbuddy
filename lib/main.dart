import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';

void main() {
  runApp(const ErasmusBuddyApp());
}

class ErasmusBuddyApp extends StatelessWidget {
  const ErasmusBuddyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ErasmusBuddy',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const Scaffold(),
    );
  }
}
