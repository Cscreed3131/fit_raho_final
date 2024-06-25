// gym_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_raho/model/gym_model.dart';

class GymService {
  final CollectionReference gymCollection =
      FirebaseFirestore.instance.collection('gyms');

  // Add a new gym
  Future<void> addGym(Gym gym) {
    return gymCollection.doc(gym.id).set(gym.toMap());
  }

  // Get a gym by ID
  Future<Gym?> getGym(String id) async {
    DocumentSnapshot doc = await gymCollection.doc(id).get();
    if (doc.exists) {
      return Gym.fromMap(doc.data() as Map<String, dynamic>);
    } else {
      return null;
    }
  }

  // Update a gym
  Future<void> updateGym(Gym gym) {
    return gymCollection.doc(gym.id).update(gym.toMap());
  }

  // Delete a gym
  Future<void> deleteGym(String id) {
    return gymCollection.doc(id).delete();
  }

  // Get all gyms
  Stream<List<Gym>> getGyms() {
    return gymCollection.snapshots().map((query) {
      return query.docs.map((doc) {
        return Gym.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }
}
