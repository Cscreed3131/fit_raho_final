import 'package:fit_raho/src/gym/screens/client_on_boarding_screen.dart';
import 'package:fit_raho/src/home/widgets/my_drawer_widget.dart';
import 'package:fit_raho/widgets/profile_dialog_box_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GymHomeScreen extends StatelessWidget {
  const GymHomeScreen({super.key});

  static const routeName = '/gym-home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text(
          'Fit Raho',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        actions: const [ProfileDialogBox()],
      ),
      drawer: const MyDrawer(),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Text(
                  'Transaction',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                height: 245,
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        const CircleAvatar(
                          radius: 85,
                          child: Text(
                            '9000',
                            style: TextStyle(fontSize: 30),
                          ), // dynamic fetch from firebase
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Received',
                          style: TextStyle(
                            fontSize: 25,
                            color: Theme.of(context).colorScheme.background,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const CircleAvatar(
                          radius: 85,
                          child: Text(
                            '9000',
                            style: TextStyle(fontSize: 30),
                          ), // dynamic fetch from firebase
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Due',
                          style: TextStyle(
                            fontSize: 25,
                            color: Theme.of(context).colorScheme.background,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Text(
                  'New Members',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                height: 250,
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Text(
                      '${DateFormat('MMMM').format(DateTime.now())} Month',
                      style: TextStyle(
                        fontSize: 25,
                        color: Theme.of(context).colorScheme.background,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const CircleAvatar(
                      radius: 85,
                      child: Text(
                        '20',
                        style: TextStyle(fontSize: 30),
                      ), // dynamic fetch from firebase
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListTile(
                  title: const Text(
                    'Onboard Clients',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      ClientOnBoardingScreen.routeName,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
