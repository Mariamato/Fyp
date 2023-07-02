import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:municipal_cms/utils/util.dart';

import '../service/api_provider.dart';

class LipaHapaPage extends StatelessWidget {
  final TextEditingController _phoneNumberController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  void _lipia(BuildContext context) async {
    String phoneNumber = _phoneNumberController.text;
    var url = Uri.parse("$baseUrl/payments");
    String? token = await getToken();
    var headers = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'appliction/json',
      'Authorization': 'Bearer $token',
      
    };
    int? userId = await getUserId();
    var data = {
      'phone': phoneNumber,
      'role': 'resident',
      'user_id': userId,
    };
    print(data);
    var response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(data),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('payment'),
        backgroundColor: Colors.black,
      ),
      body: Container(
        height: 10000.0,
        width: 10000.0,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/ilala-council.jpg'), fit: BoxFit.cover),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.5, sigmaY: 10.5),
          child: Center(
            child: SizedBox(
              height: 400,
              width: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    child: Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Ilikuweza kulipia, ingiza namba ya simu na utapata Control number kwa njia ya sms, lipia kwa mtandao wowote. ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                      letterSpacing: 1.5),
                                ),
                                TextFormField(
                                  controller: _phoneNumberController,
                                  decoration: const InputDecoration(
                                    labelText: 'Phone number',
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter valid phone number';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      _lipia(context);
                                    } else {
                                      print('Invalid inputs');
                                      // Print the reason why it is invalid
                                      print(_formKey.currentState!.validate());
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  child: const Text('Lipia'),
                                ),
                              ],
                            ),
                          ),
                        )),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  const Text(
                    "Get control number via sms: ",
                    style: TextStyle(color: Colors.white),
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
