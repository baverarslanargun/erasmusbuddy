import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'firebase_options.dart';
import 'screens/add_travel_plan_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';
import 'screens/home_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/travel_plan_detail_screen.dart';
import 'screens/travel_plan_list_screen.dart';
import 'services/auth_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    runApp(const ErasmusBuddyApp());
  } catch (e, st) {
    // Eğer Firebase initialize sırasında hata olursa, hata ekranı başlat
    runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirebaseInitErrorScreen(error: e.toString()),
    ));
    // Log
    // ignore: avoid_print
    print('Firebase initialization error: $e\n$st');
  }
}

class FirebaseInitErrorScreen extends StatelessWidget {
  final String error;
  const FirebaseInitErrorScreen({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Initialization Error')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            const Text('Failed to initialize Firebase', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Text(error, textAlign: TextAlign.center),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () {
                // Yeniden başlatmayı tetikle
                (context as Element).reassemble();
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}

class ErasmusBuddyApp extends StatelessWidget {
  const ErasmusBuddyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ErasmusBuddy',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const AuthGate(),
      routes: {
        LoginScreen.routeName: (context) => const LoginScreen(),
        RegisterScreen.routeName: (context) => const RegisterScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
        ProfileScreen.routeName: (context) => const ProfileScreen(),
        TravelPlanListScreen.routeName: (context) =>
            const TravelPlanListScreen(),
        TravelPlanDetailScreen.routeName: (context) =>
            const TravelPlanDetailScreen(),
        AddTravelPlanScreen.routeName: (context) => const AddTravelPlanScreen(),
      },
    );
  }
}


class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: AuthService().authStateChanges,
      builder: (context, snapshot) {
        // Hata durumu
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  const Text('Connection Error'),
                  const SizedBox(height: 8),
                  Text(
                    snapshot.error.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 12),
                  ),
                  const SizedBox(height: 24),
                  FilledButton(
                    onPressed: () {
                      // Sayfayı yenile
                      (context as Element).reassemble();
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        }

        // Yükleniyor durumu
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // Kullanıcı giriş yaptıysa
        if (snapshot.hasData) {
          return const HomeScreen();
        }

        // Kullanıcı giriş yapmadıysa
        return const LoginScreen();
      },
    );
  }
}
