import 'dart:convert';

import 'package:http/http.dart' as http;

//const baseUrl = 'http://localhost:8085/api'; // for PKMaestro's PC
  const baseUrl = 'http://localhost:8000/api'; // for MariaMato's PC

String? token = "";

class ApiClient {
  final String url;
  final String? token;
  final Map<String, dynamic>? data;
  ApiClient({
    required this.url,
    required this.token,
    this.data = null,
  });

  void fetch({
    required Function() beforeSend,
    required Function(dynamic data) onSuccess,
    required Function(dynamic data) onError,
  }) async {
    Uri uri = Uri.parse(baseUrl + url);
    http.Response response = await http.get(uri, headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    });

    if (response.statusCode == 200) {
      if (onSuccess != null) {
        var data = jsonDecode(response.body);
        print("DATA:_" + data.toString());
        onSuccess(data);
      }
    } else {
      if (onError != null) {
        onError(response.body);
      }
    }
  }

  void edit({
    required Function() beforeSend,
    required Function(dynamic data) onSuccess,
    required Function(dynamic data) onError,
  }) async {
    Uri uri = Uri.parse(baseUrl + url);
    http.Response response = await http.post(uri,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(data));

    if (response.statusCode == 200) {
      if (onSuccess != null) {
        var data = jsonDecode(response.body);
        print(data);
        onSuccess(data);
      }
    } else {
      if (onError != null) {
        onError(response.body);
      }
    }
  }
}
