import 'package:fit_raho/src/home/screens/gym_home_screen.dart';
import 'package:flutter/material.dart';

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
              color: Theme.of(context).primaryColor,
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
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.of(context).pushNamed(GymHomeScreen.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.list),
            title: const Text('Member List'),
            onTap: () {
              // Update the state of the app
              // ...
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Trainer List'),
            onTap: () {
              // Update the state of the app
              // ...
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.card_membership),
            title: const Text('Subscription Plan'),
            onTap: () {
              // Update the state of the app
              // ...
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.subscriptions),
            title: const Text('Subscription'),
            onTap: () {
              // Update the state of the app
              // ...
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.class_),
            title: const Text('Gym Class'),
            onTap: () {
              // Update the state of the app
              // ...
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.fitness_center),
            title: const Text('Facilities'),
            onTap: () {
              // Update the state of the app
              // ...
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
