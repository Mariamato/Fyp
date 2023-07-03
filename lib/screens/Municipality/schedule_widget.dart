import 'package:flutter/material.dart';

class ScheduleWidget extends StatelessWidget {
  final int scheduleId;
  final String filePath;
  final String uploadedBy;

  const ScheduleWidget({
    Key? key,
    required this.scheduleId,
    required this.filePath,
    required this.uploadedBy,
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
                )
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    uploadedBy,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
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
