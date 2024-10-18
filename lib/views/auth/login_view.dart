import 'package:flutter/material.dart';
import 'package:sqflitte_demo/main.dart';
import 'package:sqflitte_demo/service/database-service.dart';
import 'package:sqflitte_demo/utils/custom_button.dart';
import 'package:sqflitte_demo/utils/pref_keys.dart';
import 'package:sqflitte_demo/views/auth/signup_view.dart';
import 'package:sqflitte_demo/views/auth/widgets/auth_header.dart';
import 'package:sqflitte_demo/views/auth/widgets/input_field.dart';
import 'package:sqflitte_demo/views/dashboard/dashboard_view.dart';

import '../../utils/appColors.dart';
import '../../utils/appImages.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  final DBHelper _dbHelper = DBHelper();

  void loginUser() async {

    var response = await _dbHelper.validateUser(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );
   if (response != null) {
     prefs.setBool(PrefKeys.isLoggedIn, true);
     prefs.setInt(PrefKeys.userId, response.id!);
     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const DashboardView()));
   } else {
     ScaffoldMessenger.of(context).showSnackBar(
       const SnackBar(content: Text("Invalid User"))
     );
   }


  }

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TodoColor.primary,
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 24.0,
                width: 95.0,
                child: Image.asset(TodoImages.logo),
              ),
              const SizedBox(height: 50.0),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.only(top: 50.0, left: 25.0, right: 25.0),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24.0),
                      topRight: Radius.circular(24.0),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const AuthHeader(header: "Sign In"),
                      const SizedBox(height: 50),
                      InputField(
                        controller: _emailController,
                        prefixIcon: TodoImages.emailIcon,
                        hintText: "Enter your Email",
                        labelText: "Email",
                      ),
                      const SizedBox(height: 32),
                      InputField(
                        controller: _passwordController,
                        prefixIcon: TodoImages.passwordIcon,
                        hintText: "Enter your password",
                        labelText: "Password",
                        isPass: true,
                      ),
                      const SizedBox(height: 53),
                      CustomButton(
                        btnText: "Login",
                        onTap: () {
                          loginUser();
                        },
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const SignupView()));
        },
        child: SizedBox(
          height: 50,
          child: Center(
            child: RichText(
              text: const TextSpan(
                  text: "Don't have an account? ",
                  style:
                      TextStyle(fontSize: 16.0, color: TodoColor.buttonColor),
                  children: [
                    TextSpan(
                      text: "Sign Up!",
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: TodoColor.buttonColor),
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
