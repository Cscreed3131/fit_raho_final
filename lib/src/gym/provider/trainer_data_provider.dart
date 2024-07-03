import 'package:fit_raho/model/trainer_model.dart';
import 'package:fit_raho/services/trainer_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final trainerDataProvider =
    FutureProvider.family<Trainer?, String>((ref, contactNumber) async {
  TrainerService trainerService = TrainerService();
  Trainer? trainer =
      await trainerService.getTrainerByContactNumber(contactNumber);
  print(trainer!.id);
  return trainer;
});
