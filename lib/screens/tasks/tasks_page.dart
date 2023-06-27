import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:municipal_cms/controllers/task_controller.dart';
import 'package:municipal_cms/repositories/tasks_repository.dart';
import 'package:municipal_cms/screens/tasks/task_widget.dart';
import 'package:provider/provider.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  _TasksPageState createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
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
          child: Icon(
            CupertinoIcons.chevron_back,
            size: 27,
            color: Colors.white,
          ),
        ),
        elevation: 0,
        centerTitle: true,
        title: Text("Tasks"),
      ),
      body: SafeArea(
        minimum: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                border:
                    Border(bottom: BorderSide(color: Colors.blue, width: 1)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Tasks",
                    style: TextStyle(
                      color: Colors.black87,
                    ),
                  ),
                  Text(controller.totalTasks.toString()),
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Expanded(
              child: Consumer<TaskController>(
                builder: (context, controller, _) {
                  if (controller.isLoading) {
                    return Center(
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
