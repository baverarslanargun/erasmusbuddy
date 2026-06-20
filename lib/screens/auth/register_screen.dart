import 'package:flutter/material.dart';

import '../home_screen.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
	const RegisterScreen({super.key});

	static const routeName = '/register';

	@override
	State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
	final formKey = GlobalKey<FormState>();
	int step = 0;

	void nextStep() {
		if (!(formKey.currentState?.validate() ?? false)) {
			return;
		}

		if (step < 2) {
			setState(() {
				step++;
			});
			return;
		}

		Navigator.pushReplacementNamed(context, HomeScreen.routeName);
	}

	void previousStep() {
		if (step > 0) {
			setState(() {
				step--;
			});
			return;
		}

		Navigator.pushReplacementNamed(context, LoginScreen.routeName);
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(title: const Text('Register')),
			body: Padding(
				padding: const EdgeInsets.all(24),
				child: Column(
					crossAxisAlignment: CrossAxisAlignment.stretch,
					children: [
						const SizedBox(height: 16),
						const Text('Join ErasmusBuddy'),
						const SizedBox(height: 8),
						Text('Step ${step + 1} of 3'),
						const SizedBox(height: 12),
						LinearProgressIndicator(value: (step + 1) / 3),
						const SizedBox(height: 24),
						Expanded(
							child: Form(
								key: formKey,
								child: currentStepContent(),
							),
						),
						Row(
							children: [
								Expanded(
									child: OutlinedButton(
										onPressed: previousStep,
										child: Text(step == 0 ? 'Login' : 'Back'),
									),
								),
								const SizedBox(width: 12),
								Expanded(
									child: FilledButton(
										onPressed: nextStep,
										child: Text(step == 2 ? 'Create account' : 'Next'),
									),
								),
							],
						),
					],
				),
			),
		);
	}

	Widget currentStepContent() {
		if (step == 0) {
			return const AccountStep();
		}

		if (step == 1) {
			return const ErasmusInfoStep();
		}

		return const TravelInterestsStep();
	}
}

class AccountStep extends StatelessWidget {
	const AccountStep({super.key});

	String? validateUsername(String? value) {
		final username = value?.trim() ?? '';

		if (username.isEmpty) {
			return 'Username is required';
		}

		if (username.length < 3) {
			return 'Username must be at least 3 characters';
		}

		if (username.contains(' ')) {
			return 'Username cannot include spaces';
		}

		return null;
	}

	String? validateEmail(String? value) {
		final email = value?.trim() ?? '';

		if (email.isEmpty) {
			return 'Email is required';
		}

		if (!email.contains('@') || !email.contains('.')) {
			return 'Enter a valid email';
		}

		return null;
	}

	String? validatePassword(String? value) {
		final password = value ?? '';

		if (password.isEmpty) {
			return 'Password is required';
		}

		if (password.length < 6) {
			return 'Password must be at least 6 characters';
		}

		return null;
	}

	@override
	Widget build(BuildContext context) {
		return Column(
			crossAxisAlignment: CrossAxisAlignment.stretch,
			children: [
				const Text('Account information'),
				const SizedBox(height: 8),
				const Text('Create your basic student account.'),
				const SizedBox(height: 16),
				TextFormField(
					validator: validateUsername,
					decoration: const InputDecoration(
						labelText: 'Username',
						prefixIcon: Icon(Icons.person_outline),
						border: OutlineInputBorder(),
					),
				),
				const SizedBox(height: 16),
				TextFormField(
					keyboardType: TextInputType.emailAddress,
					validator: validateEmail,
					decoration: const InputDecoration(
						labelText: 'Email',
						prefixIcon: Icon(Icons.email_outlined),
						border: OutlineInputBorder(),
					),
				),
				const SizedBox(height: 16),
				TextFormField(
					obscureText: true,
					validator: validatePassword,
					decoration: const InputDecoration(
						labelText: 'Password',
						prefixIcon: Icon(Icons.lock_outline),
						border: OutlineInputBorder(),
					),
				),
			],
		);
	}
}

class ErasmusInfoStep extends StatelessWidget {
	const ErasmusInfoStep({super.key});

	@override
	Widget build(BuildContext context) {
		return const Column(
			crossAxisAlignment: CrossAxisAlignment.stretch,
			children: [
				Text('Erasmus information'),
				SizedBox(height: 8),
				Text('Tell others where your Erasmus experience is happening.'),
				SizedBox(height: 16),
				TextField(
					decoration: InputDecoration(
						labelText: 'Home university',
						prefixIcon: Icon(Icons.school_outlined),
						border: OutlineInputBorder(),
					),
				),
				SizedBox(height: 16),
				TextField(
					decoration: InputDecoration(
						labelText: 'Erasmus city',
						prefixIcon: Icon(Icons.location_city_outlined),
						border: OutlineInputBorder(),
					),
				),
				SizedBox(height: 16),
				TextField(
					decoration: InputDecoration(
						labelText: 'Country',
						prefixIcon: Icon(Icons.flag_outlined),
						border: OutlineInputBorder(),
					),
				),
			],
		);
	}
}

class TravelInterestsStep extends StatelessWidget {
	const TravelInterestsStep({super.key});

	@override
	Widget build(BuildContext context) {
		return const Column(
			crossAxisAlignment: CrossAxisAlignment.stretch,
			children: [
				Text('Travel interests'),
				SizedBox(height: 8),
				Text('Choose a few travel idea types you might like.'),
				SizedBox(height: 16),
				Wrap(
					spacing: 8,
					runSpacing: 8,
					children: [
						Chip(label: Text('Weekend trips')),
						Chip(label: Text('Budget travel')),
						Chip(label: Text('City walks')),
						Chip(label: Text('Food spots')),
						Chip(label: Text('Museums')),
						Chip(label: Text('Nature')),
					],
				),
				SizedBox(height: 24),
				Text('You can explore student travel ideas after registration.'),
			],
		);
	}
}