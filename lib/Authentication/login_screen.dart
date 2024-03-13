import 'package:flutter/material.dart';
import 'package:user_login_sqflite/Authentication/signup.dart';
import 'package:user_login_sqflite/JasonModels/user_data.dart';
import 'package:user_login_sqflite/Route/home_page.dart';
import 'package:user_login_sqflite/SQLite/database_helper.dart';

class LoginPageScreen extends StatefulWidget {
  const LoginPageScreen({super.key});

  @override
  State<LoginPageScreen> createState() => _LoginPageScreenState();
}

class _LoginPageScreenState extends State<LoginPageScreen> {
  final username = TextEditingController();
  final password = TextEditingController();
  bool isVisible = false;
  bool isLoginTrue = false;
  final db = DatabaseHelper();
  late String title;

  //login callback function
  login() async {
    var response = await db
        .login(Users(usrName: username.text, usrPassword: password.text));
    if (response == true) {
      if (!mounted) return;
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => HomePage(title: '')));
    } else {
      setState(() {
        isLoginTrue = true;
      });
    }
  }

  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          Image.asset(
                            'lib/assets/login.png',
                            width: 210,
                          ),
                          const SizedBox(height: 15),
                          Container(
                            margin: const EdgeInsets.all(8),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.deepPurple.withOpacity(0.2)),
                            child: TextFormField(
                              controller: username,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "username is required";
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                icon: Icon(Icons.person),
                                border: InputBorder.none,
                                hintText: 'Username',
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(8),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.deepPurple.withOpacity(0.2)),
                            child: TextFormField(
                              controller: password,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'password is required';
                                }
                                return null;
                              },
                              obscureText: !isVisible,
                              decoration: InputDecoration(
                                  icon: const Icon(Icons.lock),
                                  border: InputBorder.none,
                                  hintText: 'Password',
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          //toggle button
                                          isVisible = !isVisible;
                                        });
                                      },
                                      icon: Icon(isVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off))),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            height: 55,
                            width: MediaQuery.of(context).size.width * 0.9,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.deepPurple.withOpacity(0.5),
                            ),
                            child: TextButton(
                                onPressed: () {
                                  if (_formkey.currentState!.validate()) {
                                    login();
                                  }
                                },
                                child: const Text(
                                  "LOGIN",
                                  style: TextStyle(color: Colors.white),
                                )),
                          ),
                          //sign up button
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Don't have an account?"),
                              TextButton(
                                onPressed: () {
                                  //Navigate to sign up
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) =>
                                              const SignUp())));
                                },
                                child: const Text('SIGN UP'),
                              )
                            ],
                          ),
                          isLoginTrue
                              ? const Text(
                                  "Username and password is incorrect",
                                  style: TextStyle(color: Colors.red),
                                )
                              : const SizedBox(),
                        ],
                      ))))),
    );
  }
}
