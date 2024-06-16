import 'package:firebase_database/firebase_database.dart' as db;
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  db.Query dbRef = FirebaseDatabase.instance.ref().child("HealthCare");
  String date = "";
  bool warningShown = false;
  bool warningShown2 = false;     // Track if the warning has been shown

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50,left: 10,),
            child: Text(
              "Readings",
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Color(0xfffb6f01),
                fontSize: 30,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 5),
            child: Text(
              date,
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 17,
              ),
            ),
          ),
          Expanded(
            child: FirebaseAnimatedList(
              query: dbRef,
              itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
                if (snapshot.value != null && snapshot.value is Map) {
                  Map healthCareData = snapshot.value as Map;
                  healthCareData['key'] = snapshot.key;
                  //date = healthCareData['date'].toString();

                  // Get temperature and spo2 values
                  double temperature = double.parse(healthCareData['temperature'].toString());
                  double heart = double.parse(healthCareData['heart_rate'].toString());

                  // Show dialog if temperature or spo2 exceeds threshold and warning hasn't been shown
                  if ((temperature > 20) && !warningShown) {
                    warningShown = true; // Set flag to true to indicate warning has been shown
                    WidgetsBinding.instance!.addPostFrameCallback((_) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            iconColor: Colors.red,
                            title: const Row(
                              children: [
                                Icon(Icons.warning,color: Colors.red,size: 60,),
                                SizedBox(width: 15,),
                                Text("Warning",style: TextStyle(fontWeight: FontWeight.w500),),
                              ],
                            ),
                            content: const Text("Temperature is too high!\nYou Should See Doctor Now ",
                              style: TextStyle(color: Colors.black,fontSize: 15),),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text("OK",style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black
                                ),),
                              ),
                            ],
                          );
                        },
                      );
                    });
                  }

                  if ((heart > 90) && !warningShown2) {
                    warningShown2 = true; // Set flag to true to indicate warning has been shown
                    WidgetsBinding.instance!.addPostFrameCallback((_) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Row(
                              children: [
                                Icon(Icons.warning,color: Colors.red,size: 60,),
                                SizedBox(width: 15,),
                                Text("Warning",style: TextStyle(fontWeight: FontWeight.w500)),
                              ],
                            ),
                            content: const Text("Heart Rate is too high!\nYou Should See Doctor Now",
                            style: TextStyle(color: Colors.black,fontSize: 15),),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text("OK",style: TextStyle(
                                 fontSize: 16,
                               color: Colors.black),)
                              ),
                            ],
                          );
                        },
                      );
                    });
                  }

                  // Show the data regardless of warnings
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      decoration:  BoxDecoration(
                        color:   Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            offset: Offset.zero,
                            blurRadius: 10.0,
                            spreadRadius: 0.0,
                          )
                        ],
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                crossAxisAlignment:CrossAxisAlignment.start ,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset("assets/images/temperature (3).png",width: 35,),
                                      const SizedBox(width: 8,),
                                      const Text('Temperature',style: TextStyle(fontSize: 15),),
                                    ],
                                  ),
                                  const SizedBox(height: 15,),
                                  Row(
                                    children: [
                                      Image.asset("assets/images/humidity.png",width: 35,),
                                      const SizedBox(width: 8,),
                                      const Text('Humidity',style: TextStyle(fontSize: 15),),
                                    ],
                                  ),

                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    healthCareData['temperature'].toString(),
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  const SizedBox(height: 30,),
                                  Text(
                                    healthCareData['humidity'].toString(),
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment:CrossAxisAlignment.start ,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset("assets/images/heart.png",width: 35,),
                                        const SizedBox(width: 8,),
                                        Text('Heart Rate',style: TextStyle(fontSize: 15),),
                                      ],
                                    ),
                                    SizedBox(height: 15,),
                                    Row(
                                      children: [
                                        Image.asset("assets/images/oxygen-saturation.png",width: 35,),
                                        const SizedBox(width: 10,),
                                        Text('Oxygen',style: TextStyle(fontSize: 15),),
                                      ],
                                    ),

                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    healthCareData['heart_rate'].toString(),
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  const SizedBox(height: 30,),
                                  Text(
                                    healthCareData['spo2'].toString(),
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(healthCareData['time'].toString(),style: const TextStyle(fontSize: 16,color: Colors.grey,),textAlign: TextAlign.right,),
                          )
                        ],
                      ),
                    ),
                  );
                } else {
                  return const Text ("No Readings Available");
                }
              })),
        ]));
  }
  List<double> _generateTempList(Map<dynamic, dynamic> healthCareData) {
    List<double> tempSpots = [];
    healthCareData.forEach((key, value) {
      if (value is Map<dynamic, dynamic>) {
        double y = double.tryParse(value['temperature'].toString()) ?? 0;
        tempSpots.add(y);
      }
    });
    return tempSpots;
  }

}