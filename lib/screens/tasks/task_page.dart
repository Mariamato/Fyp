// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:municipal_cms/screens/tasks/tasks_page.dart';
import 'package:municipal_cms/utils/util.dart';

import '../../service/api_provider.dart';

final TextEditingController _TaskController = TextEditingController();
final TextEditingController _LocationController = TextEditingController();
final TextEditingController _DescriptionController = TextEditingController();

Future<void> _SubmitTask(BuildContext context) async {
  String task = _TaskController.text;
  String location = _LocationController.text;
  String task_description = _DescriptionController.text;

  var url = Uri.parse("$baseUrl/tasks");
  String? token = await getToken();
  var headers = <String, String>{
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  };
  int? userId = await getUserId();
  print(userId);
  var data = {
    'name': task,
    'location': location,
    'description': task_description,
    'task_type_id': 1,
    'priority': 'low',
    'status': 'new',
    'user_id': userId,
  };

  // print(data); // for debugging issues

  var response = await http.post(
    url,
    headers: headers,
    body: jsonEncode(data),
  );

  // if response is okay then clear inputs and display a popup
  if (response.statusCode == 200) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Task created successfully'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 5),
        behavior: SnackBarBehavior.floating,
        onVisible: () {
          _TaskController.clear();
          _LocationController.clear();
          _DescriptionController.clear();
        },
      ),
    );
  }

  if (response.statusCode == 500) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Server error'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        onVisible: () {
          // Clear the input fields
          _TaskController.clear();
          _LocationController.clear();
          _DescriptionController.clear();

          // Reset the form
          // _formKey.currentState?.reset();
        },
      ),
    );
  }
}

class TaskPage extends StatefulWidget {

  TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Request for a pickup"),
      ),
      body: Container(
        height: 10000.0,
        width: 10000.0,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/homepage.jpeg'), fit: BoxFit.cover),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.5, sigmaY: 10.5),
          child: Column(
            children: [
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset("assets/resindent.jpg"),
                              ],
                            ),
                            TextFormField(
                              controller: _TaskController,
                              decoration: const InputDecoration(
                                labelText: 'Task:',
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter task required';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: _LocationController,
                              decoration: const InputDecoration(
                                labelText: 'Location:',
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter the location of the task';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16.0),
                            TextFormField(
                              controller: _DescriptionController,
                              decoration: const InputDecoration(
                                labelText: 'Task description:',
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter task description';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16.0),
                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _SubmitTask(context);
                                }
                              },
                              child: const Text('Submit'),
                             
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TasksPage()),
                    );
                  },
                  child: const Text('View Tasks'),
                ),
              ),
              // const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}
