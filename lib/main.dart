import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'screens/add_travel_plan_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';
import 'screens/home_screen.dart';
import 'screens/travel_plan_detail_screen.dart';
import 'screens/travel_plan_list_screen.dart';

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
      initialRoute: LoginScreen.routeName,
      routes: {
        LoginScreen.routeName: (context) => const LoginScreen(),
        RegisterScreen.routeName: (context) => const RegisterScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
        TravelPlanListScreen.routeName: (context) =>
            const TravelPlanListScreen(),
        TravelPlanDetailScreen.routeName: (context) =>
            const TravelPlanDetailScreen(),
        AddTravelPlanScreen.routeName: (context) => const AddTravelPlanScreen(),
      },
    );
  }
}
