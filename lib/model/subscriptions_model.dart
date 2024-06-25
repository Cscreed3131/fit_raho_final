// subscription.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class Subscription {
  String id;
  String userId;
  String subscriptionPlanId;
  Timestamp startDate;
  Timestamp endDate;
  String paymentStatus; // 'Paid', 'Pending', 'Failed'
  bool renewal;

  Subscription({
    required this.id,
    required this.userId,
    required this.subscriptionPlanId,
    required this.startDate,
    required this.endDate,
    required this.paymentStatus,
    required this.renewal,
  });

  // Convert Subscription object to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'subscriptionPlanId': subscriptionPlanId,
      'startDate': startDate,
      'endDate': endDate,
      'paymentStatus': paymentStatus,
      'renewal': renewal,
    };
  }

  // Create Subscription object from a Map
  factory Subscription.fromMap(Map<String, dynamic> map) {
    return Subscription(
      id: map['id'] as String,
      userId: map['userId'] as String,
      subscriptionPlanId: map['subscriptionPlanId'] as String,
      startDate: map['startDate'] as Timestamp,
      endDate: map['endDate'] as Timestamp,
      paymentStatus: map['paymentStatus'] as String,
      renewal: map['renewal'] as bool,
    );
  }
}

// Model Definition:

// The Subscription class defines the structure of the subscription data, including fields
// such as id, userId, subscriptionPlanId, startDate, endDate, paymentStatus, and renewal.
// The toMap method converts the Subscription object to a map, suitable for storing in Firestore.
// The fromMap factory constructor creates a Subscription object from a map, retrieved from Firestore.
