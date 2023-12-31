import 'dart:ui';

import 'package:flutter/material.dart';
// ignore: implementation_imports

class MunicipalityPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Municipality"),
        ),
        body: Container(
            height: 10000.0,
            width: 10000.0,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/ilala-council.jpg'),
                  fit: BoxFit.cover),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.5, sigmaY: 10.5),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildMenuItem(
                      context,
                      'Manage Service Providers',
                      Icons.local_car_wash,
                      '/manage',
                    ),
                    _buildMenuItem(
                      context,
                      'View Schedules',
                      Icons.schedule,
                      '/Schedule',
                    ),
                    _buildMenuItem(
                      context,
                      'View Reports',
                      Icons.report,
                      '/Report',
                    ),
                  ],
                ),
              ),
            )));
  }
}

Widget _buildMenuItem(
    BuildContext context, String title, IconData iconData, String route) {
  return GestureDetector(
    onTap: () {
      Navigator.pushNamed(context, route);
    },
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: const BoxDecoration(shape: BoxShape.rectangle),
        height: 120.0,
        width: 200.0,
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
