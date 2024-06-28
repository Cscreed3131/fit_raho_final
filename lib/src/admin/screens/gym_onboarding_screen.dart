import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_raho/model/gym_model.dart';
import 'package:fit_raho/model/user_model.dart';
import 'package:fit_raho/src/gym/provider/user_by_contact_number_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GymOnboardingScreen extends ConsumerStatefulWidget {
  const GymOnboardingScreen({super.key});
  static const routeName = '/gym-onboarding';

  @override
  ConsumerState<GymOnboardingScreen> createState() =>
      _GymOnboardingScreenState();
}

class _GymOnboardingScreenState extends ConsumerState<GymOnboardingScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contactNumberController =
      TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _createdAtController = TextEditingController();

  bool isLoading = false;
  Users? _userData;

  // Create a map for the opening hours (optional)

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _contactNumberController.dispose();
    _addressController.dispose();
    _searchController.dispose();
    _createdAtController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Create a new Gym object
      Gym gym = Gym.empty();
      gym.name = _nameController.text;
      gym.email = _emailController.text;
      gym.address = _addressController.text;
      gym.contactNumber = _contactNumberController.text;
      gym.createdAt = Timestamp.now();
      gym.facilities = [];
      gym.classSchedule = [];
      gym.clients = [];
      gym.subscriptionPlans = [];
      gym.trainers = [];
      gym.openingHours = {};
      gym.ownerId = _userData!.id;

      // Save the new Gym object to Firestore
      String docId = FirebaseFirestore.instance.collection('gyms').doc().id;
      gym.id = docId;
      await FirebaseFirestore.instance
          .collection('gyms')
          .doc(docId)
          .set(gym.toMap());
      // Show a success message and clear the form
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gym added successfully!')));
      _formKey.currentState!.reset();
    }
    return;
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Gym'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _contactNumberController,
                decoration: const InputDecoration(
                  labelText: 'Contact Number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a contact number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _searchController,
                decoration: const InputDecoration(
                  labelText: 'Owner Number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  suffixIcon: Icon(Icons.search),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an owner ID';
                  }
                  return null;
                },
                onTap: () {
                  _searchUser();
                },
              ),
              const SizedBox(height: 20),
              if (_userData != null) _buildUserDetails(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15.0),
        child: FilledButton(
          onPressed: _submitForm,
          child: Text(
            'Create GYM',
            style: TextStyle(
                color: Theme.of(context).colorScheme.background, fontSize: 25),
          ),
        ),
      ),
    );
  }

  Widget _buildUserDetails() {
    return Container(
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
    );
  }
}
