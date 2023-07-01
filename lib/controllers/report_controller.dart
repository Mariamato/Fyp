import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:municipal_cms/models/report_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../service/api_provider.dart';

Future<List<Report>> fetchReports() async {
  var prefs = await SharedPreferences.getInstance();

  final String apiUrl = '$baseUrl/reports';
  final String? token = prefs.getString("token");

  final response = await http.get(
    Uri.parse(apiUrl),
    headers: {
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body)['data'];
    List<Report> reports = [];

    for (var data in jsonData) {
      Report report = Report(
        id: data['id'],
        task: data['task'],
        userName: data['user'],
        dateOfService: data['date_of_service'],
        timeOfService: data['time_of_service'],
        status: data['status'],
      );
      reports.add(report);
    }

    return reports;
  } else {
    throw Exception('Failed to fetch service providers');
  }
}
