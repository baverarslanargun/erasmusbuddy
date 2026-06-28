import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  static const routeName = '/register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  final _authService = AuthService();

  int step = 0;
  String username = '';
  String email = '';
  String password = '';
  bool isLoading = false;

  Future<void> nextStep() async {
    if (!(formKey.currentState?.validate() ?? false)) {
      return;
    }

    if (step < 2) {
      formKey.currentState?.save();
      setState(() {
        step++;
      });
      return;
    }

    await register();
  }

  Future<void> register() async {
    setState(() {
      isLoading = true;
    });

    try {
      await _authService.register(email, password, username);

      if (!mounted) {
        return;
      }

      Navigator.of(context).popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (error) {
      if (!mounted) {
        return;
      }

      final message = switch (error.code) {
        'email-already-in-use' =>
          'An account already exists for this email. Try logging in.',
        'invalid-email' => 'Enter a valid email address.',
        'weak-password' => 'Choose a stronger password.',
        'network-request-failed' =>
          'Network unavailable. Check your connection and try again.',
        _ => 'Registration failed. Please try again.',
      };
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    } catch (_) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Registration failed')));
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  void previousStep() {
    if (step > 0) {
      setState(() {
        step--;
      });
      return;
    }

    Navigator.maybePop(context);
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
                child: SingleChildScrollView(child: currentStepContent()),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: isLoading ? null : previousStep,
                    child: Text(step == 0 ? 'Login' : 'Back'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    onPressed: isLoading ? null : nextStep,
                    child: isLoading
                        ? const SizedBox(
                            height: 16,
                            width: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(step == 2 ? 'Create account' : 'Next'),
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
      return AccountStep(
        onSavedUsername: (value) {
          username = value;
        },
        onSavedEmail: (value) {
          email = value;
        },
        onSavedPassword: (value) {
          password = value;
        },
      );
    }

    if (step == 1) {
      return const ErasmusInfoStep();
    }

    return const TravelInterestsStep();
  }
}

class AccountStep extends StatefulWidget {
  const AccountStep({
    super.key,
    required this.onSavedUsername,
    required this.onSavedEmail,
    required this.onSavedPassword,
  });

  final ValueChanged<String> onSavedUsername;
  final ValueChanged<String> onSavedEmail;
  final ValueChanged<String> onSavedPassword;

  @override
  State<AccountStep> createState() => _AccountStepState();
}

class _AccountStepState extends State<AccountStep> {
  final passwordController = TextEditingController();
  bool showPassword = false;
  bool showConfirmPassword = false;

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

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

  String? validateConfirmPassword(String? value) {
    final confirmPassword = value ?? '';

    if (confirmPassword.isEmpty) {
      return 'Confirm your password';
    }

    if (confirmPassword != passwordController.text) {
      return 'Passwords do not match';
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
          onSaved: (value) {
            widget.onSavedUsername(value?.trim() ?? '');
          },
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
          onSaved: (value) {
            widget.onSavedEmail(value?.trim() ?? '');
          },
          decoration: const InputDecoration(
            labelText: 'Email',
            prefixIcon: Icon(Icons.email_outlined),
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: passwordController,
          obscureText: !showPassword,
          validator: validatePassword,
          onSaved: (value) {
            widget.onSavedPassword(value ?? '');
          },
          decoration: InputDecoration(
            labelText: 'Password',
            prefixIcon: const Icon(Icons.lock_outline),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  showPassword = !showPassword;
                });
              },
              icon: Icon(
                showPassword
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
              ),
            ),
            border: const OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          obscureText: !showConfirmPassword,
          validator: validateConfirmPassword,
          decoration: InputDecoration(
            labelText: 'Confirm password',
            prefixIcon: const Icon(Icons.lock_outline),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  showConfirmPassword = !showConfirmPassword;
                });
              },
              icon: Icon(
                showConfirmPassword
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
              ),
            ),
            border: const OutlineInputBorder(),
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
        SizedBox(height: 8),
        Text('Prototype fields: these details are not uploaded or stored yet.'),
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
        Text('Preview the travel idea types planned for personalization.'),
        SizedBox(height: 8),
        Text('These prototype interests are not stored in the current MVP.'),
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
