import 'package:flutter/material.dart';
import '../../../utils/appColors.dart';

class InputField extends StatefulWidget {
  final String labelText, hintText, prefixIcon;
  final bool isPass;
  final TextEditingController controller;
  const InputField({
    super.key, required this.labelText, required this.hintText, this.isPass = false, required this.controller, required this.prefixIcon,
  });

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool canView = false;
  
  void setVisibility() {
    if (canView) {
      setState(() {
        canView = false;
      });
    } else {
      setState(() {
        canView = true;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelText,
          style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: TodoColor.headerText.withOpacity(.53)),
        ),
        const SizedBox(height: 13),
        !widget.isPass ?
        TextFormField(
          controller: widget.controller,
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
            prefixIcon: Padding(
              padding: const EdgeInsets.all(8),
              child: ImageIcon(
                AssetImage(widget.prefixIcon),
                color: TodoColor.buttonColor,// Set color if needed
              ),
            ),
            hintText: widget.hintText,
          ),
        ) :
        TextFormField(
          controller: widget.controller,
          obscureText: canView ? true : false,
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
            prefixIcon: Padding(
              padding: const EdgeInsets.all(8),
              child: ImageIcon(
                AssetImage(widget.prefixIcon),
                color: TodoColor.buttonColor,// Set color if needed
              ),
            ),
            suffixIcon: InkWell(
              onTap: () {
                setState(() {
                  setVisibility();
                });
              },
                child: Icon(canView ? Icons.visibility_outlined : Icons.visibility_off_outlined, color: TodoColor.buttonColor)),
            hintText: widget.hintText,
          ),
        )
      ],
    );
  }
}