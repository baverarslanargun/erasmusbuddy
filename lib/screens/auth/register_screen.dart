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
	int step = 0;

	void nextStep() {
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
						const SizedBox(height: 24),
						Expanded(child: currentStepContent()),
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

	@override
	Widget build(BuildContext context) {
		return const Column(
			crossAxisAlignment: CrossAxisAlignment.stretch,
			children: [
				Text('Account information'),
				SizedBox(height: 16),
				TextField(
					decoration: InputDecoration(
						labelText: 'Name',
						border: OutlineInputBorder(),
					),
				),
				SizedBox(height: 16),
				TextField(
					keyboardType: TextInputType.emailAddress,
					decoration: InputDecoration(
						labelText: 'Email',
						border: OutlineInputBorder(),
					),
				),
				SizedBox(height: 16),
				TextField(
					obscureText: true,
					decoration: InputDecoration(
						labelText: 'Password',
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
				SizedBox(height: 16),
				TextField(
					decoration: InputDecoration(
						labelText: 'Home university',
						border: OutlineInputBorder(),
					),
				),
				SizedBox(height: 16),
				TextField(
					decoration: InputDecoration(
						labelText: 'Erasmus city',
						border: OutlineInputBorder(),
					),
				),
				SizedBox(height: 16),
				TextField(
					decoration: InputDecoration(
						labelText: 'Country',
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
					],
				),
				SizedBox(height: 24),
				Text('You can explore student travel ideas after registration.'),
			],
		);
	}
}
