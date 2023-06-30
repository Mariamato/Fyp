import 'package:flutter/material.dart';
import 'package:municipal_cms/models/task_model_dio.dart';
import 'package:municipal_cms/repositories/tasks_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskController extends ChangeNotifier {
  int totalTasks = 0;
  List<Task> tasks = [];
  bool isLoading = true;

  Future<void> loadTasks() async {
    var repo = TasksRespository();
    var prefs = await SharedPreferences.getInstance();

    try {
      // show loading indicator or perform any other required tasks
      // showDialog(
      //   context: context,
      //   barrierDismissible: false,
      //   builder: (context) => Center(child: CircularProgressIndicator()),
      // );

      print(prefs.getString("token"));

      final response = repo.getTasks(
          beforeSend: () {},
          onSuccess: (res) {
            tasks.addAll(res.data!);
            this.totalTasks = tasks.length;
          },
          onError: (error) {
            print(error);
          },
          token: prefs.getString("token"));
    } catch (e) {
      print(e);
    }

    notifyListeners();
  }
}
