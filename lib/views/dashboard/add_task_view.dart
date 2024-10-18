import 'package:flutter/material.dart';
import 'package:sqflitte_demo/main.dart';
import 'package:sqflitte_demo/model/todo.dart';
import 'package:sqflitte_demo/service/database-service.dart';
import 'package:sqflitte_demo/utils/custom_button.dart';
import 'package:sqflitte_demo/utils/pref_keys.dart';
import 'package:sqflitte_demo/views/dashboard/dashboard_view.dart';
import 'package:sqflitte_demo/views/dashboard/widget/custom_input_field.dart';

import '../../utils/appColors.dart';
import '../../utils/appImages.dart';

class AddTaskView extends StatefulWidget {
  const AddTaskView({super.key});

  @override
  State<AddTaskView> createState() => _AddTaskViewState();
}

class _AddTaskViewState extends State<AddTaskView> {
  final DBHelper _dbHelper = DBHelper();
  late TextEditingController _titleController;
  late TextEditingController _descController;
  int? _selectedValue;

  final Map<String, int> dropdownItems = {
    'Low': 1,
    'Medium': 2,
    'High': 3,
  };

  void addTask() async {
    int? userId = prefs.getInt(PrefKeys.userId);
    if (_titleController.text.isNotEmpty &&
        _descController.text.isNotEmpty &&
        _descController.text.length > 2) {
      ToDo newTask = ToDo(
          userId: userId!,
          title: _titleController.text.trim(),
          description: _descController.text,
          isCompleted: 0,
          priority: _selectedValue!,
      );
      var response = await _dbHelper.insertTodo(newTask);

      if (response > 0) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const DashboardView()));
      }
    }
  }

  @override
  void initState() {
    _titleController = TextEditingController();
    _descController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30), // Border radius for bottom-left
              bottomRight:
                  Radius.circular(30), // Border radius for bottom-right
            ),
            child: Container(
              color: TodoColor.primary,
              padding: const EdgeInsets.symmetric(horizontal: 22.0),
              height: 76.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) => const DashboardView())),
                    child: SizedBox(
                      height: 44,
                      width: 44,
                      child: Image.asset(TodoImages.backIcon),
                    ),
                  ),
                  SizedBox(
                    height: 24,
                    child: Image.asset(TodoImages.logo),
                  ),
                  const CircleAvatar(
                    radius: 24,
                    backgroundImage: AssetImage(
                        TodoImages.profile), // Replace with your image
                    backgroundColor: Colors.white, // Border around image
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomInputField(
                    labelText: "Title",
                    hintText: "Add task title",
                    controller: _titleController),
                const SizedBox(height: 23),
                CustomInputField(
                    labelText: "Description",
                    hintText: "Add description",
                    controller: _descController),
                const SizedBox(height: 23),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Priority",
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: TodoColor.headerText.withOpacity(.53)),
                    ),
                    const SizedBox(height: 13),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: TodoColor.buttonColor,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<int>(
                          value: _selectedValue,
                          isExpanded: true,
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.deepPurple,
                          ),
                          items: dropdownItems.entries.map((entry) {
                            return DropdownMenuItem<int>(
                              value: entry.value,
                              child: Text(
                                entry.key,
                                style: TextStyle(
                                  color: Colors.grey[700],
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (int? newValue) {
                            setState(() {
                              _selectedValue = newValue;
                            });
                            print("Selected value: $_selectedValue");
                          },
                          hint: Text(
                            'Select Priority',
                            style: TextStyle(
                              color: Colors.grey[500],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 48),
                CustomButton(
                  btnText: "Add Task",
                  onTap: () {
                    addTask();
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
