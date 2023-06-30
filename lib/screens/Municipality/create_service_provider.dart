import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class CreateServiceProviderPage extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _specialityController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  CreateServiceProviderPage({super.key});

  void _create(BuildContext context) async {
    String name = _nameController.text;
    String email = _emailController.text;
    String phoneNumber = _phoneNumberController.text;
    String address = _addressController.text;
    String speciality = _addressController.text;
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
