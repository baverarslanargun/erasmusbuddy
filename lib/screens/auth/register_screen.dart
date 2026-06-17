import 'package:flutter/material.dart';

import '../home_screen.dart';
import 'login_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  static const routeName = '/register';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 32),
            const Text('Create account'),
            const SizedBox(height: 8),
            const Text('Enter your information to create an account.'),
            const SizedBox(height: 24),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, HomeScreen.routeName);
              },
              child: const Text('Register'),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, LoginScreen.routeName);
              },
              child: const Text('Go to login screen'),
            ),
          ],
        ),
      ),
    );
  }
}
