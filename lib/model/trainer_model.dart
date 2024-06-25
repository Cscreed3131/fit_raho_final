// trainer.dart

class Trainer {
  String id;
  String userId;
  String specialization;
  String gymId;
  List<String> clients;
  List<String> certifications;
  int yearsOfExperience;
  Map<String, List<String>> availability;
  List<Map<String, dynamic>> ratings;

  Trainer({
    required this.id,
    required this.userId,
    required this.specialization,
    required this.gymId,
    required this.clients,
    required this.certifications,
    required this.yearsOfExperience,
    required this.availability,
    required this.ratings,
  });

  // Convert Trainer object to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'specialization': specialization,
      'gymId': gymId,
      'clients': clients,
      'certifications': certifications,
      'yearsOfExperience': yearsOfExperience,
      'availability': availability,
      'ratings': ratings,
    };
  }

  // Create Trainer object from a Map
  factory Trainer.fromMap(Map<String, dynamic> map) {
    return Trainer(
      id: map['id'] as String,
      userId: map['userId'] as String,
      specialization: map['specialization'] as String,
      gymId: map['gymId'] as String,
      clients: List<String>.from(map['clients']),
      certifications: List<String>.from(map['certifications']),
      yearsOfExperience: map['yearsOfExperience'] as int,
      availability: Map<String, List<String>>.from(map['availability']),
      ratings: List<Map<String, dynamic>>.from(map['ratings']),
    );
  }
}
