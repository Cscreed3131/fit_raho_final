import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_raho/model/trainer_model.dart';
import 'package:fit_raho/services/trainer_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final trainerCollection = FirebaseFirestore.instance.collection('trainers');

final trainersListProvider = StreamProvider<List<Trainer>>((ref) {
  TrainerService trainerService = TrainerService();
  return trainerService.getTrainersList();
});
