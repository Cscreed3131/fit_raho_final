import 'package:fit_raho/src/gym/provider/trainer_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TrainerListScreen extends ConsumerStatefulWidget {
  const TrainerListScreen({super.key});
  static const routeName = 'trainer-list';
  @override
  ConsumerState<TrainerListScreen> createState() => _TrainerListScreenState();
}

class _TrainerListScreenState extends ConsumerState<TrainerListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          title: const Text('Trainer List'),
        ),
        body: ref.watch(trainersListProvider).when(
          data: (data) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height * 0.2),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: data.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final docData = data[index];
                        return InkWell(
                          onTap: () {
                            // trainer details screen route here
                            // Navigator.of(context).pushNamed(
                            //   TrainerDetailsScreen.routeName,
                            //   arguments: data[index],
                            // );
                          },
                          child: Container(
                            width: double.infinity,
                            height: 150,
                            padding: const EdgeInsets.all(5),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 7),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.red.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 3,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 150,
                                    height: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            docData.profilePictureUrl),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 150,
                                    // width: 200,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          docData.userName,
                                          style: const TextStyle(fontSize: 20),
                                        ),
                                        Text(
                                          docData
                                              .specialization, // this will contain the speciality of the trainer
                                          style: const TextStyle(fontSize: 20),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            );
          },
          error: (error, stackTrace) {
            return const Center(
              child: Text('Encountered Error'),
            );
          },
          loading: () {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          },
        ));
  }
}
