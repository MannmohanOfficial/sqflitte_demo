import 'package:flutter/material.dart';
import 'package:sqflitte_demo/main.dart';
import 'package:sqflitte_demo/utils/pref_keys.dart';
import 'package:sqflitte_demo/views/auth/login_view.dart';
import 'package:sqflitte_demo/views/dashboard/dashboard_view.dart';

import '../../utils/appColors.dart';
import '../../utils/appImages.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 3),
      () => handleNavigation(),
    );
    super.initState();
  }

  void handleNavigation() async {
    final bool? isLoggedIn = prefs.getBool(PrefKeys.isLoggedIn);
    if (isLoggedIn == true) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const DashboardView()));
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LoginView()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TodoColor.primary,
      body: Center(
        child: Image.asset(TodoImages.logo),
      ),
    );
  }
}
