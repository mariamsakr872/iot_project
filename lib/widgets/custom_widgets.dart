import 'package:flutter/material.dart';

class CustomWidgets extends StatelessWidget {
  final Map readings;
  const CustomWidgets({super.key, required this.readings});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: const Color(0xFFECE2E2),
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset.zero,
            blurRadius: 10.0,
            spreadRadius: 0.0,
          )
        ]),
      child:  Column(
        children: [
          Row(
            children: [
              Image.asset("assets/images/temperature (3).png"),
              Text(readings["temperature"]),
            ],
          )
        ],
      ),
    );
  }
}
