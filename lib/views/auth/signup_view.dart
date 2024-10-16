import 'package:flutter/material.dart';
import 'package:sqflitte_demo/model/user.dart';
import 'package:sqflitte_demo/service/database-service.dart';
import 'package:sqflitte_demo/utils/appColors.dart';
import 'package:sqflitte_demo/utils/custom_button.dart';
import 'package:sqflitte_demo/views/auth/login_view.dart';
import 'package:sqflitte_demo/views/auth/widgets/auth_header.dart';
import 'package:sqflitte_demo/views/auth/widgets/input_field.dart';

import '../../utils/appImages.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _cnfPasswordController;

  final DBHelper _dbHelper = DBHelper();

  void registerUser() async {
    User user = User(
      username: _usernameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );
    var res = await _dbHelper.insertNewUser(user);
    print(res);
    if (res > 0) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const LoginView(),
        ),
      );
    }
  }

  @override
  void initState() {
    _usernameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _cnfPasswordController = TextEditingController();
    super.initState();
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
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const AuthHeader(header: "Sign Up"),
                        const SizedBox(height: 50),
                        InputField(
                          controller: _usernameController,
                          prefixIcon: TodoImages.userIcon,
                          hintText: "Enter your username",
                          labelText: "Username",
                        ),
                        const SizedBox(height: 32),
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
                          hintText: "Enter your Password",
                          labelText: "Password",
                          isPass: true,
                        ),
                        const SizedBox(height: 32),
                        InputField(
                          controller: _cnfPasswordController,
                          prefixIcon: TodoImages.passwordIcon,
                          hintText: "Confirm Password",
                          labelText: "Confirm Password",
                          isPass: true,
                        ),
                        const SizedBox(height: 53),
                        CustomButton(
                          btnText: "Sign Up",
                          onTap: () {
                            registerUser();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const LoginView()));
        },
        child: SizedBox(
          height: 50,
          child: Center(
            child: RichText(
              text: const TextSpan(
                  text: "Already have an account? ",
                  style:
                      TextStyle(fontSize: 16.0, color: TodoColor.buttonColor),
                  children: [
                    TextSpan(
                      text: "Sign In!",
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
