import 'package:flutter/material.dart';

class TrainerHomeScreen extends StatefulWidget {
  // List<Trainer> train;
  static const routeName = '/trainer-home';
  const TrainerHomeScreen({super.key});

  @override
  State<TrainerHomeScreen> createState() => _TrainerHomeScreenState();
}

class _TrainerHomeScreenState extends State<TrainerHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFD90E0E),
        title: const Text('Trainer'),
      ),
    );
  }
}
