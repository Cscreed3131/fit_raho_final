// gym_class_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/gym_class_model.dart';

class GymClassService {
  final CollectionReference classCollection =
      FirebaseFirestore.instance.collection('classes');

  // Add a new class
  Future<void> addClass(GymClass gymClass) {
    return classCollection.doc(gymClass.id).set(gymClass.toMap());
  }

  // Get a class by ID
  Future<GymClass?> getClass(String id) async {
    DocumentSnapshot doc = await classCollection.doc(id).get();
    if (doc.exists) {
      return GymClass.fromMap(doc.data() as Map<String, dynamic>);
    } else {
      return null;
    }
  }

  // Update a class
  Future<void> updateClass(GymClass gymClass) {
    return classCollection.doc(gymClass.id).update(gymClass.toMap());
  }

  // Delete a class
  Future<void> deleteClass(String id) {
    return classCollection.doc(id).delete();
  }

  // Get all classes
  Stream<List<GymClass>> getClasses() {
    return classCollection.snapshots().map((query) {
      return query.docs.map((doc) {
        return GymClass.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }
}
