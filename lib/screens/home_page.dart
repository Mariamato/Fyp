import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:municipal_cms/controllers/task_controller.dart';
import 'package:municipal_cms/screens/Service_provider_login_page.dart';
import 'package:municipal_cms/screens/lipia_hapa.dart';
import 'package:municipal_cms/screens/Municipality/municipality_login_page.dart';
import 'package:municipal_cms/screens/payments/payments_list_page.dart';
import 'package:municipal_cms/screens/tasks/task_page.dart';
import 'package:provider/provider.dart';
import 'Municipality/manage_service_provider.dart';
import 'Municipality/view_report.dart';
import 'Municipality/view_schedule.dart';
import 'Resident_login_page.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ListenableProvider<TaskController>(
          create: (_) => TaskController(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Municipal Cleaning Management App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
        initialRoute: '/',
        routes: {
         '/Report':(context) =>const  ViewReport(),
         '/Schedule':(context) =>  ViewSchedule(),
         '/schedules':(context) =>  ViewSchedule(),
         '/manage':(context) =>  const ManageServiceProvider(),
          '/tasks': (context) => TaskPage(),
         // '/payments': (context) => ConstructionPage(),
         // '/schedules': (context) => ConstructionPage(),
          '/resident': (context) => ResidentLoginPage(),
          '/ServiceProvider': (context) => ServiceProviderLoginPage(),
          '/Municipality': (context) => MunicipalityLoginPage(),
          '/payments': (context) => LipaHapaPage(),
        },
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('MCM App')),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/homepage.jpeg'), fit: BoxFit.cover),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  'Welcome to the',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  'MCM App',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            const Center(
              child: SizedBox(
                  height: 200,
                  width: 300,
                  child: Card(
                      child: Image(image: AssetImage('assets/homepage.jpeg')))),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Expanded(
                child: GridView.count(
              crossAxisCount: 3,
              children: [
                _buildMenuItem(
                  context,
                  'Resident',
                  Icons.person,
                  '/resident',
                ),
                _buildMenuItem(
                  context,
                  'Service Provider',
                  Icons.local_car_wash,
                  '/ServiceProvider',
                ),
                _buildMenuItem(
                  context,
                  'Municipality',
                  Icons.location_city_rounded,
                  '/Municipality',
                ),
              ],
            ))
          ]),
        ),
      ),
    );
  }

  Widget _buildMenuItem(
      BuildContext context, String title, IconData iconData, String route) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Card(
        elevation: 8.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              size: 50.0,
              color: Colors.blue,
            ),
            const SizedBox(height: 10.0),
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
    );
  }
}
