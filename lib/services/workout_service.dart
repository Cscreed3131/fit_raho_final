// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:fit_raho/model/combined_workout_routine.dart';

// class WorkoutService {
//   final CollectionReference collection =
//       FirebaseFirestore.instance.collection('workoutRoutines');

//   // Create a new CombinedWorkout
//   Future<void> createCombinedWorkout(CombinedWorkout workout) async {
//     DocumentReference docRef = collection.doc();
//     workout.docId = docRef.id;
//     await docRef.set(workout.toMap());
//   }

//   // Read a CombinedWorkout by docId
//   Future<CombinedWorkout?> getCombinedWorkout(String docId) async {
//     DocumentSnapshot doc = await collection.doc(docId).get();
//     if (doc.exists) {
//       return CombinedWorkout.fromMap(doc.data() as Map<String, dynamic>);
//     } else {
//       return null;
//     }
//   }

//   // Read all CombinedWorkouts
//   Future<List<CombinedWorkout>> getAllCombinedWorkouts() async {
//     QuerySnapshot querySnapshot = await collection.get();
//     return querySnapshot.docs.map((doc) {
//       return CombinedWorkout.fromMap(doc.data() as Map<String, dynamic>);
//     }).toList();
//   }

//   // Update a CombinedWorkout by docId
//   Future<void> updateCombinedWorkout(CombinedWorkout workout) async {
//     await collection.doc(workout.docId).update(workout.toMap());
//   }

//   // Delete a CombinedWorkout by docId
//   Future<void> deleteCombinedWorkout(String docId) async {
//     await collection.doc(docId).delete();
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_raho/model/combined_workout_routine.dart';
import 'package:fit_raho/model/day_rotine.dart';
import 'package:fit_raho/model/wokout_rotine.dart';
import 'package:fit_raho/model/workout.dart';

class WorkoutService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createWorkout(Workout workout) async {
    DocumentReference workoutRef = _firestore.collection('workouts').doc();
    await workoutRef.set(workout.toMap());
  }

  Future<void> createWorkoutRoutine(WorkoutRoutine routine) async {
    DocumentReference routineRef =
        _firestore.collection('workout_routines').doc();
    await routineRef.set(routine.toMap());
  }

  Future<void> createDayRoutine(DayRoutine dayRoutine) async {
    DocumentReference dayRoutineRef =
        _firestore.collection('day_routines').doc();
    await dayRoutineRef.set(dayRoutine.toMap());
  }

  Future<CombinedWorkout?> getCombinedWorkout(String workoutId) async {
    DocumentSnapshot workoutDoc =
        await _firestore.collection('workouts').doc(workoutId).get();
    if (!workoutDoc.exists) return null;

    Workout workout =
        Workout.fromMap(workoutDoc.data() as Map<String, dynamic>);

    QuerySnapshot workoutRoutineSnapshot = await _firestore
        .collection('workout_routines')
        .where('workoutId', isEqualTo: workoutId)
        .get();

    List<WorkoutRoutine> workoutRoutines = workoutRoutineSnapshot.docs
        .map(
            (doc) => WorkoutRoutine.fromMap(doc.data() as Map<String, dynamic>))
        .toList();

    List<DayRoutine> dayRoutines = [];
    for (var routine in workoutRoutines) {
      QuerySnapshot dayRoutineSnapshot = await _firestore
          .collection('day_routines')
          .where('workoutRoutineId', isEqualTo: routine.id)
          .get();
      dayRoutines.addAll(dayRoutineSnapshot.docs
          .map((doc) => DayRoutine.fromMap(doc.data() as Map<String, dynamic>))
          .toList());
    }

    return CombinedWorkout(
      workout: workout,
      workoutRoutines: workoutRoutines,
      dayRoutines: dayRoutines,
    );
  }
}
