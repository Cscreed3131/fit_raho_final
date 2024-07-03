import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_raho/model/client_model.dart';
import 'package:fit_raho/model/user_model.dart';
import 'package:fit_raho/src/gym/provider/user_by_contact_number_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart'; // Import for date formatting

class ClientOnBoardingScreen extends ConsumerStatefulWidget {
  const ClientOnBoardingScreen({super.key});

  static const routeName = '/client-onboarding';

  @override
  ConsumerState<ClientOnBoardingScreen> createState() =>
      _ClientOnBoardingScreenState();
}

class _ClientOnBoardingScreenState
    extends ConsumerState<ClientOnBoardingScreen> {
  final TextEditingController _searchController = TextEditingController();
  String? _selectedSubscriptionPlan;
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  Users? _userData;
  Timestamp? _subscriptionStartDate; // Store start date
  Timestamp? _subscriptionEndDate; // Store end date

  void _searchUser() {
    // Fetch user data from firestore based on the search query
    ref.watch(userByContactNumberProvider(_searchController.text)).when(
      data: (data) {
        setState(() {
          _userData = data;
          isLoading = false;
        });
      },
      error: (error, stackTrace) {
        log(error.toString());
        setState(() {
          isLoading = false;
        });
      },
      loading: () {
        setState(() {
          isLoading = true;
        });
      },
    );
  }

  // isolate this method else where but not here ui and logic should be seperated
  // it will be better to use the clientService file. Look up
  void _submitClientData(Users? data) {
    try {
      // Calculate subscription start and end dates based on selected plan
      _subscriptionStartDate = Timestamp.now();
      _subscriptionEndDate = _calculateSubscriptionEndDate(
        _selectedSubscriptionPlan!,
        _subscriptionStartDate!,
      );

      FirebaseFirestore.instance.collection('clients').doc(data!.id).set(
            Client(
              id: data.id,
              userName: data.name,
              gymId: '', // assigned with gym Id
              subscriptionPlanId:
                  _selectedSubscriptionPlan!, // type of subscription plan 1 month,3 month,6 month, 12 month
              assignedTrainerId: '',
              dayRoutineId: '',
              contactNumber: data.contactNumber,
              subscriptionStartDate: _subscriptionStartDate!,
              subscriptionEndDate: _subscriptionEndDate!,
              profilePictureUrl: data.profilePictureUrl,
              enrolledClasses: [],
              progressRecords: [],
              attendanceRecords: [],
            ).toMap(),
          );
    } catch (e) {
      log('Error submitting client data: ${e.toString()}');
    }
  }

  // Helper function to calculate subscription end date
  Timestamp _calculateSubscriptionEndDate(
      String subscriptionPlan, Timestamp startDate) {
    // Assuming subscription plans are in months
    final duration =
        Duration(days: 30 * int.parse(subscriptionPlan.split(' ')[0]));
    return Timestamp.fromDate(startDate.toDate().add(duration).toUtc());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Onboard Client',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    labelText: 'Search by Contact Number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: _searchUser,
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                ),
              ),
              const SizedBox(height: 20),
              isLoading
                  ? const CircularProgressIndicator.adaptive()
                  : _userData != null
                      ? _buildUserDetails()
                      : const Text('No user found with this contact number'),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _userData != null
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: FilledButton(
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(const Size(
                      double.infinity,
                      50)), // Set the height to 50 and width to maximum available
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10), // Set the border radius to 12
                    ),
                  ),
                ),
                onPressed: () {
                  _submitClientData(_userData!);
                },
                child: Text(
                  'ADD TO CLIENTS LIST',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.background,
                  ),
                ),
              ),
            )
          : null,
    );
  }

  Widget _buildUserDetails() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.red.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 3,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Name: ${_userData!.name}',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 10),
              Text(
                'Email: ${_userData!.email}',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 10),
              Text(
                'Contact Number: ${_userData!.contactNumber}',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 10),
              Text(
                'Address: ${_userData!.address}',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 10),
              Text(
                'Gender: ${_userData!.gender}',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 10),
              Text(
                'DateOfBirth: ${_userData!.dateOfBirth}',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 10),
              Text(
                'Role: ${_userData!.role}',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 10),
              Text(
                'Membership Status: ${_userData!.membershipStatus}',
                style: const TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
        Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                DropdownButtonFormField<String>(
                  value: _selectedSubscriptionPlan,
                  onChanged: (value) {
                    setState(() {
                      _selectedSubscriptionPlan = value!;
                      // Calculate start and end dates when plan changes
                      _subscriptionStartDate = Timestamp.now();
                      _subscriptionEndDate = _calculateSubscriptionEndDate(
                          _selectedSubscriptionPlan!, _subscriptionStartDate!);
                    });
                  },
                  items: const [
                    DropdownMenuItem(
                      value: '1 month',
                      child: Text('1 month'),
                    ),
                    DropdownMenuItem(
                      value: '2 months',
                      child: Text('2 months'),
                    ),
                    DropdownMenuItem(
                      value: '3 months',
                      child: Text('3 months'),
                    ),
                    DropdownMenuItem(
                      value: '6 months',
                      child: Text('6 months'),
                    ),
                    DropdownMenuItem(
                      value: '12 months',
                      child: Text('12 months'),
                    ),
                  ],
                  decoration: InputDecoration(
                    labelText: 'Subscription Plan',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                // Display start and end dates if available
                if (_subscriptionStartDate != null &&
                    _subscriptionEndDate != null)
                  Column(
                    children: [
                      const SizedBox(height: 10),
                      Text(
                        'Start Date: ${DateFormat('dd/MM/yyyy').format(_subscriptionStartDate!.toDate())}',
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'End Date: ${DateFormat('dd/MM/yyyy').format(_subscriptionEndDate!.toDate())}',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
