import 'package:fit_raho/widgets/profile_dialog_box_widget.dart';
import 'package:flutter/material.dart';

class ClientHomeScreen extends StatelessWidget {
  const ClientHomeScreen({super.key});

  static const routeName = '/client-home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fit Raho'),
        actions: const [ProfileDialogBox()],
      ),
      body: const Center(
        child: Text('Client Home Screen'),
      ),
    );
  }
}
