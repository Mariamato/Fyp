import 'dart:ui';

import 'package:flutter/material.dart';

void _ViewSchedule(BuildContext context) {
  // Add view schedule functionality here
}

class ResidentPage extends StatelessWidget {
  const ResidentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text("Resident Page")),
        ),
        body: Container(
          height: 10000.0,
          width: 10000.0,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/homepage.jpeg'), fit: BoxFit.cover),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
           
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
               const SizedBox(
                  height: 16,
                ),
                Column(
                  children: [
                    Column(
                      children: [
                        _buildMenuItem(
                          context,
                          'Tasks',
                          Icons.task,
                          '/tasks',
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        _buildMenuItem(
                          context,
                          'Payments',
                          Icons.payment,
                          '/payments',
                        ),
                      ],
                    ),
                  ],
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          _buildMenuItem(
                            context,
                            'Schedules',
                            Icons.schedule,
                            '/schedules',
                          ),
                        ],
                      ),
                     
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

Widget _buildMenuItem(
    BuildContext context, String title, IconData iconData, String route) {
  return GestureDetector(
    onTap: () {
      Navigator.pushNamed(context, route);
    },
    child: Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.rectangle 
        ),
        height: 150.0,
        width: 150,
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconData,
                size: 60.0,
                color: Colors.blue,
              ),
              // const SizedBox(height: 10.0),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
