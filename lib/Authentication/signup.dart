import 'package:flutter/material.dart';
import 'package:user_login_sqflite/Authentication/login_screen.dart';
import 'package:user_login_sqflite/JasonModels/user_data.dart';
import 'package:user_login_sqflite/SQLite/database_helper.dart';


class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isvisibility = false;
  final username = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text('Registration Page'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
              key: _formkey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const ListTile(
                      title: Text(
                        "Register New Account",
                        style: TextStyle(
                            fontSize: 50, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.deepPurple.withOpacity(0.2),
                      ),
                      child: TextFormField(
                        controller: username,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "username is required";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          icon: Icon(Icons.person),
                          hintText: 'Username',
                        ),
                      ),
                    ),
                    
                    Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.deepPurple.withOpacity(0.2),
                      ),
                      child: TextFormField(
                        controller: password,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "password is required";
                          }
                          return null;
                        },
                        obscureText: !isvisibility,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: const Icon(Icons.lock),
                            hintText: 'Password',
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isvisibility = !isvisibility;
                                  });
                                },
                                icon: Icon(isvisibility
                                    ? Icons.visibility
                                    : Icons.visibility_off))),
                      ),
                    ),
                    
                    Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.deepPurple.withOpacity(0.2),
                      ),
                      child: TextFormField(
                        controller: confirmPassword,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "password is required";
                          } else if (password.text != confirmPassword.text) {
                            return "Password does not match";
                          }
                          return null;
                        },
                        obscureText: !isvisibility,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: const Icon(Icons.lock),
                            hintText: 'Confirmed password',
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isvisibility = !isvisibility;
                                  });
                                },
                                icon: Icon(isvisibility
                                    ? Icons.visibility
                                    : Icons.visibility_off))),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: 55,
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.deepPurple.withOpacity(0.5),
                      ),
                      child: TextButton(
                          onPressed: () {
                            if (_formkey.currentState!.validate()) {
                              final db = DatabaseHelper();
                              db
                                  .signup(Users(
                                      usrName: username.text,
                                      usrPassword: password.text))
                                  .whenComplete(() => Navigator.push(
                                    context, 
                                    MaterialPageRoute(builder:(context) => const LoginPageScreen())
                                  ));
                            }
                          },
                          child: const Text(
                            "SIGN UP",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                          )),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // const Padding(
                        //   padding: EdgeInsets.all(4.0),
                        //   child: Text("Already have an account."),
                        // ),
                        const Text("Already have and account."),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginPageScreen()));
                            },
                            child: const Text("Login"))
                      ],
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
