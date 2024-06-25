// subscription_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/subscriptions_model.dart';

class SubscriptionService {
  final CollectionReference subscriptionCollection =
      FirebaseFirestore.instance.collection('subscriptions');

  // Add a new subscription
  Future<void> addSubscription(Subscription subscription) {
    return subscriptionCollection
        .doc(subscription.id)
        .set(subscription.toMap());
  }

  // Get a subscription by ID
  Future<Subscription?> getSubscription(String id) async {
    DocumentSnapshot doc = await subscriptionCollection.doc(id).get();
    if (doc.exists) {
      return Subscription.fromMap(doc.data() as Map<String, dynamic>);
    } else {
      return null;
    }
  }

  // Update a subscription
  Future<void> updateSubscription(Subscription subscription) {
    return subscriptionCollection
        .doc(subscription.id)
        .update(subscription.toMap());
  }

  // Delete a subscription
  Future<void> deleteSubscription(String id) {
    return subscriptionCollection.doc(id).delete();
  }

  // Get all subscriptions
  Stream<List<Subscription>> getSubscriptions() {
    return subscriptionCollection.snapshots().map((query) {
      return query.docs.map((doc) {
        return Subscription.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }
}
