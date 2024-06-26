import 'package:fit_raho/provider/user_data_provider.dart';
import 'package:fit_raho/src/home/screens/client_home_screen.dart';
import 'package:fit_raho/src/home/screens/gym_home_screen.dart';
import 'package:fit_raho/src/home/screens/trainer_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String role = ref.watch(userProvider).when(data: (data) {
      if (data != null) {
        return data.role;
      } else {
        return 'unknown';
      }
    }, error: (error, stack) {
      return 'unknown';
    }, loading: () {
      return 'unknown';
    });

    switch (role) {
      case 'owner':
        return const GymHomeScreen(); // Return the Owner's home screen widget
      case 'client':
        return const ClientHomeScreen(); // Return the Client's home screen widget
      case 'trainer':
        return const TrainerHomeScreen(); // Return the Trainer's home screen widget
      default:
        return const Scaffold(
          body: Center(
            child: Text(
              'Unknown Role',
            ),
          ),
        ); // Return a default screen or error screen for unknown roles
    }
  }
}
