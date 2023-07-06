import 'package:flutter/material.dart';

class TaskWidget extends StatelessWidget { 
  final String customerName;
  final String taskType;
  final String dueDate;
  final String completedAt;
  final String location;
  final int taskId;

  const TaskWidget({
    Key? key,
    required this.customerName,
    required this.taskType,
    required this.dueDate,
    required this.completedAt,
    required this.location,
    required this.taskId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10),
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
                    Icons.task,
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
                  Text(
                    customerName,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    'Type: $taskType',
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today,
                        color: Colors.grey,
                        size: 14.0,
                      ),
                      const SizedBox(width: 4.0), // Adjust the width as needed
                      Text(
                        dueDate,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(width: 16.0), // Adjust the width as needed
                      const Icon(
                        Icons.location_on,
                        color: Colors.grey,
                        size: 14.0,
                      ),
                      const SizedBox(width: 4.0), // Adjust the width as needed
                      Text(
                        location,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
