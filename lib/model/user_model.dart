import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  String id;
  String name;
  String email;
  String passwordHash;
  String gender;
  String role; // client , trainer , gym_owner, admin
  //admin can create gyms and do lot more on behalf of gyms.
  Timestamp createdAt;
  String profilePictureUrl;
  String? trainerId; // leave this blank for now
  String contactNumber;
  String address; // optional field
  String dateOfBirth;
  Map<String, dynamic> emergencyContact; // dont need field for this
  String
      membershipStatus; // Active, Inactive, Pending, Expired, Suspended ,Cancelled

  Users({
    required this.id,
    required this.name,
    required this.email,
    required this.passwordHash,
    required this.gender,
    required this.role,
    required this.createdAt,
    required this.profilePictureUrl,
    this.trainerId,
    required this.contactNumber,
    required this.address,
    required this.dateOfBirth,
    required this.emergencyContact,
    required this.membershipStatus,
  });

  // Convert User object to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'passwordHash': passwordHash,
      'gender': gender,
      'role': role,
      'createdAt': createdAt,
      'profilePictureUrl': profilePictureUrl,
      'trainerId': trainerId,
      'contactNumber': contactNumber,
      'address': address,
      'dateOfBirth': dateOfBirth,
      'emergencyContact': emergencyContact,
      'membershipStatus': membershipStatus,
    };
  }

  // Create User object from a Map
  factory Users.fromMap(Map<String, dynamic> map) {
    return Users(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      passwordHash: map['passwordHash'] as String,
      gender: map['gender'] as String,
      role: map['role'] as String,
      createdAt: map['createdAt'] as Timestamp,
      profilePictureUrl: map['profilePictureUrl'] as String,
      trainerId: map['trainerId'] as String?,
      contactNumber: map['contactNumber'] as String,
      address: map['address'] as String,
      dateOfBirth: map['dateOfBirth'] as String,
      emergencyContact: map['emergencyContact'] as Map<String, dynamic>,
      membershipStatus: map['membershipStatus'] as String,
    );
  }
  // Add this method inside the User class

  static Users empty() {
    return Users(
      id: '',
      name: '',
      email: '',
      passwordHash: '',
      role: '',
      createdAt: Timestamp.now(), // Assuming you want the current time
      profilePictureUrl: '',
      trainerId: null,
      contactNumber: '',
      address: '',
      dateOfBirth: '',
      emergencyContact: {},
      membershipStatus: '',
      gender: '',
    );
  }
}
