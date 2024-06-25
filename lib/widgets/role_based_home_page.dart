import 'package:fit_raho/provider/user_data_provider.dart';
import 'package:fit_raho/src/client/screens/client_home_screen.dart';
import 'package:fit_raho/src/owner/screens/owner_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../src/trainer/screens/trainer_home_screen.dart';

class RoleBasedHomePage extends ConsumerWidget {
  const RoleBasedHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(usersProvider);

    // Check the user's role and return the corresponding homepage
    if (user.role == 'owner') {
      return const OwnerHomeScreen();
    } else if (user.role == 'trainer') {
      return const TrainerHomeScreen();
    } else if (user.role == 'client') {
      return const ClientHomeScreen();
    } else {
      // Handle cases where the role is not recognized
      return Scaffold(
        appBar: AppBar(
          title: const Text('Unknown Role'),
        ),
        body: const Center(
          child: Text('Invalid User Role'),
        ),
      );
    }
  }
}
