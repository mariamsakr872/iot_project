
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';

class ChartsScreen extends StatefulWidget {
  const ChartsScreen({super.key});

  @override
  State<ChartsScreen> createState() => _ChartsScreenState();
}

class _ChartsScreenState extends State<ChartsScreen> {

  @override
  void initState(){
    super.initState();
    readData();
  }

  bool isLoading = true;
  List<double> temp = [];
  List<double> heart = [];
  List<int> timeStamp = [];
  List<double> humidity = [];
  List<double> oxgen = [];
  List<String> data =["azza","hager"];
  Future<void> readData() async {
    var url = "https://nursecare-4613f-default-rtdb.firebaseio.com/"+"HealthCare.json";
    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body) as Map<dynamic, dynamic>;
      if (null == extractedData) {
        return;
      }
      extractedData.forEach((blogId, blogData) {
        temp.add(blogData["temperature"]);
        heart.add(blogData["heart_rate"]);
        timeStamp.add(blogData["timestamp"]);
        humidity.add(blogData["humidity"]);
        oxgen.add(blogData["spo2"]);
      });
      setState(() {
        isLoading = false;
      });
    } catch (error) {
      throw error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
            ? CircularProgressIndicator()
          :SingleChildScrollView(
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50,left: 10),
                  child: Text("Vitalsigns Now",style: TextStyle(fontSize: 18,
                      fontWeight: FontWeight.w500,color: Colors.blueGrey),),
                ),
               SizedBox(height: 10,) ,
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.orangeAccent.withOpacity(1.0),
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
                            padding: const EdgeInsets.all(25.0),
                            child:  Row(
                              children: [
                                Text(
                                  "Temperature:\n ${temp.last.toString()}",
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                    fontSize: 17,
                                     color: Colors.white,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Color(0xff64B3FF),
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
                            padding: const EdgeInsets.all(25.0),
                            child:  Text(
                              "Humidity:\n ${humidity.last.toString()}",
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                fontSize: 17,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold
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
                          height: 100,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Color(0xff64B3FF),
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
                            padding: const EdgeInsets.all(25.0),
                            child:  Text(
                              "Heart Rate:\n ${heart.last.toString()}",
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                  fontSize: 17,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold
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
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.orangeAccent.withOpacity(1.0),
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
                            padding: const EdgeInsets.all(25.0),
                            child:  Text(
                              "Oxygen:\n ${oxgen.last.toString()}",
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                  fontSize: 17,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text("Vitalsigns Chart",style: TextStyle(fontSize: 18,
                      fontWeight: FontWeight.w500,color: Colors.blueGrey),),
                ),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Heart Rate",style: TextStyle(color: Colors.lightBlue,fontWeight: FontWeight.w500),),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10 ),
                        child: Container(
                          color: Colors.white,
                          height: 230,
                          child: LineChart(
                            LineChartData(
                              gridData: FlGridData(
                                show: true,
                                getDrawingHorizontalLine: (value){
                                  return FlLine(
                                   color: Colors.white
                                  );
                                },
                                drawVerticalLine: true,
                                getDrawingVerticalLine: (value){
                                  return FlLine(
                                      color: Colors.white
                                  );
                                },

                              ),
                              borderData: FlBorderData(
                                show: true,
                                border: Border.all(color: Colors.orangeAccent,width: 1)
                              ),
                              titlesData: LineTitles.getTitleData(),
                              lineBarsData: [
                                LineChartBarData(
                                  spots: [
                                    FlSpot(timeStamp[timeStamp.length-1].toDouble(),heart[heart.length-1]),
                                    FlSpot(timeStamp[timeStamp.length-2].toDouble(),heart[heart.length-2]),
                                    FlSpot(timeStamp[timeStamp.length-3].toDouble(),heart[heart.length-3]),
                                    FlSpot(timeStamp[timeStamp.length-4].toDouble(),heart[heart.length-4]),
                                    FlSpot(timeStamp[timeStamp.length-5].toDouble(),heart[heart.length-5]),
                                    FlSpot(timeStamp[timeStamp.length-6].toDouble(),heart[heart.length-6]),
                                    FlSpot(timeStamp[timeStamp.length-7].toDouble(),heart[heart.length-7]),
                                  ],
                                  isCurved: true,
                                  color:Color(0xff64B3FF),
                                  barWidth: 3,
                                  belowBarData: BarAreaData(
                                    show: true,
                                    color: Colors.blue.shade100,
                                  )
                                )
                              ],
                            )
                          ) ,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 300),
                        child: Text("Time",style: TextStyle(color: Colors.lightBlue,fontWeight: FontWeight.w500),),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),


    );
  }
}
class LineTitles {
  static getTitleData()=> FlTitlesData(
    show: true,
    bottomTitles: AxisTitles(sideTitles: SideTitles(
      showTitles: false,
    )),
    topTitles: AxisTitles(sideTitles: SideTitles(
    showTitles: false,),),
    rightTitles: AxisTitles(sideTitles: SideTitles(
      showTitles: false,),),
    leftTitles:AxisTitles(sideTitles: SideTitles(
        showTitles: false,

  )),
  );
}
