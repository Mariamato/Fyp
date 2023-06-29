// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../service/api_provider.dart';
import '../utils/util.dart';

final TextEditingController _taskController = TextEditingController();
final TextEditingController _locationController = TextEditingController();
final TextEditingController _dayController = TextEditingController();
final TextEditingController _timeController = TextEditingController();

late String? _fileName;

  Future<void> _selectFile(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      _fileName = result.files.single.name;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('File selected: $_fileName'),
        ),
      );
    }
  }

  Future<void> _uploadFile(BuildContext context) async {
    if (_fileName != null) {
      // Perform file upload logic here
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('File uploaded: $_fileName'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No file selected'),
        ),
      );
    }
  }

Future _SubmitReport(BuildContext context) async {
  String task = _taskController.text;
  String location = _locationController.text;
  String day = _dayController.text;
  String time = _timeController.text;

  var url = Uri.parse("$baseUrl/reports");
  String? token = await getToken();
  var headers = <String, String>{
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  };
  int? userId = await getUserId();
  print(userId);
  var data = {
    'task': task,
    'location': location,
    'day_of_service': day,
    'time_of_service': time,
    'status': 1,
    'user_id': userId,
  };
  print(data);
  var response = await http.post(
    url,
    headers: headers,
    body: jsonEncode(data),
  );
}

class ServiceProviderPage extends StatelessWidget {

  final _formKey = GlobalKey<FormState>();
  ServiceProviderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Service provider page")),
      ),
      body: Container(
        height: 10000.0,
        width: 10000.0,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/homepage.jpeg'), fit: BoxFit.cover),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextButton(
                      onPressed: (() => _uploadFile(context)),
                      child: const Text("Upload Task schedule here...")),
                  Center(
                    child: SingleChildScrollView(
                      child: SizedBox(
                        height: 500.0,
                        width: 400.0,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Form(
                              key: _formKey,
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextFormField(
                                      controller: _taskController,
                                      decoration: const InputDecoration(
                                        labelText: 'Task performed:',
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter task performed';
                                        }
                                        return null;
                                      },
                                    ),
                                    TextFormField(
                                      controller: _locationController,
                                      decoration: const InputDecoration(
                                        labelText: 'Location:',
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter the location task performed';
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 16.0),
                                    TextFormField(
                                      controller: _dayController,
                                      decoration: const InputDecoration(
                                        labelText: 'Day:',
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter the day task performed';
                                        }
                                        return null;
                                      },
                                    ),
                                    TextFormField(
                                      controller: _timeController,
                                      decoration: const InputDecoration(
                                        labelText: 'Time:',
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter the time task performed';
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 16.0),
                                    ElevatedButton(
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          // Save report to backend server here
                                          print('Submitting report');
                                        }
                                        _SubmitReport(context);
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
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
