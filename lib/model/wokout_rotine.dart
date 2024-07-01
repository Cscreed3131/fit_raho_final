import 'day_rotine.dart';

class WorkoutRoutine {
  String docId;
  String ownerId;
  String workoutId;
  String workoutCategory;
  String whatToDo;
  String dayOfWeek;
  List<DayRoutine> dayRoutines;

  WorkoutRoutine({
    required this.docId,
    required this.ownerId,
    required this.workoutId,
    required this.workoutCategory,
    required this.whatToDo,
    required this.dayOfWeek,
    required this.dayRoutines,
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
    };
  }

  factory WorkoutRoutine.fromMap(Map<String, dynamic> map) {
    return WorkoutRoutine(
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
    );
  }
}
