import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:municipal_cms/models/service_provider_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../service/api_provider.dart';

Future<List<ServiceProvider>> fetchServiceProviders() async {
  var prefs = await SharedPreferences.getInstance();

  final String apiUrl = '$baseUrl/service-providers';
  final String? token = prefs.getString("token");

  final response = await http.get(
    Uri.parse(apiUrl),
    headers: {
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body)['data'];
    List<ServiceProvider> serviceProviders = [];

    for (var provider in jsonData) {
      ServiceProvider serviceProvider = ServiceProvider(
        id: provider['id'],
        name: provider['name'],
        email: provider['email'],
        phoneNumber: provider['phone'],
        address: provider['address'],
        municipality: provider['municipality'],
        speciality: "General",
      );
      serviceProviders.add(serviceProvider);
    }

    return serviceProviders;
  } else {
    throw Exception('Failed to fetch service providers');
  }
}
