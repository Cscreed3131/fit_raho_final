import 'package:cloud_firestore/cloud_firestore.dart';

class Gym {
  String id;
  String name;
  String address;
  String ownerId;
  Timestamp createdAt;
  List<String> trainers;
  List<String> clients;
  List<String> subscriptionPlans;
  List<String> classSchedule;
  Map<String, String> openingHours;
  List<String> facilities;

  Gym({
    required this.id,
    required this.name,
    required this.address,
    required this.ownerId,
    required this.createdAt,
    required this.trainers,
    required this.clients,
    required this.subscriptionPlans,
    required this.classSchedule,
    required this.openingHours,
    required this.facilities,
  });

  // Convert Gym object to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'ownerId': ownerId,
      'createdAt': createdAt,
      'trainers': trainers,
      'clients': clients,
      'subscriptionPlans': subscriptionPlans,
      'classSchedule': classSchedule,
      'openingHours': openingHours,
      'facilities': facilities,
    };
  }

  // Create Gym object from a Map
  factory Gym.fromMap(Map<String, dynamic> map) {
    return Gym(
      id: map['id'] as String,
      name: map['name'] as String,
      address: map['address'] as String,
      ownerId: map['ownerId'] as String,
      createdAt: map['createdAt'] as Timestamp,
      trainers: List<String>.from(map['trainers']),
      clients: List<String>.from(map['clients']),
      subscriptionPlans: List<String>.from(map['subscriptionPlans']),
      classSchedule: List<String>.from(map['classSchedule']),
      openingHours: Map<String, String>.from(map['openingHours']),
      facilities: List<String>.from(map['facilities']),
    );
  }
}
