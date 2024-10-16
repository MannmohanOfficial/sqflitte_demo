import 'package:flutter/material.dart';
import 'package:sqflitte_demo/utils/appColors.dart';

class CustomButton extends StatefulWidget {
  final String btnText;
  final VoidCallback onTap;
  const CustomButton({super.key, required this.btnText, required this.onTap});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          widget.onTap();
        });
      },
      child: SizedBox(
        height: 54.0,
        width: double.infinity,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: TodoColor.buttonColor,
            borderRadius: BorderRadius.circular(48),
          ),
          child: Center(
            child: Text(
              widget.btnText,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
