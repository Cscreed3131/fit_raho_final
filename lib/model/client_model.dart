// client.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class Client {
  String id; // doc id
  String userName; // user id
  String gymId; // client assigned with gym id
  String subscriptionPlanId;
  String profilePictureUrl;
  String? assignedTrainerId;
  String contactNumber;
  Timestamp subscriptionStartDate;
  Timestamp subscriptionEndDate;
  List<String> enrolledClasses;
  List<Map<String, dynamic>> progressRecords;
  List<Map<String, dynamic>> attendanceRecords;

  Client({
    required this.id,
    required this.userName,
    required this.gymId,
    required this.subscriptionPlanId,
    required this.profilePictureUrl,
    this.assignedTrainerId,
    required this.contactNumber,
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
      'userName': userName,
      'gymId': gymId,
      'subscriptionPlanId': subscriptionPlanId,
      'contactNumber': contactNumber,
      'assignedTrainerId': assignedTrainerId,
      'subscriptionStartDate': subscriptionStartDate,
      'profilePictureUrl': profilePictureUrl,
      'subscriptionEndDate': subscriptionEndDate,
      'enrolledClasses': enrolledClasses,
      'progressRecords': progressRecords,
      'attendanceRecords': attendanceRecords,
    };
  }

  // Create Client object from a Map
  factory Client.fromMap(Map<String, dynamic> map) {
    return Client(
      id: map['id'] ?? '',
      userName: map['userName'] ?? '',
      gymId: map['gymId'] ?? '',
      contactNumber: map['contactNumber'] ?? '',
      subscriptionPlanId: map['subscriptionPlanId'] ?? '',
      assignedTrainerId: map['assignedTrainerId'] ?? '',
      subscriptionStartDate: map['subscriptionStartDate'] as Timestamp,
      subscriptionEndDate: map['subscriptionEndDate'] as Timestamp,
      enrolledClasses: List<String>.from(map['enrolledClasses']),
      progressRecords: List<Map<String, dynamic>>.from(map['progressRecords']),
      attendanceRecords:
          List<Map<String, dynamic>>.from(map['attendanceRecords']),
      profilePictureUrl: map['profilePictureUrl'] ?? '',
    );
  }
}
