import 'package:fit_raho/model/user_model.dart';
import 'package:fit_raho/services/user_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userByContactNumberProvider =
    FutureProvider.family<Users?, String>((ref, contactNumber) async {
  UserService userService = UserService();
  return userService.getUserByContactNumber(contactNumber);
});
