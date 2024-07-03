// trainer_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/trainer_model.dart';

class TrainerService {
  final CollectionReference trainerCollection =
      FirebaseFirestore.instance.collection('trainers');

  // Add a new trainer
  Future<void> addTrainer(Trainer trainer) {
    return trainerCollection.doc(trainer.id).set(trainer.toMap());
  }

  // Get a trainer by ID
  Future<Trainer?> getTrainer(String id) async {
    DocumentSnapshot doc = await trainerCollection.doc(id).get();
    if (doc.exists) {
      return Trainer.fromMap(doc.data() as Map<String, dynamic>);
    } else {
      return null;
    }
  }

  // **Get a trainer by contact number**
  Future<Trainer?> getTrainerByContactNumber(String contactNumber) async {
    QuerySnapshot querySnapshot = await trainerCollection
        .where('contactNumber', isEqualTo: contactNumber)
        .get();
    print(querySnapshot);
    if (querySnapshot.docs.isNotEmpty) {
      return Trainer.fromMap(
          querySnapshot.docs.first.data() as Map<String, dynamic>);
    } else {
      return null;
    }
  }

  // Update a trainer
  Future<void> updateTrainer(Trainer trainer) {
    return trainerCollection.doc(trainer.id).update(trainer.toMap());
  }

  // Delete a trainer
  Future<void> deleteTrainer(String id) {
    return trainerCollection.doc(id).delete();
  }

  // Get all trainers
  Stream<List<Trainer>> getTrainersList() {
    return trainerCollection.snapshots().map((query) {
      return query.docs.map((doc) {
        print(doc);
        return Trainer.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }
}
