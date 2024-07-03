import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_raho/model/client_model.dart';
import 'package:fit_raho/model/trainer_model.dart';
import 'package:fit_raho/src/gym/provider/client_data_provider.dart';
import 'package:fit_raho/src/gym/provider/trainer_data_provider.dart';
import 'package:fit_raho/src/gym/widgets/build_client_details.dart';
import 'package:fit_raho/src/gym/widgets/build_trainer_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AssignTrainerToClientScreen extends ConsumerStatefulWidget {
  const AssignTrainerToClientScreen({super.key});

  static const routeName = '/assign-trainer-to-client';

  @override
  ConsumerState<AssignTrainerToClientScreen> createState() =>
      _AssignTrainerToClientScreenState();
}

class _AssignTrainerToClientScreenState
    extends ConsumerState<AssignTrainerToClientScreen> {
  final TextEditingController _searchClientController = TextEditingController();
  final TextEditingController _searchTrainerController =
      TextEditingController();
  bool isLoading = false;
  bool isLoading1 = false;
  Client? _clientData;
  Trainer? _trainerData;
  void _searchClient() {
    ref.watch(clientDataProvider(_searchClientController.text)).when(
      data: (data) {
        setState(() {
          _clientData = data;
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

  void _searchTrainer() {
    ref.watch(trainerDataProvider(_searchTrainerController.text)).when(
      data: (data) {
        setState(() {
          _trainerData = data;
          isLoading1 = false;
        });
      },
      error: (error, stackTrace) {
        setState(() {
          isLoading1 = false;
        });
      },
      loading: () {
        setState(() {
          isLoading1 = true;
        });
      },
    );
  }

  void _submit() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      await firestore.runTransaction((transaction) async {
        // Reference to the trainer document
        DocumentReference trainerRef =
            firestore.collection('trainers').doc(_trainerData!.id);
        // Reference to the client document
        DocumentReference clientRef =
            firestore.collection('clients').doc(_clientData!.id);

        // Get the trainer document snapshot
        DocumentSnapshot trainerSnapshot = await transaction.get(trainerRef);

        if (!trainerSnapshot.exists) {
          throw Exception("Trainer does not exist!");
        }

        // Update the clients array in the trainer document
        transaction.update(trainerRef, {
          'clients': FieldValue.arrayUnion([_clientData!.id])
        });

        // Update the assignedTrainer field in the client document
        transaction.update(clientRef, {'assignedTrainerId': _trainerData!.id});
      });

      print('Transaction completed successfully.');
    } catch (e) {
      print('Failed to complete transaction: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assign Trainer to Client'),
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
                  controller: _searchClientController,
                  decoration: InputDecoration(
                    labelText: 'Search Client by Contact Number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: _searchClient,
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                ),
              ),
              const SizedBox(height: 20),
              isLoading
                  ? const CircularProgressIndicator.adaptive()
                  : _clientData != null
                      ? BuildClientDetails(
                          clientData: _clientData!,
                        )
                      : const Text('No client found with this contact number'),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: _searchTrainerController,
                  decoration: InputDecoration(
                    labelText: 'Search Trainer by Contact Number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: _searchTrainer,
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                ),
              ),
              const SizedBox(height: 20),
              isLoading1
                  ? const CircularProgressIndicator.adaptive()
                  : _trainerData != null
                      ? BuildTrainerDetails(
                          trainerData: _trainerData!,
                        )
                      : const Text('No trainer found with this contact number'),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FilledButton(
          onPressed: () {
            _submit();
          },
          child: const Text(
            'Assign',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
