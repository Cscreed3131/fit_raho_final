// gym_class.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class GymClass {
  String id;
  String name;
  String description;
  String instructorId;
  String gymId;
  List<String> participants;
  Timestamp scheduledTime;
  int maxParticipants;
  int duration; // duration in minutes
  String difficultyLevel;
  String location;

  GymClass({
    required this.id,
    required this.name,
    required this.description,
    required this.instructorId,
    required this.gymId,
    required this.participants,
    required this.scheduledTime,
    required this.maxParticipants,
    required this.duration,
    required this.difficultyLevel,
    required this.location,
  });

  // Convert GymClass object to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'instructorId': instructorId,
      'gymId': gymId,
      'participants': participants,
      'scheduledTime': scheduledTime,
      'maxParticipants': maxParticipants,
      'duration': duration,
      'difficultyLevel': difficultyLevel,
      'location': location,
    };
  }

  // Create GymClass object from a Map
  factory GymClass.fromMap(Map<String, dynamic> map) {
    return GymClass(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      instructorId: map['instructorId'] as String,
      gymId: map['gymId'] as String,
      participants: List<String>.from(map['participants']),
      scheduledTime: map['scheduledTime'] as Timestamp,
      maxParticipants: map['maxParticipants'] as int,
      duration: map['duration'] as int,
      difficultyLevel: map['difficultyLevel'] as String,
      location: map['location'] as String,
    );
  }
}
