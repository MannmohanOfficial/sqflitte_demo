import 'package:flutter/material.dart';

import 'appColors.dart';

class ListWidget extends StatelessWidget {
  final String title, description;
  final int? priority, status;
  const ListWidget({
    super.key, required this.title, required this.description, this.priority, this.status,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 175,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                    color: TodoColor.buttonColor.withOpacity(.53)
                )
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: TodoColor.headerText,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),
                  Flexible(
                    child: Text(
                      description,
                      style: const TextStyle(
                        color: TodoColor.descColor,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Priority: $priority",
                        style: const TextStyle(
                          color: TodoColor.headerText,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Status: $status",
                        style: const TextStyle(
                          color: TodoColor.headerText,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}