// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:municipal_cms/screens/tasks/task_widget.dart';
import 'package:municipal_cms/models/task_model.dart';

import '../../controllers/tasks_controller.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  _TasksPageState createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  // final TaskController controller = TaskController();
  List<Task> tasks = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchTaskData();
  }

  void fetchTaskData() async {
    try {
      List<Task> fetchedTasks = await fetchTasks();
      setState(() {
        tasks = fetchedTasks;
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
        title: const Text("Tasks List"),
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
                    "Total Tasks requested by Resident",
                    style: TextStyle(
                      color: Colors.black87,
                    ),
                  ),
                  Text(tasks.length.toString()),
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
                        itemCount: tasks.length,
                        itemBuilder: (context, index) {
                          var task = tasks[index];
                          DateTime parsedDate = task.parsedDueDate;
                          String formattedDate = DateFormat('MMM dd, yyyy')
                              .format(parsedDate)
                              .toString();
                          return TaskWidget(
                            customerName: task.customerName!,
                            taskType: task.taskType!,
                            dueDate: formattedDate,
                            completedAt: task.completedAt!,
                            location: task.location!,
                            taskId: task.id!,
                          );
                        },
                      ))
          ],
        ),
      ),
    );
  }
}
