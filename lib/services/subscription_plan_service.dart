// subscription_plan_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/subscription_plan_model.dart';

class SubscriptionPlanService {
  final CollectionReference subscriptionPlanCollection =
      FirebaseFirestore.instance.collection('subscriptionPlans');

  // Add a new subscription plan
  Future<void> addSubscriptionPlan(SubscriptionPlan subscriptionPlan) {
    return subscriptionPlanCollection
        .doc(subscriptionPlan.id)
        .set(subscriptionPlan.toMap());
  }

  // Get a subscription plan by ID
  Future<SubscriptionPlan?> getSubscriptionPlan(String id) async {
    DocumentSnapshot doc = await subscriptionPlanCollection.doc(id).get();
    if (doc.exists) {
      return SubscriptionPlan.fromMap(doc.data() as Map<String, dynamic>);
    } else {
      return null;
    }
  }

  // Update a subscription plan
  Future<void> updateSubscriptionPlan(SubscriptionPlan subscriptionPlan) {
    return subscriptionPlanCollection
        .doc(subscriptionPlan.id)
        .update(subscriptionPlan.toMap());
  }

  // Delete a subscription plan
  Future<void> deleteSubscriptionPlan(String id) {
    return subscriptionPlanCollection.doc(id).delete();
  }

  // Get all subscription plans
  Stream<List<SubscriptionPlan>> getSubscriptionPlans() {
    return subscriptionPlanCollection.snapshots().map((query) {
      return query.docs.map((doc) {
        return SubscriptionPlan.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }
}
