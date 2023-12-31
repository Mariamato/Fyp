import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:municipal_cms/screens/Municipality/schedule_widget.dart';
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

                        DateTime parsedStartTime = schedule.parsedStartTime;
                        DateTime parsedEndTime = schedule.parsedEndTime;

                        DateTime parsedDate = schedule.parsedDate;

                        String formattedDate = DateFormat('MMM, dd, yyyy')
                            .format(parsedDate)
                            .toString();

                        String formattedStartTime = DateFormat('hh:mm')
                            .format(parsedStartTime)
                            .toString();

                        String formattedEndTime = DateFormat('hh:mm')
                            .format(parsedEndTime)
                            .toString();
                            
                        return ScheduleWidget(
                          scheduleId: schedule.id!,
                          createdBy: schedule.createdBy!,
                          startTime: formattedStartTime,
                          endTime: formattedEndTime,
                          day: formattedDate,
                          location: schedule.location!,
                          description: schedule.description!,
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
