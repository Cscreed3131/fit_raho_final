// class DayRoutine {
//   String id;
//   String whatToDo;
//   num repetition;
//   String tips;
//   String imageUrl;

//   DayRoutine({
//     required this.id,
//     required this.whatToDo,
//     required this.repetition,
//     required this.tips,
//     required this.imageUrl,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'whatToDo': whatToDo,
//       'repetition': repetition,
//       'tips': tips,
//       'imageUrl': imageUrl,
//     };
//   }

//   factory DayRoutine.fromMap(Map<String, dynamic> map) {
//     return DayRoutine(
//       id: map['id'] ?? '',
//       whatToDo: map['whatToDo'] ?? '',
//       repetition: map['repetition'] ?? 0,
//       tips: map['tips'] ?? '',
//       imageUrl: map['imageUrl'] ?? '',
//     );
//   }
// }

class DayRoutine {
  String id;
  String workoutRoutineId;
  String whatToDo;
  String repetition;
  String tips;
  String imageUrl;

  DayRoutine({
    required this.id,
    required this.workoutRoutineId,
    required this.whatToDo,
    required this.repetition,
    required this.tips,
    required this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'workoutRoutineId': workoutRoutineId,
      'whatToDo': whatToDo,
      'repetition': repetition,
      'tips': tips,
      'imageUrl': imageUrl,
    };
  }

  factory DayRoutine.fromMap(Map<String, dynamic> map) {
    return DayRoutine(
      id: map['id'] ?? '',
      workoutRoutineId: map['workoutRoutineId'] ?? '',
      whatToDo: map['whatToDo'] ?? '',
      repetition: map['repetition'] ?? 0,
      tips: map['tips'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
    );
  }
}
