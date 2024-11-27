import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:app/main.dart';

class SignInPage extends StatefulWidget {
  @override
  State<SignInPage> createState() => SignInPageState();
 
  SignInPage({Key? key}) : super(key: key);
}

class SignInPageState extends State<SignInPage> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController userName;
  late TextEditingController passWord;
  late String inputModerator;
  late AnimationController controller;
  late Animation<double> animation;

  bool isObscure = true;

  @override
  initState() {
    userName = TextEditingController();
    passWord = TextEditingController();
    inputModerator = '';
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeIn,
    );
    controller.repeat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/background.png"),
                  fit: BoxFit.cover),
            ),
            child: SingleChildScrollView(
                child: Container(
                    padding: EdgeInsets.all(20),
                    child: Form(
                        key: _formKey,
                        child: Builder(builder: (ctx) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 80),
                              Text(
                                //Welcome letter to be friendly to returning students.
                                "Welcome back.",
                                style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              SizedBox(height: 10),
                              Text(
                                //Creating text box for Sign In. Various widget created to make the page user friendly.
                                "Sign in to continue",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black),
                              ),
                              SizedBox(height: 40),
                              TextFormField(
                                controller: userName,
                                decoration: InputDecoration(
                                  hintText: "Enter your username. . .",
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(),
                                  prefixIcon: Icon(Icons.person),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your username';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              SizedBox(
                                  height: 20), //Creating text box for password.
                              FormField<bool>(
                                initialValue: true,
                                builder: (state) {
                                  return TextFormField(
                                    controller: passWord,
                                    obscureText: state.value!,
                                    decoration: InputDecoration(
                                      hintText: "Enter your passcode. . .",
                                      fillColor: Colors.white,
                                      filled: true,
                                      border: OutlineInputBorder(),
                                      prefixIcon: Icon(Icons.lock),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          state.value!
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                          color: Colors.grey,
                                        ),
                                        onPressed: () {
                                          state.didChange(!state.value!);
                                        },
                                      ),
                                    ),
                                    validator: (value) {
                                      //Validating if the passcode match one in the server
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your password';
                                      } else if (value.length < 8) {
                                        return 'Password must be at least 8 characters';
                                      } else {
                                        return null;
                                      }
                                    },
                                  );
                                }, //
                              ),
                              SizedBox(height: 40),
                              
                              SizedBox(height: 10),
                              Text(
                                inputModerator,
                                style: TextStyle(color: Colors.red),
                              ),
                              SizedBox(
                                height: 90,
                              ),
                              
                            ],
                          );
                        }))))));
  }

  
}
