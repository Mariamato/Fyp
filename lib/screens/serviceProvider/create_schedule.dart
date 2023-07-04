import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../service/api_provider.dart';
import '../../utils/util.dart';
import '../Municipality/view_schedule.dart';

class CreateSchedulePage extends StatefulWidget {
  CreateSchedulePage({super.key});

  @override
  State<CreateSchedulePage> createState() => _CreateSchedulePageState();
}

class _CreateSchedulePageState extends State<CreateSchedulePage> {
  late TextEditingController _startTimeController = TextEditingController();

  late TextEditingController _endTimeController = TextEditingController();

  late TextEditingController _dateController = TextEditingController();

  final TextEditingController _locationController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  late DateTime _selectedDate;

  late TimeOfDay _selectedStartTime;

  late TimeOfDay _selectedEndTime;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _selectedStartTime = TimeOfDay(hour: 00, minute: 00);
    _selectedEndTime = TimeOfDay(hour: 00, minute: 00);

    _dateController = TextEditingController();
    _startTimeController = TextEditingController();
    _endTimeController = TextEditingController();
  }

  @override
  void dispose() {
    _dateController.dispose();
    _startTimeController.dispose();
    _endTimeController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        // _selectedDate = picked;
        _dateController.text = picked.toString();
      });
    } else {
      _dateController.text = _selectedDate.toString();
    }
  }

  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedStartTime,
    );

    if (picked != null && picked != _selectedStartTime) {
      setState(() {
        // _selectedStartTime = picked;
        final hour = picked.hour.toString().padLeft(2, '0');
        final minute = picked.minute.toString().padLeft(2, '0');
        final period = picked.period == DayPeriod.am ? 'AM' : 'PM';
        final formattedTime = '$hour:$minute';
        _startTimeController.text = formattedTime;
      });
    } else {
      final hour = picked?.hour.toString().padLeft(2, '0');
      final minute = picked?.minute.toString().padLeft(2, '0');
      final period = picked?.period == DayPeriod.am ? 'AM' : 'PM';
      final formattedTime = '$hour:$minute';
      _startTimeController.text = formattedTime;
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedEndTime,
    );

    if (picked != null && picked != _selectedEndTime) {
      setState(() {
        // _selectedEndTime = picked;
        final hour = picked.hour.toString().padLeft(2, '0');
        final minute = picked.minute.toString().padLeft(2, '0');
        final period = picked.period == DayPeriod.am ? 'AM' : 'PM';
        final formattedTime = '$hour:$minute';
        _endTimeController.text = formattedTime;
      });
    } else {
      final hour = picked?.hour.toString().padLeft(2, '0');
      final minute = picked?.minute.toString().padLeft(2, '0');
      final period = picked?.period == DayPeriod.am ? 'AM' : 'PM';
      final formattedTime = '$hour:$minute';
      _endTimeController.text = formattedTime;
    }
  }

  void _create(BuildContext context) async {
    String startTime = _startTimeController.text;
    String endTime = _endTimeController.text;
    String date = _dateController.text;
    String location = _locationController.text;
    String description = _descriptionController.text;

    var url = Uri.parse("$baseUrl/schedules");

    var prefs = await SharedPreferences.getInstance();

    final String? token = prefs.getString("token");

    var headers = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };

    int? userId = await getUserId();

    var data = {
      'start_time': startTime,
      'end_time': endTime,
      'day': date,
      'location': location,
      'description': description,
      'user_id': userId,
    };

    var response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(data),
    );

    print(response.body);

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Schedule created successfully"),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          onVisible: () {
            _startTimeController.clear();
            _endTimeController.clear();
            _dateController.clear();
            _locationController.clear();
            _descriptionController.clear();
          },
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Schedule creation Successfully"),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          onVisible: () {
            _startTimeController.clear();
            _endTimeController.clear();
            _dateController.clear();
            _locationController.clear();
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Schedule"),
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
                  const SizedBox(height: 20.0),
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
                                      controller: _descriptionController,
                                      decoration: const InputDecoration(
                                        labelText: 'Description:',
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter the description of task to be performed';
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
                                      controller: _dateController,
                                      onTap: () => _selectDate(context),
                                      decoration: const InputDecoration(
                                        labelText: 'Select Date',
                                      ),
                                    ),
                                    const SizedBox(height: 16.0),
                                    // Text(
                                    //     'Selected Date: ${selectedDate.toString()}'),
                                    TextFormField(
                                      readOnly: true,
                                      controller: _startTimeController,
                                      onTap: () => _selectStartTime(context),
                                      decoration: const InputDecoration(
                                        labelText: 'Select Start Time',
                                      ),
                                    ),
                                    const SizedBox(height: 16.0),
                                    // Text(
                                    //     'Selected Date: ${selectedDate.toString()}'),
                                    TextFormField(
                                      readOnly: true,
                                      controller: _endTimeController,
                                      onTap: () => _selectEndTime(context),
                                      decoration: const InputDecoration(
                                        labelText: 'Select End Time',
                                      ),
                                    ),
                                    const SizedBox(height: 16.0),
                                    const SizedBox(height: 16.0),
                                    ElevatedButton(
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          // Save report to backend server here
                                          print('Submitting schedule');
                                        }
                                        _create(context);
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
                  const SizedBox(height: 20.0),
                  SizedBox(
                    width: double.infinity,
                    height: 50.0,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewSchedule(),
                          ),
                        );
                      },
                      child: const Text(
                        "View Schedules",
                        style: TextStyle(fontSize: 20.0),
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
