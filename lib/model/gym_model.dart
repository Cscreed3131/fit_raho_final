import 'package:cloud_firestore/cloud_firestore.dart';

class Gym {
  String id;
  String name;
  String email;
  String contactNumber;
  String address;
  String ownerId;
  Timestamp createdAt;
  List<String> trainers; // leave this null when creating a new gym
  List<String> clients; // leave this null when creating a new gym
  List<String> subscriptionPlans; // leave this null when creating a new gym
  List<String> classSchedule; // leave this null when creating a new gym
  Map<String, String> openingHours; // leave this null when creating a new gym
  List<String> facilities; // leave this null when creating a new gym

  Gym({
    required this.id,
    required this.name,
    required this.email,
    required this.contactNumber,
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
      'email': email,
      'contactNumber': contactNumber,
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
      email: map['email'] as String,
      contactNumber: map['contactNumber'] as String,
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
