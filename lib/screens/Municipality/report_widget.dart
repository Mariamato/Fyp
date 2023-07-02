import 'package:flutter/material.dart';

class ReportWidget extends StatelessWidget {
  final int reportId;
  final String task;
  final String userName;
  final String dateOfService;
  final String timeOfService;
  final String status;

  const ReportWidget(
      {Key? key,
      required this.reportId,
      required this.task,
      required this.userName,
      required this.dateOfService,
      required this.timeOfService,
      required this.status})
      : super(key: key);

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
                    Icons.book,
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
                    "Task: $task",
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "Done by: $userName",
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today,
                        color: Colors.grey,
                        size: 14.0,
                      ),
                      const SizedBox(width: 4.0),
                      Text(
                        "Done on: $dateOfService",
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      const Icon(
                        Icons.timer_sharp,
                        color: Colors.grey,
                        size: 14.0,
                      ),
                      Text(
                        "Time: $timeOfService",
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
