import 'package:fit_raho/model/trainer_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final trainerListProvider = FutureProvider<List<Trainer>>((ref) async {
  final querySnapshot = await FirebaseFirestore.instance
      .collection('users')
      .where('role', isEqualTo: 'trainer')
      .get();

  return querySnapshot.docs.map((doc) {
    return Trainer(
      userId: doc['userId'],
      trainerName: doc['userName'],
      experience: doc['experience'],
      phoneNumber: doc['phoneNumber'],
      gender: doc['gender'],
      dateOfBirth: doc['dateOfBirth'],
      gymName: doc['gymName'],
      profilePicture: doc['profilePicture'],
      workingHours: doc['workingHours'],
    );
  }).toList();
});
