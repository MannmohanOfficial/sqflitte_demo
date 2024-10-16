import 'package:flutter/material.dart';
import 'package:sqflitte_demo/main.dart';
import 'package:sqflitte_demo/service/database-service.dart';
import 'package:sqflitte_demo/utils/appColors.dart';
import 'package:sqflitte_demo/utils/appImages.dart';
import 'package:sqflitte_demo/utils/pref_keys.dart';

import '../../model/user.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final DBHelper _dbHelper = DBHelper();
  String userName = "";

  void getUserInfo() async {
    var userId = prefs.getInt(PrefKeys.userId);
    User? info = await _dbHelper.getUserById(userId!);
    if (info != null) {
      setState(() {
        userName = info.username;
      });
    }
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),  // Border radius for bottom-left
              bottomRight: Radius.circular(30), // Border radius for bottom-right
            ),
            child: Container(
              height: 141.0,
              color: TodoColor.primary,
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 85,
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(TodoImages.logo), // Replace with your image
                  backgroundColor: Colors.white, // Border around image
                ),
                const SizedBox(height: 10),
                Text(
                  userName,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: TodoColor.buttonColor, // Dark maroon text
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
