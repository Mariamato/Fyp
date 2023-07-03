import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:municipal_cms/models/payment_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../service/api_provider.dart';

Future<List<Payment>> fetchPayments() async {
  var prefs = await SharedPreferences.getInstance();

  const String apiUrl = '$baseUrl/payments';
  final String? token = prefs.getString("token");

  final response = await http.get(
    Uri.parse(apiUrl),
    headers: {
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body)['data'];
    List<Payment> payments = [];

    for (var data in jsonData) {
      Payment payment = Payment(
        id: data['id'],
        refNo: data['reference_number'],
        controlNo: data['control_number'],
        amount: data['amount'],
        method: data['payment_method'],
      );
      payments.add(payment);
    }

    return payments;
  } else {
    throw Exception('Failed to fetch payments');
  }
}
