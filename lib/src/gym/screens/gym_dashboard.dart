import 'package:flutter/material.dart';

class GymDashboardScreen extends StatelessWidget {
  const GymDashboardScreen({super.key});
  static const routeName = '/gym-dashboard';
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Gym Dashboard Screen')),
    );
  }
}
