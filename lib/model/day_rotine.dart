class DayRoutine {
  String id;
  String whatToDo;
  num repetition;
  String specialMessage;
  String imageUrl;

  DayRoutine({
    required this.id,
    required this.whatToDo,
    required this.repetition,
    required this.specialMessage,
    required this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'whatToDo': whatToDo,
      'repetition': repetition,
      'specialMessage': specialMessage,
      'imageUrl': imageUrl,
    };
  }

  factory DayRoutine.fromMap(Map<String, dynamic> map) {
    return DayRoutine(
      id: map['id'] ?? '',
      whatToDo: map['whatToDo'] ?? '',
      repetition: map['repetition'] ?? 0,
      specialMessage: map['specialMessage'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
    );
  }
}
