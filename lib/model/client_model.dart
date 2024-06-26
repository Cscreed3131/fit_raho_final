// client.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class Client {
  String id; // doc id
  String userId; // user id
  String gymId; // client assigned with gym id
  String subscriptionPlanId;
  Timestamp subscriptionStartDate;
  Timestamp subscriptionEndDate;
  List<String> enrolledClasses;
  List<Map<String, dynamic>> progressRecords;
  List<Map<String, dynamic>> attendanceRecords;

  Client({
    required this.id,
    required this.userId,
    required this.gymId,
    required this.subscriptionPlanId,
    required this.subscriptionStartDate,
    required this.subscriptionEndDate,
    required this.enrolledClasses,
    required this.progressRecords,
    required this.attendanceRecords,
  });

  // Convert Client object to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'gymId': gymId,
      'subscriptionPlanId': subscriptionPlanId,
      'subscriptionStartDate': subscriptionStartDate,
      'subscriptionEndDate': subscriptionEndDate,
      'enrolledClasses': enrolledClasses,
      'progressRecords': progressRecords,
      'attendanceRecords': attendanceRecords,
    };
  }

  // Create Client object from a Map
  factory Client.fromMap(Map<String, dynamic> map) {
    return Client(
      id: map['id'] as String,
      userId: map['userId'] as String,
      gymId: map['gymId'] as String,
      subscriptionPlanId: map['subscriptionPlanId'] as String,
      subscriptionStartDate: map['subscriptionStartDate'] as Timestamp,
      subscriptionEndDate: map['subscriptionEndDate'] as Timestamp,
      enrolledClasses: List<String>.from(map['enrolledClasses']),
      progressRecords: List<Map<String, dynamic>>.from(map['progressRecords']),
      attendanceRecords:
          List<Map<String, dynamic>>.from(map['attendanceRecords']),
    );
  }
}
