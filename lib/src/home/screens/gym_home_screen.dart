import 'package:flutter/material.dart';

class GymHomeScreen extends StatelessWidget {
  const GymHomeScreen({super.key});

  static const routeName = '/gym-home';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Owner Home Screen'),
      ),
    );
  }
}
