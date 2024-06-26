// trainer.dart

class Trainer {
  String id;
  String userId;
  String specialization;
  String profilePictureUrl;
  String gymId; // gym id assigned with trainer
  List<String> clients; // list of client of the trainer
  List<String> certifications; // List of certification of the trainer
  int yearsOfExperience; // years of experience
  Map<String, List<String>> availability; // days when the trainer is available
  List<Map<String, dynamic>> ratings; // list of client rating

  Trainer({
    required this.id,
    required this.userId,
    required this.specialization,
    required this.profilePictureUrl,
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
      'profileImageUrl': profilePictureUrl,
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
      profilePictureUrl: map['profilePictureUrl'] as String,
      gymId: map['gymId'] as String,
      clients: List<String>.from(map['clients']),
      certifications: List<String>.from(map['certifications']),
      yearsOfExperience: map['yearsOfExperience'] as int,
      availability: Map<String, List<String>>.from(map['availability']),
      ratings: List<Map<String, dynamic>>.from(map['ratings']),
    );
  }
}
