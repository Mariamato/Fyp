import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:municipal_cms/utils/util.dart';

import '../service/api_provider.dart';

class LipaHapaPage extends StatelessWidget {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  void _lipia(BuildContext context) async {
    String phoneNumber = _phoneNumberController.text;
    String amount = _amountController.text;

    var url = Uri.parse("$baseUrl/payments");
    String? token = await getToken();
    var headers = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'appliction/json',
      'Authorization': 'Bearer $token',
      'role': 'resident'
    };
    int? userId = await getUserId();
    var data = {
      'phone': phoneNumber,
      'amount': amount,
      'user_id': userId,
      'method_id': 1,
    };
    print(data);
    var response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(data),
    );

    print(response.body);

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      if (jsonResponse['status'] == 'success') {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Payment successful, control number: ${jsonResponse['data']['control_number']} sent to $phoneNumber'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 5),
            behavior: SnackBarBehavior.floating,
            onVisible: () {
              // phoneNumber = '';
              // amount = '';
              _phoneNumberController.clear();
              _amountController.clear();
              // Navigator.pop(context);
              // go back

              // Navigator.pushNamed(context, '/home');
            },
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Payment failed, try again'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            onVisible: () {

            },
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Payment Successfully'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lipia Hapa'),
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
              // height: 400,
              // width: 300,
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
                                  // 'Ilikuweza kulipia, ingiza namba ya simu na utapata Control number kwa njia ya sms, lipia kwa mtandao wowote. ',
                                  "For payment, enter your phone number and you will get a Control number via sms, pay by any network.",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                      letterSpacing: 1.5),
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                TextFormField(
                                  controller: _amountController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    labelText: 'Amount',
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter valid Amount';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                TextFormField(
                                  controller: _phoneNumberController,
                                  keyboardType: TextInputType.phone,
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
                                  child: const Text('Pay'),
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
