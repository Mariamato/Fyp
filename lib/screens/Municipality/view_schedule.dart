import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:municipal_cms/controllers/task_controller.dart';
import 'package:municipal_cms/repositories/tasks_repository.dart';
import 'package:municipal_cms/screens/tasks/task_widget.dart';
import 'package:provider/provider.dart';

class ViewSchedule extends StatefulWidget {
  const ViewSchedule({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ViewScheduleState createState() => _ViewScheduleState();
}

class _ViewScheduleState extends State<ViewSchedule> {
  final TaskController controller = TaskController();

  @override
  void initState() {
    super.initState();
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
        title: const Text("List of schedule"),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            Container(
              padding:const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                border:
                    const Border(bottom: BorderSide(color: Colors.blue, width: 1)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 const Text(
                    "Total schedule",
                    style: TextStyle(
                      color: Colors.black87,
                    ),
                  ),
                  Text(controller.totalTasks.toString()),
                ],
              ),
            ),
          const  SizedBox(
              height: 10.0,
            ),
            Expanded(
              child: Consumer<TaskController>(
                builder: (context, controller, _) {
                  if (controller.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: controller.tasks.length,
                      itemBuilder: (context, index) {
                        var task = controller.tasks[index];
                        return Task(
                          customerName: task.customerName!,
                          taskType: task.taskType!,
                          dueDate: task.dueDate!,
                          completedAt: task.completedAt!,
                          taskId: task.id!,
                        );
                      },
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}