import 'package:flutter/material.dart';

class ClientOnBoardingScreen extends StatefulWidget {
  const ClientOnBoardingScreen({super.key});

  static const routeName = '/client-onboarding';

  @override
  State<ClientOnBoardingScreen> createState() => _ClientOnBoardingScreenState();
}

class _ClientOnBoardingScreenState extends State<ClientOnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Client Onboarding Screen',
        ),
      ),
    );
  }
}
