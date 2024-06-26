import 'package:flutter/material.dart';

class TrainerHomeScreen extends StatelessWidget {
  const TrainerHomeScreen({super.key});
  static const routeName = '/trainer-home';
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Trainer Home Screen'),
      ),
    );
  }
}
