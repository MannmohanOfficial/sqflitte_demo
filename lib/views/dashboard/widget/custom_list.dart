import 'package:flutter/material.dart';

import '../../../utils/appColors.dart';

class CustomList extends StatelessWidget {
  final String title;
  final bool tapped;
  const CustomList({super.key, required this.title, required this.tapped});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 24,
              width: 24,
              child: tapped ? const Icon(Icons.check_circle, color: TodoColor.buttonColor,) : const Icon(Icons.circle_outlined, color: TodoColor.buttonColor,),
            ),
            const SizedBox(width: 20),
            Text(title),
          ],
        ),
      ),
    );
  }
}
