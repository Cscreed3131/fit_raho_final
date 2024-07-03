import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_raho/model/client_model.dart';
import 'package:fit_raho/model/trainer_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

final assignedClientsProvider =
    FutureProvider.family<List<Client>, String>((ref, id) async {
  Trainer trainer = Trainer.fromMap(
      (await _firestore.collection('trainers').doc(id).get()).data()!);
  List<Client> clients = [];
  for (String clientId in trainer.clients) {
    var doc = await _firestore.collection('clients').doc(clientId).get();
    if (doc.exists) {
      clients.add(Client.fromMap(doc.data()!));
    }
  }
  return clients;
});
