// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'dart:ui';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:municipal_cms/screens/Resident_login_page.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../service/api_provider.dart';
import '../service/visibility_provider.dart';

class RegistrationPage extends StatefulWidget {
  RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _municipalityNameController =
      TextEditingController();

  final TextEditingController _ConfirmPasswordController =
      TextEditingController();

  final TextEditingController _contactController = TextEditingController();

  final TextEditingController _physicalAddressController =
      TextEditingController();

  final TextEditingController _fullNameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _register(BuildContext context) async {
    String password = _passwordController.text;
    //String confirmPassword = _ConfirmPasswordController.text;
    String fullName = _fullNameController.text;
    String email = _emailController.text;
    String phoneNumber = _contactController.text;
    String municipality = _municipalityNameController.text;
    String passwordConfirmation = _ConfirmPasswordController.text;
    String location = _physicalAddressController.text;
    // var csrfResponse = await http.get(Uri.parse('/sanctum/csrf-cookie'));
    // var csrfToken = csrfResponse.headers['set-cookie'] ?? '';

    var url = Uri.parse("$baseUrl/register");
    var headers = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      // 'X-XSRF-TOKEN': csrfToken,
      'user_type': 'Resident'
    };
    var data = {
      'name': fullName,
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation,
      'address': location,
      'phone': phoneNumber,
      'municipality': municipality,
      'role': 'resident',
    };
    var response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      print(data);
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('Registration'),
                content: const Text('Resident registered successfully'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('OK'),
                  ),
                ],
              ));
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ResidentLoginPage()),
      );
    }
    if (response.statusCode == 422) {
      print(response.body);
      print(data);
      // Display an error message to the user
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Registration Failed'),
          content: const Text('Try again'),
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

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => visibility(),
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Jisajili '),
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
                child: Center(
                  child: SizedBox(
                    height: 500.0,
                    width: 600.0,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          child: Form(
                              key: _formKey,
                              child: Consumer<visibility>(
                                  builder: (context, model, _) {
                                return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      TextFormField(
                                        controller: _fullNameController,
                                        decoration: const InputDecoration(
                                          labelText: 'Full Name',
                                          icon: Icon(Icons.person),
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter your Name';
                                          }
                                          return null;
                                        },
                                      ),
                                      TextFormField(
                                        controller: _emailController,
                                        decoration: const InputDecoration(
                                          labelText: 'Email',
                                          icon: Icon(Icons.email),
                                        ),
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        validator: (input) =>
                                            input!.contains("@.")
                                                ? 'Email Id should be valid'
                                                : null,
                                      ),
                                      const SizedBox(height: 16.0),
                                      TextFormField(
                                        controller: _passwordController,
                                        validator: (input) => input!.length < 8
                                            ? 'Password should atleast be with 8 characters'
                                            : null,
                                        decoration: InputDecoration(
                                          labelText: 'Password',
                                          icon: const Icon(Icons.lock),
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              model.hidePassword
                                                  ? Icons
                                                      .visibility
                                                  : Icons.visibility_off_outlined,
                                            ),
                                            onPressed: () {
                                              model.togglePasswordVisibility();
                                            },
                                          ),
                                        ),
                                        obscureText: !model.hidePassword,
                                      ),
                                      TextFormField(
                                        controller: _ConfirmPasswordController,
                                        decoration: InputDecoration(
                                          labelText: 'Confirm password',
                                          icon: const Icon(Icons.lock),
                                           suffixIcon: IconButton(
                                            icon: Icon(
                                              model.hidePassword
                                                  ? Icons
                                                      .visibility
                                                  : Icons.visibility_off_outlined,
                                            ),
                                            onPressed: () {
                                              model.togglePasswordVisibility();
                                            },
                                          ),
                                        ),
                                        
                                        obscureText: !model.hidePassword,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Password entered does not match';
                                          }
                                          return null;
                                        },
                                      ),
                                      TextFormField(
                                        controller: _municipalityNameController,
                                        decoration: const InputDecoration(
                                            labelText: 'Municipality Name',
                                            icon: Icon(Icons.location_city)),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter your Municipality Name';
                                          }
                                          return null;
                                        },
                                      ),
                                      TextFormField(
                                        controller: _contactController,
                                        decoration: const InputDecoration(
                                            labelText: 'Phone Number',
                                            icon: Icon(Icons.phone_rounded)),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter your Phone number';
                                          }
                                          return null;
                                        },
                                      ),
                                      TextFormField(
                                        controller: _physicalAddressController,
                                        decoration: const InputDecoration(
                                            labelText: 'Location',
                                            icon: Icon(Icons.mail)),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter your Location';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(
                                        height: 20.0,
                                      ),
                                      Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.all(15.0),
                                        alignment: Alignment.topCenter,
                                        child: ElevatedButton(
                                          child: const Text('Register'),
                                          onPressed: () {
                                            _register(context);
                                          },
                                        ),
                                      )
                                    ]);
                              })),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
