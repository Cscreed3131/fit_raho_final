import 'package:fit_raho/src/trainer/screens/create_workout_screen.dart';
import 'package:fit_raho/src/trainer/screens/client_list_screen.dart';
import 'package:fit_raho/widgets/profile_dialog_box_widget.dart';
import 'package:flutter/material.dart';

class TrainerHomeScreen extends StatelessWidget {
  const TrainerHomeScreen({super.key});
  static const routeName = '/trainer-home';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Fit Raho',
          style: TextStyle(fontSize: 30),
        ),
        actions: const [
          ProfileDialogBox(),
        ],
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                title: const Text('Add Workout Routine'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(CreateWorkoutScreen.routeName);
                },
              ),
              ListTile(
                title: const Text('Manage Your Clients'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.of(context).pushNamed(ClientListScreen.routeName);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
