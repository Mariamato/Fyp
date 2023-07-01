import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../service/api_provider.dart';

class CreateServiceProviderPage extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _specialityController = TextEditingController();
  final TextEditingController _municipalityController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  CreateServiceProviderPage({super.key});

  void _create(BuildContext context) async {
    String name = _nameController.text;
    String email = _emailController.text;
    String phoneNumber = _phoneNumberController.text;
    String address = _addressController.text;
    String speciality = _specialityController.text;
    String municipality = _municipalityController.text;

    var url = Uri.parse("$baseUrl/users");

    var prefs = await SharedPreferences.getInstance();

    final String? token = prefs.getString("token");

    var headers = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var data = {
      'name': name,
      'email': email,
      'phone': phoneNumber,
      'address': address,
      'speciality': speciality,
      'municipality': municipality,
      'role': 'service_provider'
    };

    var response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);

      if (jsonResponse['status'] != 'success') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error, re-check entries'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            onVisible: () {
              // do nothing
            },
          ),
        );
      }

      if (jsonResponse['status'] == 'success') {
        var providerName = jsonResponse["data"]["name"];

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Provider $providerName successfully created!'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            onVisible: () {
              _nameController.clear();
              _emailController.clear();
              _addressController.clear();
              _phoneNumberController.clear();
              _municipalityController.clear();
              _specialityController.clear();
            },
          ),
        );
      }
    }

    if (response.statusCode == 500) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Server error'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          onVisible: () {
            // do nothing
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Service Provider"),
      ),
      body: Container(
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
                          TextFormField(
                            controller: _nameController,
                            decoration: const InputDecoration(
                              labelText: 'Name:',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter name';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                              labelText: 'Email:',
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter valid email';
                              } else if (value.contains("@.")) {
                                return 'Email should be valid';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: _phoneNumberController,
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                              labelText: 'Phone:',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter phone number';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: _addressController,
                            decoration: const InputDecoration(
                              labelText: 'Address:',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter required address';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: _specialityController,
                            decoration: const InputDecoration(
                              labelText: 'Speciality:',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter speciality';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: _municipalityController,
                            decoration: const InputDecoration(
                              labelText: 'Municipality:',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter municipality to which provider belongs';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10.0),
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _create(context);
                              } else {
                                print('Invalid inputs');
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue,
                              padding: EdgeInsets.symmetric(vertical: 16.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: const Text("Create"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
