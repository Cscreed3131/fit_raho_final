import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_raho/model/user_model.dart';
import 'package:fit_raho/services/user_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final signinProvider = StateNotifierProvider<SigninNotifier, Users>((ref) {
  return SigninNotifier();
});

class SigninNotifier extends StateNotifier<Users> {
  SigninNotifier() : super(Users.empty());

  Future<void> signIn(String email, String password) async {
    try {
      final auth = FirebaseAuth.instance;
      final result = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final userId = result.user!.uid;
      final user = await UserService().getUser(userId);
      if (user != null) {
        state = user;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
