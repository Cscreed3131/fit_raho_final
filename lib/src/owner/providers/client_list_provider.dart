import 'package:fit_raho/model/client_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final clientDataProvider = FutureProvider<List<Client>>((ref) async {
  final querySnapshot = await FirebaseFirestore.instance
      .collection('users')
      .where('role', isEqualTo: 'client')
      .get();

  return querySnapshot.docs.map((doc) {
    return Client(
      docId: doc['userId'],
      userName: doc['userName'],
      email: doc['email'],
      phoneNumber: doc['phoneNumber'],
      password: doc['password'],
      profilePicture: doc['profilePicture'],
      createdOn: doc['createdOn'],
      isGymOwner: doc['isGymOwner'],
      role: doc['role'], currentGym: doc['gymName'],
      // gym:doc['gym']],
      // workout:doc['workout'],
    );
  }).toList();
});
