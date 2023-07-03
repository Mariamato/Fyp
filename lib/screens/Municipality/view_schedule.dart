import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:municipal_cms/controllers/task_controller.dart';
import 'package:municipal_cms/repositories/tasks_repository.dart';
import 'package:municipal_cms/screens/Municipality/schedule_widget.dart';
import 'package:municipal_cms/screens/tasks/task_widget.dart';
import 'package:provider/provider.dart';
import 'package:municipal_cms/models/schedule_model.dart';
import '../../controllers/schedule_controller.dart';

class ViewSchedule extends StatefulWidget {
  const ViewSchedule({super.key});

  @override
  _ViewScheduleState createState() => _ViewScheduleState();
}

class _ViewScheduleState extends State<ViewSchedule> {
  List<Schedule> schedules = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchScheduleData();
  }

  void fetchScheduleData() async {
    try {
      List<Schedule> fetchedSchedules = await fetchSchedules();
      setState(() {
        schedules = fetchedSchedules;
        isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            CupertinoIcons.chevron_back,
            size: 27,
            color: Colors.white,
          ),
        ),
        elevation: 0,
        centerTitle: true,
        title: const Text("Schedules List"),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                border: const Border(
                    bottom: BorderSide(color: Colors.blue, width: 1)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total schedules",
                    style: TextStyle(
                      color: Colors.black87,
                    ),
                  ),
                  Text(schedules.length.toString()),
                ],
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Expanded(
              child: isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      itemCount: schedules.length,
                      itemBuilder: (context, index) {
                        var schedule = schedules[index];
                        return ScheduleWidget(
                          scheduleId: schedule.id!,
                          filePath: schedule.filePath!,
                          uploadedBy: schedule.uploadedBy!,
                        );
                      },
                    ),
            )
          ],
        ),
      ),
    );
  }
}
