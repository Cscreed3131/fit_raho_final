import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_raho/model/trainer_model.dart';
import 'package:fit_raho/model/user_model.dart';
import 'package:fit_raho/src/gym/provider/user_by_contact_number_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TrainerOnboardingScreen extends ConsumerStatefulWidget {
  const TrainerOnboardingScreen({super.key});

  static const routeName = '/trainer-onboarding';

  @override
  ConsumerState<TrainerOnboardingScreen> createState() =>
      _TrainerOnboardingScreenState();
}

class _TrainerOnboardingScreenState
    extends ConsumerState<TrainerOnboardingScreen> {
  final TextEditingController _searchController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  Users? _userData;

  // Controllers for trainer details
  final TextEditingController _specializationController =
      TextEditingController();
  final TextEditingController _yearsOfExperienceController =
      TextEditingController();

  // Use a Set to store selected days, allowing for multiple selections
  final Set<String> _selectedDays = {};
  // Use a Map to store availability, with days as keys and time slots as values
  final Map<String, List<String>> _availability = {
    'Monday': [],
    'Tuesday': [],
    'Wednesday': [],
    'Thursday': [],
    'Friday': [],
    'Saturday': [],
    'Sunday': [],
  };
  final TextEditingController _certificationsController =
      TextEditingController();

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
  // it will be better to use the trainerService file. Look up
  void _submitTrainerData(Users? data) {
    try {
      // Create a new Trainer object
      final trainer = Trainer(
        id: data!.id,
        userName: data.name,
        specialization: _specializationController.text,
        profilePictureUrl: data.profilePictureUrl,
        gymId: '', // add later through data base
        // but this id should be fetched from the gym manager id.
        contactNumber: data.contactNumber,
        clients: [],
        certifications: _certificationsController.text.split(','),
        yearsOfExperience: int.tryParse(_yearsOfExperienceController.text) ?? 0,
        availability: _availability,
        ratings: [],
      );

      // Save the Trainer data to Firestore
      FirebaseFirestore.instance.collection('trainers').doc(data.id).set(
            trainer.toMap(),
          );
    } catch (e) {
      log('Error submitting trainer data: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Onboard Trainer',
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
                  _submitTrainerData(_userData!);
                },
                child: Text(
                  'ADD TO TRAINERS LIST',
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
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
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
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _specializationController,
              decoration: const InputDecoration(
                labelText: 'Specialization',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter specialization';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _yearsOfExperienceController,
              decoration: const InputDecoration(
                labelText: 'Years of Experience',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter years of experience';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            // Add a section for availability
            const Text('Availability'),
            const SizedBox(height: 10),
            // Use a Wrap widget to allow multiple day selections
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final day in [
                  'Monday',
                  'Tuesday',
                  'Wednesday',
                  'Thursday',
                  'Friday',
                  'Saturday',
                  'Sunday'
                ])
                  ChoiceChip(
                    label: Text(day),
                    selected: _selectedDays.contains(day),
                    onSelected: (value) {
                      setState(() {
                        if (value) {
                          _selectedDays.add(day);
                        } else {
                          _selectedDays.remove(day);
                        }
                      });
                    },
                  ),
              ],
            ),
            const SizedBox(height: 10),
            // Add a dropdown for time slots
            for (final day in _availability.keys)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$day Availability',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  DropdownButtonFormField<String>(
                    value: _availability[day]?.firstOrNull,
                    onChanged: (value) {
                      setState(() {
                        if (value != null) {
                          _availability[day]!.add(value);
                        }
                      });
                    },
                    items: const [
                      DropdownMenuItem(
                        value: 'None',
                        child: Text('None'),
                      ),
                      DropdownMenuItem(
                        value: 'Full Time',
                        child: Text('Full Time'),
                      ),
                      DropdownMenuItem(
                        value: '9:00 AM - 1:00 PM',
                        child: Text('9:00 AM - 1:00 PM'),
                      ),
                      DropdownMenuItem(
                        value: '1:00 PM - 5:00 PM',
                        child: Text('1:00 PM - 5:00 PM'),
                      ),
                      DropdownMenuItem(
                        value: '5:00 PM - 9:00 PM',
                        child: Text('5:00 PM - 9:00 PM'),
                      ),
                    ],
                    decoration: const InputDecoration(
                      labelText: 'Select Time Slot',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            const SizedBox(height: 10),
            // Add a section for certifications
            const Text('Certifications'),
            const SizedBox(height: 10),
            // Add a text field for entering certifications
            TextFormField(
              controller: _certificationsController,
              decoration: const InputDecoration(
                labelText: 'Enter Certifications (comma-separated)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            // Add a section for ratings
          ],
        ),
      ),
    );
  }
}
