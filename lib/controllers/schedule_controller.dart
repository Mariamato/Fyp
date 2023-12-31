import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:municipal_cms/models/schedule_model.dart';
import 'package:municipal_cms/service/api_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<List<Schedule>> fetchSchedules() async {
  var prefs = await SharedPreferences.getInstance();

  const String apiUrl = '$baseUrl/schedules';
  final String? token = prefs.getString("token");

  final response = await http.get(
    Uri.parse(apiUrl),
    headers: {
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body)['data'];
    List<Schedule> schedules = [];

    for (var data in jsonData) {
      Schedule schedule = Schedule(
        id: data['id'],
        startTime: data['start_time'],
        endTime: data['end_time'],
        day: data['day'],
        location: data['location'],
        description: data['description'],
        createdBy: data['createdBy'],
      );
      schedules.add(schedule);
    }

    return schedules;
  } else {
    throw Exception("Failed to fetch schedules");
  }
}
