import 'package:flutter/material.dart';
import 'package:sqflitte_demo/main.dart';
import 'package:sqflitte_demo/model/todo.dart';
import 'package:sqflitte_demo/service/database-service.dart';
import 'package:sqflitte_demo/utils/appColors.dart';
import 'package:sqflitte_demo/utils/appImages.dart';
import 'package:sqflitte_demo/utils/pref_keys.dart';
import 'package:sqflitte_demo/views/edit_todo/edit_todo_view.dart';

import '../../utils/list_widget.dart';

class TodoView extends StatefulWidget {
  const TodoView({super.key});

  @override
  State<TodoView> createState() => _TodoViewState();
}

class _TodoViewState extends State<TodoView> {
  final DBHelper _dbHelper = DBHelper();
  List<ToDo> myTodo = [];

  void getTodoList() async {
    int? userId = prefs.getInt(PrefKeys.userId);
    myTodo = await _dbHelper.getTodos(userId!);
    setState(() {});
    print(myTodo.length);
  }

  @override
  void initState() {
    getTodoList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            child: Container(
              color: TodoColor.primary,
              padding: const EdgeInsets.symmetric(horizontal: 22.0),
              height: 76.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 24,
                    width: 24,
                    child: Image.asset(TodoImages.gridIcon),
                  ),
                  SizedBox(
                    height: 24,
                    child: Image.asset(TodoImages.logo),
                  ),
                  const CircleAvatar(
                    radius: 24,
                    backgroundImage: AssetImage(TodoImages.profile),
                    backgroundColor: Colors.white,
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "My Todo",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: TodoColor.headerText,
                  ),
                ),
                InkWell(
                  onTap: () {
                    getTodoList();
                  },
                  child: const Icon(
                    Icons.refresh,
                    color: TodoColor.buttonColor,
                  ),
                ),
              ],
            ),
          ),

          // Displaying the list or empty state
          const SizedBox(height: 25),
          Expanded(
            child: myTodo.isNotEmpty
                ? ListView.builder(
                    itemCount: myTodo.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  EditTodoView(toDoId: myTodo[index].id!),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 22.0),
                          child: Card(
                            elevation: 2,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            borderOnForeground: true,
                            child: SizedBox(
                              height: 175,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: TodoColor.buttonColor,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6.0, vertical: 12),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        myTodo[index].title,
                                        style: const TextStyle(
                                          color: TodoColor.headerText,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 18.0),
                                      Flexible(
                                        child: Text(
                                          myTodo[index].description,
                                          style: const TextStyle(
                                            color: TodoColor.descColor,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 23.0),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                                text: "Priority: ",
                                                style: const TextStyle(
                                                  color: TodoColor.statusColor,
                                                  fontSize: 13,
                                                ),
                                                children: [
                                                  TextSpan(
                                                    text: myTodo[index]
                                                                .priority ==
                                                            1
                                                        ? "LOW"
                                                        : myTodo[index]
                                                                    .priority ==
                                                                2
                                                            ? "MEDIUM"
                                                            : "HIGH",
                                                    style: const TextStyle(
                                                      color:
                                                          TodoColor.headerText,
                                                      fontSize: 13,
                                                    ),
                                                  )
                                                ]),
                                          ),
                                          RichText(
                                            text: TextSpan(
                                                text: "Status: ",
                                                style: const TextStyle(
                                                  color: TodoColor.statusColor,
                                                  fontSize: 13,
                                                ),
                                                children: [
                                                  TextSpan(
                                                    text: myTodo[index]
                                                                    .isCompleted ==
                                                                0 ||
                                                            myTodo[index]
                                                                    .isCompleted ==
                                                                null
                                                        ? "ToDo"
                                                        : myTodo[index]
                                                                    .isCompleted ==
                                                                1
                                                            ? "InProgress"
                                                            : "Completed",
                                                    style: const TextStyle(
                                                      color:
                                                          TodoColor.headerText,
                                                      fontSize: 13,
                                                    ),
                                                  )
                                                ]),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 54,
                          width: 56,
                          child: Image.asset(TodoImages.emptyIcon),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "No Items",
                          style: TextStyle(
                              fontSize: 13, color: TodoColor.headerText),
                        )
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
