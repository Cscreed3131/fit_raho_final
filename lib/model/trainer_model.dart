// trainer.dart

class Trainer {
  String id;
  String userName;
  String specialization;
  String profilePictureUrl;
  String contactNumber;
  String gymId; // gym id assigned with trainer
  List<String> clients; // list of client of the trainer
  List<String> certifications; // List of certification of the trainer
  int yearsOfExperience; // years of experience
  Map<String, List<dynamic>> availability; // days when the trainer is available
  List<Map<String, dynamic>> ratings; // list of client rating

  Trainer({
    required this.id,
    required this.userName,
    required this.specialization,
    required this.profilePictureUrl,
    required this.contactNumber,
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
      'userName': userName,
      'specialization': specialization,
      'profileImageUrl': profilePictureUrl,
      'contactNumber': contactNumber,
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
      id: map['id'] ?? '',
      userName: map['userName'] ?? '',
      specialization: map['specialization'] ?? '',
      profilePictureUrl: map['profilePictureUrl'] ?? '',
      contactNumber: map['contactNumber'] ?? '',
      gymId: map['gymId'] ?? '',
      clients: List<String>.from(map['clients']),
      certifications: List<String>.from(map['certifications']),
      yearsOfExperience: map['yearsOfExperience'] as int,
      availability: Map<String, List<dynamic>>.from(map['availability']),
      ratings: List<Map<String, dynamic>>.from(map['ratings']),
    );
  }
}
