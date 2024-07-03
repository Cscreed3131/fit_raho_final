import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AssignWorkoutRoutineScreen extends ConsumerStatefulWidget {
  const AssignWorkoutRoutineScreen({super.key});
  static const routeName = 'assign-workout-routine';

  @override
  ConsumerState<AssignWorkoutRoutineScreen> createState() =>
      _AssignWorkoutRoutineScreenState();
}

class _AssignWorkoutRoutineScreenState
    extends ConsumerState<AssignWorkoutRoutineScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: const Text('Assign Workout Routine'),
      ),
    );
  }
}
