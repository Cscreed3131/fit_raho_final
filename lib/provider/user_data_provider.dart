import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_raho/model/user_model.dart';
import 'package:fit_raho/services/user_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider for the Users class
final signOutProvider = StateNotifierProvider<UsersNotifier, Users>((ref) {
  return UsersNotifier();
});

class UsersNotifier extends StateNotifier<Users> {
  UsersNotifier() : super(Users.empty());

  void resetUser() {
    state = Users.empty();
  }

  void signOut() async {
    await FirebaseAuth.instance.signOut();
    resetUser();
  }
}

final userProvider = FutureProvider<Users?>((ref) async {
  UserService userService = UserService();
  final id = FirebaseAuth.instance.currentUser!.uid;
  return await userService.getUser(id);
});
