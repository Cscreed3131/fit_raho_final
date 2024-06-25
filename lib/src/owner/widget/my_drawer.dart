import 'package:fit_raho/provider/user_data_provider.dart';
import 'package:fit_raho/src/owner/screens/member_list_screen.dart';
import 'package:fit_raho/src/owner/screens/trainer_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: const Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text('Dashboard'),
            onTap: () {
              // Handle navigation to dashboard
            },
          ),
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text('Members'),
            onTap: () {
              Navigator.of(context).pushNamed(MemberListScreen.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.fitness_center),
            title: const Text('Trainers'),
            onTap: () {
              Navigator.of(context).pushNamed(TrainerListScreen.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.subscriptions),
            title: const Text('Subscriptions'),
            onTap: () {
              // Handle navigation to subscriptions
            },
          ),
          ListTile(
            leading: const Icon(Icons.fitness_center),
            title: const Text('Workouts'),
            onTap: () {
              // Handle navigation to workouts
            },
          ),
          ListTile(
            leading: const Icon(Icons.sports_gymnastics),
            title: const Text('Facilities'),
            onTap: () {
              // Handle navigation to facilities
            },
          ),
          Consumer(
            builder: (context, ref, child) => ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                ref.watch(usersProvider.notifier).signOut();
                // Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}
