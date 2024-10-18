import 'package:flutter/material.dart';

import '../../../utils/appColors.dart';

class CustomInputField extends StatelessWidget {
  final String labelText, hintText;
  final TextEditingController controller;
  const CustomInputField(
      {super.key,
      required this.labelText,
      required this.hintText,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: TodoColor.headerText.withOpacity(.53)),
        ),
        const SizedBox(height: 13),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: const BorderSide(
                color: TodoColor.buttonColor,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: TodoColor.buttonColor,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: TodoColor.buttonColor,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            hintText: hintText,
          ),
        )
      ],
    );
  }
}
