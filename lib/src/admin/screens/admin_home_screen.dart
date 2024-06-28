import 'package:fit_raho/src/admin/screens/gym_onboarding_screen.dart';
import 'package:fit_raho/widgets/profile_dialog_box_widget.dart';
import 'package:flutter/material.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});
  static const routeName = '/admin-home';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Admin Panel',
          style: TextStyle(fontSize: 30),
        ),
        actions: const [ProfileDialogBox()],
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                title: const Text(
                  'Onboard New Gym',
                  style: TextStyle(fontSize: 25),
                ),
                trailing: const Icon(Icons.arrow_forward_ios_rounded),
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(GymOnboardingScreen.routeName);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
