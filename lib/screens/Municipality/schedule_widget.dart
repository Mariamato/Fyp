import 'package:flutter/material.dart';

class ScheduleWidget extends StatelessWidget {
  final int scheduleId;
  final String createdBy;
  final String startTime;
  final String endTime;
  final String day;
  final String location;
  final String description;

  const ScheduleWidget({
    Key? key,
    required this.scheduleId,
    required this.createdBy,
    required this.startTime,
    required this.endTime,
    required this.day,
    required this.location,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue, width: 0.15),
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.white,
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey[200],
              radius: 25.0,
              child: const Padding(
                  padding: EdgeInsets.all(6.0),
                  child: Icon(
                    Icons.schedule,
                    size: 20.0,
                    color: Colors.blue,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: Colors.grey[400],
                        size: 20,
                      ),
                      SizedBox(width: 5),
                      Text(
                        "Service Provider: $createdBy",
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.grey[400],
                        size: 20,
                      ),
                      SizedBox(width: 5),
                      Text(
                        location,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        color: Colors.grey[400],
                        size: 20,
                      ),
                      SizedBox(width: 5),
                      Text(
                        "$startTime - $endTime",
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Icon(
                        Icons.calendar_today,
                        color: Colors.grey[400],
                        size: 20,
                      ),
                      SizedBox(width: 5),
                      Text(
                        day,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                   Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: 
                   [
                    const Text('Task to be performed:'),
                    Text(
                        description,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                   ],),
                   
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
