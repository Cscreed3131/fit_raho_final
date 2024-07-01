class Workout {
  String ownerId;
  String docId;
  String workoutCategory;
  String workoutName;

  Workout({
    required this.ownerId,
    required this.docId,
    required this.workoutCategory,
    required this.workoutName,
  });

  Map<String, dynamic> toMap() {
    return {
      'docId': docId,
      'ownerId': ownerId,
      'workoutCategory': workoutCategory,
      'workoutName': workoutName,
    };
  }

  factory Workout.fromMap(Map<String, dynamic> map) {
    return Workout(
      docId: map['docId'] ?? '',
      ownerId: map['ownerId'] ?? '',
      workoutCategory: map['workoutCategory'] ?? '',
      workoutName: map['workoutName'] ?? '',
    );
  }

  factory Workout.getDefaultWorkout() {
    return Workout(
      docId: '',
      ownerId: '',
      workoutCategory: '',
      workoutName: '',
    );
  }
}
