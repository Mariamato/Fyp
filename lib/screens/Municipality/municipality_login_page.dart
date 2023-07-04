// ignore_for_file: use_build_context_synchronously

import 'dart:ui';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../service/api_provider.dart';
import '../../service/visibility_provider.dart';
import '../Municipality_page.dart';
import '../municipality_registration_page.dart';

// ignore: must_be_immutable
class MunicipalityLoginPage extends StatelessWidget {
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  MunicipalityLoginPage({super.key});

  void _login(BuildContext context) async {
    String password = _passwordController.text;
    String phoneNumber = _contactController.text;
    
    var url = Uri.parse("$baseUrl/login");
    var headers = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'user_type': 'admin'
    };
    var data = {
      'phone': phoneNumber,
      'password': password,
      'role':'admin',
    };
    

    var response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
       var jsonResponse = json.decode(response.body);

      if (jsonResponse['error'] == 'Unauthorized'){
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Login Failed'),
            content: const Text('Credentials incorrect'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }


      // print(jsonResponse);
      if (jsonResponse['token'] == null) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Login Failed'),
            content: const Text('Credentials incorrect'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }

      if (jsonResponse['token'] != null && jsonResponse['userData']['role'] == 'admin') {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("token", jsonResponse['token']);
        prefs.setInt("userId", jsonResponse['userData']['id']);
        prefs.setString("name", jsonResponse['userData']['name']);
        prefs.setString("email", jsonResponse['userData']['email']);
        prefs.setString("phone", jsonResponse['userData']['phone']);

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MunicipalityPage()),
        );
      }
    }
    if (response.statusCode == 401) {
      print(response.body);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Login Failed'),
          content: const Text('Credentials incorrect'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
    if (response.statusCode == 400) {
      print(response.body);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Login Failed'),
          content: const Text('Credentials incorrect, try again'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  void _register(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MunicipalityRegistrationPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => visibility(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Municipality Login'),
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
            child: Center(
              child: SizedBox(
                height: 400.0,
                width: 300.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Form(
                          key: _formKey,
                          child: Consumer<visibility>(
                              builder: (context, model, _) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                TextFormField(
                                  controller: _contactController,
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                    labelText: 'Phone Number',
                                    prefixIcon: Icon(Icons.phone_rounded),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter your phone number';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 16.0),
                                TextFormField(
                                    controller: _passwordController,
                                    validator: (input) => input!.length < 8
                                        ? 'Password should atleast be with 8 characters'
                                        : null,
                                    decoration: InputDecoration(
                                      labelText: 'Password',
                                      prefixIcon: const Icon(Icons.lock),
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          model.togglePasswordVisibility();
                                        },
                                        icon: Icon(
                                          model.hidePassword
                                              ? Icons.visibility
                                              : Icons.visibility_off_outlined,
                                        ),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                    ),
                                    obscureText: !model.hidePassword
                                  ),
                                const SizedBox(height: 16.0),
                                TextButton(
                                  onPressed: () => _register(context),
                                  style: TextButton.styleFrom(
                                    primary: Colors.blue,
                                    padding:
                                        EdgeInsets.symmetric(vertical: 16.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  child: const Text("Don't have an account? Register Now"),
                                ),
                                const SizedBox(height: 10),
                                ElevatedButton(
                                  child: Text('Login'),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      _login(context);
                                    } else {
                                      print('Invalid inputs');
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.blue,
                                    padding:
                                        EdgeInsets.symmetric(vertical: 16.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void setState(Null Function() param0) {}
}
