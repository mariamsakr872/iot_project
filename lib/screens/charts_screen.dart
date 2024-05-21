import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../network/readings.dart';

class ChartsScreen extends StatefulWidget {
  const ChartsScreen({super.key});

  @override
  State<ChartsScreen> createState() => _ChartsScreenState();
}

class _ChartsScreenState extends State<ChartsScreen> {
  final Readings data = Readings();
  final DatabaseReference dbRef =
  FirebaseDatabase.instance.ref().child("HealthCare");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Map<String, dynamic>>(
        future: data.fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(
              child: Text("No Readings Available"),
            );
          } else {
            Map<dynamic, dynamic> healthCareData = snapshot.data!;
            List<double> temps = _generateTempList(healthCareData);
            double average = 0;
            double sum = 0;
            for (int i = 0; i <temps.length;i++){
              sum = sum + temps[i];
            }
            average = sum / temps.length;
            double roundedAvg = double.parse((average).toStringAsFixed(2));
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                child: Column(
                  children: [
                    SizedBox(height: 50,),
                    Container(
                      width: double.infinity,
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            offset: Offset.zero,
                            blurRadius: 10.0,
                            spreadRadius: 0.0,
                          )
                        ],
                        gradient: const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          stops: [0.5, 1.0], // Adjust the stops for more dynamic gradient
                          colors: [
                            Color(0xFFffffff), // Adjust the color as needed
                            Color(0xFFEEE296), // Adjust the color as needed
                          ],
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child:  Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              "Average of temperature today :\n $roundedAvg",
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                fontSize: 17,
                                // color: Colors.white, // Text color
                              ),
                            ),
                            Image.asset("assets/images/sun.png",alignment: Alignment.centerRight,width: 100,)
                          ],
                        ),
                      ),
                    ),
                   SizedBox(height: 20,),
                   Row(
                     children: [
                       Expanded(
                         child: Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Container(
                             height: 150,
                             decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(8),
                               color: Colors.white,
                               boxShadow: const [
                                 BoxShadow(
                                   color: Colors.black12,
                                   offset: Offset.zero,
                                   blurRadius: 10.0,
                                   spreadRadius: 0.0,
                                 )
                               ],
                             ),
                             child: Padding(
                               padding: const EdgeInsets.all(12.0),
                               child:  Text(
                                 "Temperature:\n ${getLastValue(_generateTempList(healthCareData))}",
                                 textAlign: TextAlign.start,
                                 style: const TextStyle(
                                   fontSize: 17,
                                   // color: Colors.white, // Text color
                                 ),
                               ),
                             ),
                           ),
                         ),
                       ),
                       Expanded(
                         child: Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Container(
                             height: 150,
                             decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(8),
                               color: Colors.white,
                               boxShadow: const [
                                 BoxShadow(
                                   color: Colors.black12,
                                   offset: Offset.zero,
                                   blurRadius: 10.0,
                                   spreadRadius: 0.0,
                                 )
                               ],
                             ),
                             child: Padding(
                               padding: const EdgeInsets.all(12.0),
                               child:  Text(
                                 "Humidity:\n ${getLastValue(_generateHumidityList(healthCareData))}",
                                 textAlign: TextAlign.start,
                                 style: const TextStyle(
                                   fontSize: 17,
                                   // color: Colors.white, // Text color
                                 ),
                               ),
                             ),
                           ),
                         ),
                       ),
                     ],
                   ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    offset: Offset.zero,
                                    blurRadius: 10.0,
                                    spreadRadius: 0.0,
                                  )
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child:  Text(
                                  "Heart Rate:\n${getLastValue(_generateRateList(healthCareData))}",
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                    fontSize: 17,
                                    // color: Colors.white, // Text color
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    offset: Offset.zero,
                                    blurRadius: 10.0,
                                    spreadRadius: 0.0,
                                  )
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child:  Text(
                                  "Oxygen:\n${getLastValue(_generateSpo2List(healthCareData))}",
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                    fontSize: 17,
                                    // color: Colors.white, // Text color
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }


  List<double> _generateTempList(Map<dynamic, dynamic> healthCareData) {
    List<double> spots = [];
    healthCareData.forEach((key, value) {
      if (value is Map<dynamic, dynamic>) {
        double y = double.tryParse(value['temperature'].toString()) ?? 0;
        spots.add(y);
      }
    });
    return spots;
  }

  List<double> _generateHumidityList(Map<dynamic, dynamic> healthCareData) {
    List<double> spots = [];
    healthCareData.forEach((key, value) {
      if (value is Map<dynamic, dynamic>) {
        double y = double.tryParse(value['humidity'].toString()) ?? 0;
        spots.add(y);
      }
    });
    return spots;
  }

  List<double> _generateRateList(Map<dynamic, dynamic> healthCareData) {
    List<double> spots = [];
    healthCareData.forEach((key, value) {
      if (value is Map<dynamic, dynamic>) {
        double y = double.tryParse(value['heart_rate'].toString()) ?? 0;
        spots.add(y);
      }
    });
    return spots;
  }

  List<double> _generateSpo2List(Map<dynamic, dynamic> healthCareData) {
    List<double> spots = [];
    healthCareData.forEach((key, value) {
      if (value is Map<dynamic, dynamic>) {
        double y = double.tryParse(value['spo2'].toString()) ?? 0;
        spots.add(y);
      }
    });
    return spots;
  }
  double getLastValue(List<double> list) {
    if (list.isEmpty) {
      return 0.0; // Return a default value if the list is empty
    } else {
      return list.last; // Return the last value in the list
    }
  }

  double _parseTime(dynamic time) {
    if (time is String) {
      List<String> parts = time.split(':');
      if (parts.length == 3) {
        // Hours, Minutes, Seconds
        // double hours = double.tryParse(parts[0]) ?? 0.0;
        // double minutes = double.tryParse(parts[1]) ?? 0.0;
        double seconds = double.tryParse(parts[2]) ?? 0.0;
        return seconds;
      }
    }
    return 0.0;
  }
}