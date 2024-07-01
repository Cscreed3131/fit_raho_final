// class Workout {
//   String ownerId;
//   String docId;
//   String workoutCategory;
//   String workoutName;

//   Workout({
//     required this.ownerId,
//     required this.docId,
//     required this.workoutCategory,
//     required this.workoutName,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'docId': docId,
//       'ownerId': ownerId,
//       'workoutCategory': workoutCategory,
//       'workoutName': workoutName,
//     };
//   }

//   factory Workout.fromMap(Map<String, dynamic> map) {
//     return Workout(
//       docId: map['docId'] ?? '',
//       ownerId: map['ownerId'] ?? '',
//       workoutCategory: map['workoutCategory'] ?? '',
//       workoutName: map['workoutName'] ?? '',
//     );
//   }

//   factory Workout.getDefaultWorkout() {
//     return Workout(
//       docId: '',
//       ownerId: '',
//       workoutCategory: '',
//       workoutName: '',
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';

class Workout {
  String id;
  String ownerId;
  String name;
  String category;
  DateTime createdAt;

  Workout({
    required this.id,
    required this.ownerId,
    required this.name,
    required this.category,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ownerId': ownerId,
      'name': name,
      'category': category,
      'createdAt': createdAt,
    };
  }

  factory Workout.fromMap(Map<String, dynamic> map) {
    return Workout(
      id: map['id'] ?? '',
      ownerId: map['ownerId'] ?? '',
      name: map['name'] ?? '',
      category: map['category'] ?? '',
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }
}
