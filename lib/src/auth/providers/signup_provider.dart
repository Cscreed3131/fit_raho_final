import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fit_raho/model/user_model.dart';
import 'package:fit_raho/services/user_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final signupProvider = StateNotifierProvider<SignupNotifier, Users>((ref) {
  return SignupNotifier();
});

// Step 3: Modify SignupNotifier to use StateNotifier
class SignupNotifier extends StateNotifier<Users> {
  SignupNotifier() : super(Users.empty());

  Future<void> submit(Users? user, String password, File file) async {
    if (user == null) {
      // Handle the case when the user is null
      return;
    }
    try {
      final auth = FirebaseAuth.instance;
      final result = await auth.createUserWithEmailAndPassword(
        email: user.email,
        password: password,
      );
      final userId = result.user!.uid;
      user.id = userId;
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('client_images')
          .child('$userId.jpg');
      await storageRef.putFile(file);
      final imageUrl = await storageRef.getDownloadURL();
      user.profilePictureUrl = imageUrl;
      // Update the state with the new user data
      state = user;
      UserService().addUser(user);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
