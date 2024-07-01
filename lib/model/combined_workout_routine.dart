import 'package:fit_raho/model/day_rotine.dart';

class CombinedWorkout {
  String docId; // WorkoutRoutine docId
  String ownerId;
  String workoutId; // Workout document id
  String workoutCategory; // Yoga, body building
  String whatToDo;
  String dayOfWeek;
  List<DayRoutine> dayRoutines;
  String workoutName;

  CombinedWorkout({
    required this.docId,
    required this.ownerId,
    required this.workoutId,
    required this.workoutCategory,
    required this.whatToDo,
    required this.dayOfWeek,
    required this.dayRoutines,
    required this.workoutName,
  });

  Map<String, dynamic> toMap() {
    return {
      'docId': docId,
      'ownerId': ownerId,
      'workoutId': workoutId,
      'workoutCategory': workoutCategory,
      'whatToDo': whatToDo,
      'dayOfWeek': dayOfWeek,
      'dayRoutines': dayRoutines.map((e) => e.toMap()).toList(),
      'workoutName': workoutName,
    };
  }

  factory CombinedWorkout.fromMap(Map<String, dynamic> map) {
    return CombinedWorkout(
      docId: map['docId'] ?? '',
      ownerId: map['ownerId'] ?? '',
      workoutId: map['workoutId'] ?? '',
      workoutCategory: map['workoutCategory'] ?? '',
      whatToDo: map['whatToDo'] ?? '',
      dayOfWeek: map['dayOfWeek'] ?? '',
      dayRoutines: (map['dayRoutines'] as List<dynamic>?)
              ?.map((e) => DayRoutine.fromMap(e))
              .toList() ??
          [],
      workoutName: map['workoutName'] ?? '',
    );
  }
}
