import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_raho/model/day_rotine.dart';
import 'package:fit_raho/model/wokout_rotine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fit_raho/model/workout.dart';

class CreateWorkoutScreen extends ConsumerStatefulWidget {
  const CreateWorkoutScreen({super.key});
  static const routeName = '/create-workout';

  @override
  ConsumerState<CreateWorkoutScreen> createState() =>
      _CreateWorkoutScreenState();
}

class _CreateWorkoutScreenState extends ConsumerState<CreateWorkoutScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _workoutNameController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  List<WorkoutRoutine> _workoutRoutines = [];
  List<DayRoutine> _dayRoutines = [];

  void _addWorkoutRoutine() {
    setState(() {
      _workoutRoutines.add(WorkoutRoutine(
        id: '',
        workoutId: '',
        dayOfWeek: '',
        whatToDo: '',
      ));
    });
  }

  void _removeWorkoutRoutine(int index) {
    setState(() {
      _dayRoutines.removeWhere((dayRoutine) =>
          dayRoutine.workoutRoutineId == _workoutRoutines[index].id);
      _workoutRoutines.removeAt(index);
    });
  }

  void _addDayRoutine(String workoutRoutineId) {
    setState(() {
      _dayRoutines.add(DayRoutine(
        id: '',
        workoutRoutineId: workoutRoutineId,
        whatToDo: '',
        repetition: '',
        tips: '',
        imageUrl: '',
      ));
    });
  }

  void _removeDayRoutine(int index) {
    setState(() {
      _dayRoutines.removeAt(index);
    });
  }

  Future<void> _createWorkout() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      final docRef = firestore.collection('workouts').doc();
      final docId = docRef.id;

      Workout newWorkout = Workout(
        id: docId,
        ownerId: FirebaseAuth.instance.currentUser!.uid,
        name: _workoutNameController.text,
        category: _categoryController.text,
        createdAt: DateTime.now(),
      );

      await firestore.collection('workouts').doc(docId).set(newWorkout.toMap());

      for (int i = 0; i < _workoutRoutines.length; i++) {
        WorkoutRoutine routine = _workoutRoutines[i];
        routine.workoutId = newWorkout.id;
        routine.id = firestore.collection('workoutRoutines').doc().id;

        await firestore
            .collection('workoutRoutines')
            .doc(routine.id)
            .set(routine.toMap());

        for (DayRoutine dayRoutine in _dayRoutines) {
          dayRoutine.id = firestore.collection('dayRoutines').doc().id;
          dayRoutine.workoutRoutineId = routine.id;
          await firestore
              .collection('dayRoutines')
              .doc(dayRoutine.id)
              .set(dayRoutine.toMap());
        }
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Workout created successfully!')),
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Workout'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _workoutNameController,
                decoration: const InputDecoration(labelText: 'Workout Name'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter workout name' : null,
              ),
              TextFormField(
                controller: _categoryController,
                decoration: const InputDecoration(labelText: 'Category'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter category' : null,
              ),
              const SizedBox(height: 16),
              const Text('Workout Routines', style: TextStyle(fontSize: 16)),
              const SizedBox(height: 8),
              ..._workoutRoutines.asMap().entries.map((entry) {
                int routineIndex = entry.key;
                WorkoutRoutine routine = entry.value;
                return Column(
                  key: ValueKey(routineIndex),
                  children: [
                    DropdownButtonFormField<String>(
                      borderRadius: BorderRadius.circular(20),
                      value:
                          routine.dayOfWeek.isEmpty ? null : routine.dayOfWeek,
                      decoration: InputDecoration(
                        hintText: 'Day of Week',
                        hintStyle: TextStyle(color: Colors.grey[500]),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        prefixIcon: const Icon(Icons.calendar_today_outlined),
                      ),
                      items: const [
                        DropdownMenuItem<String>(
                          value: 'Monday',
                          child: Text('Monday'),
                        ),
                        DropdownMenuItem<String>(
                          value: 'Tuesday',
                          child: Text('Tuesday'),
                        ),
                        DropdownMenuItem<String>(
                          value: 'Wednesday',
                          child: Text('Wednesday'),
                        ),
                        DropdownMenuItem<String>(
                          value: 'Thursday',
                          child: Text('Thursday'),
                        ),
                        DropdownMenuItem<String>(
                          value: 'Friday',
                          child: Text('Friday'),
                        ),
                        DropdownMenuItem<String>(
                          value: 'Saturday',
                          child: Text('Saturday'),
                        ),
                        DropdownMenuItem<String>(
                          value: 'Sunday',
                          child: Text('Sunday'),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          routine.dayOfWeek = value!;
                        });
                      },
                    ),
                    const SizedBox(height: 8),
                    const Text('Day Routines', style: TextStyle(fontSize: 16)),
                    const SizedBox(height: 8),
                    ..._dayRoutines
                        .where((dayRoutine) =>
                            dayRoutine.workoutRoutineId == routine.id)
                        .toList()
                        .asMap()
                        .entries
                        .map((entry) {
                      int dayRoutineIndex = entry.key;
                      DayRoutine dayRoutine = entry.value;
                      return Column(
                        key: ValueKey(dayRoutineIndex),
                        children: [
                          TextFormField(
                            initialValue: dayRoutine.whatToDo,
                            decoration:
                                const InputDecoration(labelText: 'What to Do'),
                            onSaved: (value) =>
                                dayRoutine.whatToDo = value ?? '',
                            validator: (value) => value!.isEmpty
                                ? 'Please enter what to do'
                                : null,
                          ),
                          TextFormField(
                            initialValue: dayRoutine.repetition.toString(),
                            decoration:
                                const InputDecoration(labelText: 'Repetition'),
                            keyboardType: TextInputType.number,
                            onSaved: (value) => dayRoutine.repetition = value!,
                            validator: (value) => value!.isEmpty
                                ? 'Please enter repetition'
                                : null,
                          ),
                          TextFormField(
                            initialValue: dayRoutine.tips,
                            decoration:
                                const InputDecoration(labelText: 'Tips'),
                            onSaved: (value) => dayRoutine.tips = value ?? '',
                          ),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: () => _removeDayRoutine(dayRoutineIndex),
                            child: const Text('Remove Day Routine'),
                          ),
                          const Divider(),
                        ],
                      );
                    }).toList(),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => _addDayRoutine(routine.id),
                      child: const Text('Add Day Routine'),
                    ),
                    const Divider(),
                  ],
                );
              }).toList(),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _addWorkoutRoutine,
                child: const Text('Add Workout Routine'),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: FilledButton(
          onPressed: _createWorkout,
          child: const Text(
            'Create Workout',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
