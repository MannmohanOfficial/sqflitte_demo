import 'package:flutter/material.dart';
import 'package:sqflitte_demo/main.dart';
import 'package:sqflitte_demo/utils/appColors.dart';
import 'package:sqflitte_demo/utils/pref_keys.dart';
import 'package:sqflitte_demo/views/dashboard/add_task_view.dart';
import 'package:sqflitte_demo/views/dashboard/complete_view.dart';
import 'package:sqflitte_demo/views/dashboard/inprogress_view.dart';
import 'package:sqflitte_demo/views/dashboard/profile_view.dart';
import 'package:sqflitte_demo/views/dashboard/todo_view.dart';

import '../auth/login_view.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    const TodoView(),
    const InprogressView(),
    const CompleteView(),
    const ProfileView(),
    const AddTaskView(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _currentIndex == 3
          ? GestureDetector(
              onTap: () {
                prefs.setBool(PrefKeys.isLoggedIn, false);
                prefs.remove(PrefKeys.userId);
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const LoginView()));
              },
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [Icon(Icons.logout), Text("logout")],
              ),
            )
          : _currentIndex == 4
              ? FloatingActionButton(
                  onPressed: () {},
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                )
              : FloatingActionButton(
                  shape: const CircleBorder(),
                  backgroundColor: TodoColor.buttonColor,
                  onPressed: () {
                    setState(() {
                      _currentIndex = 4;
                    });
                  },
                  child: const Icon(
                    Icons.add_rounded,
                    color: Colors.white,
                    size: 45,
                  ),
                ),
      bottomNavigationBar: BottomAppBar(
        color: TodoColor.buttonColor,
        shape: const CircularNotchedRectangle(),
        notchMargin: 15,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.favorite_outline_rounded,
                color: Colors.white,
                size: 24,
              ),
              onPressed: () {
                setState(() {
                  _currentIndex = 0;
                });
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.bookmark_border_rounded,
                color: Colors.white,
                size: 24,
              ),
              onPressed: () {
                setState(() {
                  _currentIndex = 1;
                });
              },
            ),
            const SizedBox(width: 40), // Add space for the floating button
            IconButton(
              icon: const Icon(
                Icons.settings_outlined,
                color: Colors.white,
                size: 24,
              ),
              onPressed: () {
                setState(() {
                  _currentIndex = 2;
                });
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.person_outline,
                color: Colors.white,
                size: 24,
              ),
              onPressed: () {
                setState(() {
                  _currentIndex = 3;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
