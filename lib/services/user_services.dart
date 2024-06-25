// user_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/user_model.dart';

class UserService {
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  // Add a new user
  Future<void> addUser(Users user) {
    return userCollection.doc(user.id).set(user.toMap());
  }

  // Get a user by ID
  Future<Users?> getUser(String id) async {
    DocumentSnapshot doc = await userCollection.doc(id).get();
    if (doc.exists) {
      return Users.fromMap(doc.data() as Map<String, dynamic>);
    } else {
      return null;
    }
  }

  // Update a user
  Future<void> updateUser(Users user) {
    return userCollection.doc(user.id).update(user.toMap());
  }

  // Delete a user
  Future<void> deleteUser(String id) {
    return userCollection.doc(id).delete();
  }

  // Get all users
  Stream<List<Users>> getUsers() {
    return userCollection.snapshots().map((query) {
      return query.docs.map((doc) {
        return Users.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }
}
