// subscription_plan.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class SubscriptionPlan {
  String id;
  String name;
  String description;
  double price;
  String duration; // e.g., "1 month", "3 months", "1 year"
  List<String> benefits;
  String gymId;
  Timestamp createdAt;

  SubscriptionPlan({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.duration,
    required this.benefits,
    required this.gymId,
    required this.createdAt,
  });

  // Convert SubscriptionPlan object to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'duration': duration,
      'benefits': benefits,
      'gymId': gymId,
      'createdAt': createdAt,
    };
  }

  // Create SubscriptionPlan object from a Map
  factory SubscriptionPlan.fromMap(Map<String, dynamic> map) {
    return SubscriptionPlan(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      price: map['price'] as double,
      duration: map['duration'] as String,
      benefits: List<String>.from(map['benefits']),
      gymId: map['gymId'] as String,
      createdAt: map['createdAt'] as Timestamp,
    );
  }
}
