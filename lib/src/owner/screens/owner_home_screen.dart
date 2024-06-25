import 'package:fit_raho/model/constants.dart';
import 'package:fit_raho/src/owner/widget/my_drawer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OwnerHomeScreen extends StatefulWidget {
  const OwnerHomeScreen({super.key});
  static const routeName = '/owner-home';
  @override
  State<OwnerHomeScreen> createState() => _OwnerHomeScreenState();
}

class _OwnerHomeScreenState extends State<OwnerHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.redColor,
        title: const Text(
          "Dashboard",
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
      ),
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
                  'Transactions',
                  style: TextStyle(
                    fontSize: 30,
                    color: Constants.redColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                height: 230,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 15),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Constants.redColor.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        CircleAvatar(
                          radius: 85,
                          backgroundColor: Colors.white,
                          child: Text('Number'),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Recieved',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ],
                    ),
                    SizedBox(width: 10),
                    Column(
                      children: [
                        CircleAvatar(
                          radius: 85,
                          backgroundColor: Colors.white,
                          child: Text('number'),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Due',
                          style: TextStyle(fontSize: 20, color: Colors.white),
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
                  'New Users',
                  style: TextStyle(
                    fontSize: 30,
                    color: Constants.redColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                height: 230,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 15),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Constants.redColor.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Text(
                      DateFormat('MMMM').format(DateTime.now()),
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    const CircleAvatar(
                      radius: 85,
                      backgroundColor: Colors.white,
                      child: Text(
                        '20',
                        style: TextStyle(fontSize: 40),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: const MyDrawer(),
    );
  }
}
