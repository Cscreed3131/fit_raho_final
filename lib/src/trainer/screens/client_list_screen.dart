import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_raho/src/trainer/provider/assigned_clients_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClientListScreen extends ConsumerStatefulWidget {
  const ClientListScreen({super.key});
  static const routeName = 'client-list';

  @override
  ConsumerState<ClientListScreen> createState() => _ClientListScreenState();
}

class _ClientListScreenState extends ConsumerState<ClientListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: const Text('Client List'),
      ),
      body: ref
          .watch(
              assignedClientsProvider(FirebaseAuth.instance.currentUser!.uid))
          .when(
        data: (data) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height * 0.2,
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: data.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final client = data[index];
                      return InkWell(
                        onTap: () {
                          // Navigate to client details screen
                          // Navigator.of(context).pushNamed(
                          //   ClientDetailsScreen.routeName,
                          //   arguments: client,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 150,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          client.profilePictureUrl),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 150,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        client.userName,
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                      // Additional client details can be displayed here
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
      ),
    );
  }
}
