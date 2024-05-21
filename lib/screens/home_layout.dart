import 'package:flutter/material.dart';
import 'package:iot_project/screens/charts_screen.dart';
import 'package:iot_project/screens/home_screen.dart';

class HomeLayout extends StatefulWidget {
  static const routeName = "home-layout";
   const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int selectedIndex = 0;

  List<Widget> screens =  [
    const HomeScreen(),
     const ChartsScreen(),


  ];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
       body: screens[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        iconSize: 30,
        selectedIconTheme: const IconThemeData(
          color: Color(0xFFFD7001),
          size: 35
        ),

        selectedItemColor: const Color(0xFFFD7001),
        backgroundColor: Colors.white,
        elevation: 10.0,
        onTap: (int index){
          setState(() {
            selectedIndex = index;
          });
        },
        items: const[
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.all(7.0),
              child: Icon(Icons.home)
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.all(7.0),
              child: Icon(Icons.bar_chart,),
            ),
            label: "Charts",
          ),
        ],

      ),
    );
  }
}
