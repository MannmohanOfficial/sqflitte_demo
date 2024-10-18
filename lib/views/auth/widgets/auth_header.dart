import 'package:flutter/material.dart';
import 'package:sqflitte_demo/utils/appColors.dart';

class AuthHeader extends StatelessWidget {
  final String header;
  const AuthHeader({super.key, required this.header});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          header,
          style: const TextStyle(
            color: TodoColor.headerText,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8.0),
        const Text(
          "Welcome to ToDo app!",
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
