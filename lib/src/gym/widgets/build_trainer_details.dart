import 'package:fit_raho/model/trainer_model.dart';
import 'package:flutter/material.dart';

class BuildTrainerDetails extends StatelessWidget {
  final Trainer? trainerData;
  const BuildTrainerDetails({required this.trainerData, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 3,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Name: ${trainerData!.userName}',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 10),
              Text(
                'Specialization: ${trainerData!.specialization}',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ],
    );
  }
}
