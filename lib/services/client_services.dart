// client_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/client_model.dart';

class ClientService {
  final CollectionReference clientCollection =
      FirebaseFirestore.instance.collection('clients');

  // Add a new client
  Future<void> addClient(Client client) {
    return clientCollection.doc(client.id).set(client.toMap());
  }

  // Get a client by ID
  Future<Client?> getClient(String id) async {
    DocumentSnapshot doc = await clientCollection.doc(id).get();
    if (doc.exists) {
      return Client.fromMap(doc.data() as Map<String, dynamic>);
    } else {
      return null;
    }
  }

  Future<Client?> getClientByContactNumber(String contactNumber) async {
    QuerySnapshot querySnapshot = await clientCollection
        .where('contactNumber', isEqualTo: contactNumber)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      return Client.fromMap(
          querySnapshot.docs.first.data() as Map<String, dynamic>);
    } else {
      return null;
    }
  }

  // Update a client
  Future<void> updateClient(Client client) {
    return clientCollection.doc(client.id).update(client.toMap());
  }

  // Delete a client
  Future<void> deleteClient(String id) {
    return clientCollection.doc(id).delete();
  }

  // Get all clients
  Stream<List<Client>> getClientsList() {
    return clientCollection.snapshots().map((query) {
      return query.docs.map((doc) {
        return Client.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }
}
