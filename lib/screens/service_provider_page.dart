// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:municipal_cms/screens/serviceProvider/create_schedule.dart';
import '../service/api_provider.dart';
import '../utils/util.dart';

final TextEditingController _taskController = TextEditingController();
final TextEditingController _locationController = TextEditingController();

late TextEditingController _dController = TextEditingController();
late TextEditingController _tController = TextEditingController();

late String? _fileName;

Future _SubmitReport(BuildContext context) async {
  String task = _taskController.text;
  String location = _locationController.text;
  String day = _dController.text;
  String time = _tController.text;

  var url = Uri.parse("$baseUrl/reports");

  String? token = await getToken();
  var headers = <String, String>{
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  };

  int? userId = await getUserId();

  // print(userId);
  var data = {
    'task': task,
    'location': location,
    'date_of_service': day,
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

  print(response.body);

  if (response.statusCode == 200) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Report submitted successfully'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        onVisible: () {
          _taskController.clear();
          _locationController.clear();
          _dController.clear();
          _tController.clear();
        },
      ),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Report submission failed'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        onVisible: () {
          _taskController.clear();
          _locationController.clear();
          _dController.clear();
          _tController.clear();
        },
      ),
    );
  }
}

class ServiceProviderPage extends StatefulWidget {
  ServiceProviderPage({super.key});

  @override
  State<ServiceProviderPage> createState() => _ServiceProviderPageState();
}

class _ServiceProviderPageState extends State<ServiceProviderPage> {
  final _formKey = GlobalKey<FormState>();
  late DateTime selectedDate;
  late TimeOfDay selectedTime;

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    selectedTime = TimeOfDay.now();

    // _dController.text = selectedDate.toString();
    // _tController.text = selectedTime.toString();
    _dController = TextEditingController();
    _tController = TextEditingController();
  }

  @override
  void dispose() {
    _dController.dispose();
    _tController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        // selectedDate = pickedDate;
        _dController.text = pickedDate.toString();
      });
    } else {
      _dController.text = selectedDate.toString();
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (pickedTime != null && pickedTime != selectedTime) {
      setState(() {
        // selectedTime = pickedTime;
        final hour = pickedTime.hour.toString().padLeft(2, '0');
        final minute = pickedTime.minute.toString().padLeft(2, '0');
        final period = pickedTime.period == DayPeriod.am ? 'AM' : 'PM';
        final formattedTime = '$hour:$minute';
        _tController.text = formattedTime;
      });
    } else {
      final hour = pickedTime?.hour.toString().padLeft(2, '0');
      final minute = pickedTime?.minute.toString().padLeft(2, '0');
      final period = pickedTime?.period == DayPeriod.am ? 'AM' : 'PM';
      final formattedTime = '$hour:$minute';
      _tController.text = '${formattedTime}';
    }
  }

  // File Manipulation
  File? _selectedFile;
  Future<void> _pickFile() async {
    final result = await FilePicker.platform
        .pickFiles(type: FileType.any, allowMultiple: false);

    if (result != null && result.files.isNotEmpty) {
      final fileBytes = result.files.first.bytes;
      final fileName = result.files.first.name;

      // upload file
      // await FirebaseStorage.instance.ref('uploads/$fileName').putData(fileBytes);
    }

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
      });
    }
  }

  Future<void> _uploadFile(BuildContext context) async {
    if (_selectedFile != null) {
      String fileName = _selectedFile!.path.split('/').last;

      var url = Uri.parse("$baseUrl/schedules");

      String? token = await getToken();

      var headers = <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

      int? userId = await getUserId();
      //print( 'here');
      final bytes = _selectedFile!.readAsBytesSync();

      // create multipart request
      var request = http.MultipartRequest("POST", url);

      // multipart that takes file
      request.files.add(http.MultipartFile.fromBytes(
        'file',
        bytes,
        filename: fileName,
      ));

      request.headers.addAll(headers);

      request.fields['user_id'] = userId.toString();

      print("===============================");
      print(request);

      // send the request
      var response = await request.send();

      print(response.statusCode);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('File uploaded: ${_selectedFile!.path}'),
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
                  // TextButton(
                  //     onPressed: (() => _uploadFile(context)),
                  //     child: const Text("Upload Task schedule here...")),
                  // ElevatedButton(
                  //     onPressed: () {
                  //       showDialog(
                  //         context: context,
                  //         builder: (BuildContext context) {
                  //           return SimpleDialog(
                  //             title: Text('Upload File'),
                  //             children: [
                  //               ListTile(
                  //                 leading: Icon(Icons.upload_file),
                  //                 title: Text('Upload'),
                  //                 onTap: () {
                  //                   Navigator.pop(context);
                  //                   _pickFile();
                  //                   // _uploadFile(context);
                  //                 },
                  //               ),
                  //               ListTile(
                  //                 leading: Icon(Icons.cancel),
                  //                 title: Text('Cancel'),
                  //                 onTap: () {
                  //                   Navigator.pop(context);
                  //                 },
                  //               ),
                  //             ],
                  //           );
                  //         },
                  //       ).then((value) {
                  //         if (value != null) {
                  //           _uploadFile(context);
                  //           ScaffoldMessenger.of(context).showSnackBar(
                  //             const SnackBar(
                  //               content: Text('File uploaded successfully'),
                  //               backgroundColor: Colors.green,
                  //               duration: Duration(seconds: 2),
                  //               behavior: SnackBarBehavior.floating,
                  //             ),
                  //           );
                  //         }
                  //       });
                  //     },
                  //     child: const Text(
                  //       "Upload Task Schedule",
                  //       style: TextStyle(fontSize: 20.0),
                  //     )),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateSchedulePage(),
                        ),
                      );
                    }, 
                    child: 
                    const Text(
                      "Create Task Schedule",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
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
                                      readOnly: true,
                                      controller: _dController,
                                      onTap: () => _selectDate(context),
                                      decoration: InputDecoration(
                                        labelText: 'Select Date',
                                      ),
                                    ),
                                    SizedBox(height: 16.0),
                                    // Text(
                                    //     'Selected Date: ${selectedDate.toString()}'),
                                    TextFormField(
                                      readOnly: true,
                                      controller: _tController,
                                      onTap: () => _selectTime(context),
                                      decoration: InputDecoration(
                                        labelText: 'Select Time',
                                      ),
                                    ),
                                    SizedBox(height: 16.0),
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