import 'package:flutter/material.dart';

class ProviderWidget extends StatelessWidget {
  final String name;
  final String email;
  final String phone;
  final String address;
  final String municipality;
  final String speciality;
  final int providerId;

  const ProviderWidget({
    Key? key,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.municipality,
    required this.speciality,
    required this.providerId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue, width: 0.15),
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.white,
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey[200],
              radius: 25.0,
              child: const Padding(
                padding: EdgeInsets.all(6.0),
                child: Icon(
                  Icons.person,
                  size: 20.0,
                  color: Colors.blue,
                )
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    email,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    phone,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
