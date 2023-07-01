import 'package:http/http.dart' as http;
import 'package:municipal_cms/service/api_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../models/task_model.dart';

Future<List<Task>> fetchTasks() async {
  var prefs = await SharedPreferences.getInstance();
  
  final String apiUrl = '$baseUrl/tasks';
  final String? token = prefs.getString("token"); // Replace with your actual bearer token

  final response = await http.get(
    Uri.parse(apiUrl),
    headers: {
      'Authorization': 'Bearer $token',
    },
  );
  
  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body)['data'];
    List<Task> tasks = [];

    for (var taskData in jsonData) {
      Task task = Task(
        id: taskData['id'],
        customerName: taskData['name'],
        taskType: taskData['task_type'],
        description: taskData['description'],
        priority: taskData['priority'],
        dueDate: taskData['due_date'],
        completedAt: taskData['completed_at'],
        location: taskData['location'],
      );
      tasks.add(task);
    }

    return tasks;
  } else {
    throw Exception('Failed to fetch tasks');
  }
}
