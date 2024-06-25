import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_raho/model/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider for the Users class
final usersProvider = StateNotifierProvider<UsersNotifier, Users>((ref) {
  return UsersNotifier();
});

class UsersNotifier extends StateNotifier<Users> {
  UsersNotifier() : super(Users.empty());

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      String userId = userCredential.user!.uid;
      await fetchUserData(userId);
    } catch (e) {
      log("Error signing in: $e");
    }
  }

  Future<void> fetchUserData(String userId) async {
    try {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(userId).get();
      if (userDoc.exists) {
        state = Users.fromMap(userDoc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      // Handle errors appropriately
      log("Error fetching user data: $e");
    }
  }

  void resetUser() {
    state = Users.empty();
  }

  void signOut() async {
    await FirebaseAuth.instance.signOut();
    resetUser();
  }
}
