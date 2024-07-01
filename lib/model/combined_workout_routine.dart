// import 'package:fit_raho/model/day_rotine.dart';

// class CombinedWorkout {
//   String docId; // WorkoutRoutine docId
//   String createrId; // creater id who created the routine,
//   String workoutId; // Workout document id
//   String workoutName;
//   String workoutCategory; // Yoga, body building
//   String whatToDo;
//   String dayOfWeek;
//   List<DayRoutine> dayRoutines;

//   CombinedWorkout({
//     required this.docId,
//     required this.createrId,
//     required this.workoutId,
//     required this.workoutCategory,
//     required this.whatToDo,
//     required this.dayOfWeek,
//     required this.dayRoutines,
//     required this.workoutName,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'docId': docId,
//       'createrId': createrId,
//       'workoutId': workoutId,
//       'workoutCategory': workoutCategory,
//       'whatToDo': whatToDo,
//       'dayOfWeek': dayOfWeek,
//       'dayRoutines': dayRoutines.map((e) => e.toMap()).toList(),
//       'workoutName': workoutName,
//     };
//   }

//   factory CombinedWorkout.fromMap(Map<String, dynamic> map) {
//     return CombinedWorkout(
//       docId: map['docId'] ?? '',
//       createrId: map['createrId'] ?? '',
//       workoutId: map['workoutId'] ?? '',
//       workoutCategory: map['workoutCategory'] ?? '',
//       whatToDo: map['whatToDo'] ?? '',
//       dayOfWeek: map['dayOfWeek'] ?? '',
//       dayRoutines: (map['dayRoutines'] as List<dynamic>?)
//               ?.map((e) => DayRoutine.fromMap(e))
//               .toList() ??
//           [],
//       workoutName: map['workoutName'] ?? '',
//     );
//   }
// }

import 'package:fit_raho/model/day_rotine.dart';
import 'package:fit_raho/model/wokout_rotine.dart';
import 'package:fit_raho/model/workout.dart';

class CombinedWorkout {
  Workout workout;
  List<WorkoutRoutine> workoutRoutines;
  List<DayRoutine> dayRoutines;

  CombinedWorkout({
    required this.workout,
    required this.workoutRoutines,
    required this.dayRoutines,
  });

  Map<String, dynamic> toMap() {
    return {
      'workout': workout.toMap(),
      'workoutRoutines': workoutRoutines.map((e) => e.toMap()).toList(),
      'dayRoutines': dayRoutines.map((e) => e.toMap()).toList(),
    };
  }

  factory CombinedWorkout.fromMap(Map<String, dynamic> map) {
    return CombinedWorkout(
      workout: Workout.fromMap(map['workout']),
      workoutRoutines: (map['workoutRoutines'] as List<dynamic>)
          .map((e) => WorkoutRoutine.fromMap(e))
          .toList(),
      dayRoutines: (map['dayRoutines'] as List<dynamic>)
          .map((e) => DayRoutine.fromMap(e))
          .toList(),
    );
  }
}
