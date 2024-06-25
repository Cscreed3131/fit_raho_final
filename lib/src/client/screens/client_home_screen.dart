import 'package:fit_raho/constant/color_constant.dart';
import 'package:fit_raho/page/dailyroutin.dart';
import 'package:flutter/material.dart';

class ClientHomeScreen extends StatefulWidget {
  const ClientHomeScreen({super.key});

  @override
  State<ClientHomeScreen> createState() => _ClientHomeScreenState();
}

class _ClientHomeScreenState extends State<ClientHomeScreen> {
  List<String> workoutType = [
    "10 PullUPS",
    "10 PushUPS",
    "3 x 15 (5 kg dumbels)",
    "2 x 15 Squarts"
  ];

  List<String> imagePath = [
    "assets/images/equipment.png",
    "assets/images/push-up.png",
    "assets/images/sport.png",
    "assets/images/equipment.png"
  ];
  bool isDone = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Constatnts.textColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "WELCOME",
                  style: TextStyle(
                    color: Constatnts.blackColor,
                    fontSize: 14,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.005,
                ),
                // Text(
                //   Provider.of<UserProvider>(context, listen: false)
                //       .loginuser!
                //       .userName,
                //   style: const TextStyle(
                //     color: Constatnts.redColor,
                //     fontWeight: FontWeight.bold,
                //     fontSize: 16,
                //   ),
                // )
              ],
            ),
            const Column(
              children: [
                Text(
                  "Monday",
                  style: TextStyle(
                      color: Constatnts.blackColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 22),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "10-01-2023",
                  style: TextStyle(
                      color: Constatnts.blackColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Work on this for better',
                      style: TextStyle(
                        color: Constatnts.blackColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      'Tomorrow',
                      style: TextStyle(
                        color: Constatnts.blackColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height * 0.2),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemCount: workoutType.length,
                itemBuilder: ((context, index) {
                  return Container(
                    width: 365,
                    height: 100,
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.only(top: 10, bottom: 5, left: 20),
                    decoration: BoxDecoration(
                      color: Constatnts.mtextFieldColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(imagePath[index], width: 90),
                        Text(
                          workoutType[index],
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400),
                        ),
                        const ImageIcon(
                          AssetImage('assets/images/workout.png'),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return const Dailyroutin();
                    },
                  ),
                );
              },
              child: const Text('view all workout', textAlign: TextAlign.end),
            ),
          ],
        ),
      ),
    );
  }
}
