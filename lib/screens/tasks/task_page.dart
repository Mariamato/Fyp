// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:municipal_cms/screens/tasks/tasks_page.dart';
import 'package:municipal_cms/utils/util.dart';

import '../../service/api_provider.dart';

final TextEditingController _TaskController = TextEditingController();
final TextEditingController _LocationController = TextEditingController();
final TextEditingController _task_description = TextEditingController();

Future<void> _SubmitTask(BuildContext context) async {
  String task = _TaskController.text;
  String location = _LocationController.text;
  String task_description = _task_description.text;

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
  print(data);
  var response = await http.post(
    url,
    headers: headers,
    body: jsonEncode(data),
  );
}

class TaskPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  TaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Request for a pickup")),
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
              SizedBox(
                height: 500.0,
                width: 300.0,
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
                              controller: _task_description,
                              decoration: const InputDecoration(
                                labelText: 'Task description:',
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter task required';
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
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const TasksPage()),
                  );
                },
                child: const Text('see Task history here'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
