import 'package:app/homePage.dart';
import 'package:flutter/material.dart';
import 'package:app/wheel.dart';
import 'package:app/profilePage.dart';

class SignInPage extends StatefulWidget {
  @override
  State<SignInPage> createState() => SignInPageState();

  const SignInPage({Key? key}) : super(key: key);
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
    super.initState();
    userName = TextEditingController();
    passWord = TextEditingController();
    inputModerator = '';
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeIn,
    );
    controller.repeat();
  }

  @override
  void dispose() {
    // Dispose controllers to avoid memory leaks
    userName.dispose();
    passWord.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Builder(builder: (ctx) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 80),
                    const Text(
                      "Welcome back.",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Sign in to continue",
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                    const SizedBox(height: 40),
                    TextFormField(
                      controller: userName,
                      decoration: const InputDecoration(
                        hintText: "Enter your username...",
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
                    const SizedBox(height: 20),
                    FormField<bool>(
                      initialValue: true,
                      builder: (state) {
                        return TextFormField(
                          controller: passWord,
                          obscureText: state.value!,
                          decoration: InputDecoration(
                            hintText: "Enter your passcode...",
                            fillColor: Colors.white,
                            filled: true,
                            border: const OutlineInputBorder(),
                            prefixIcon: const Icon(Icons.lock),
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
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            } else if (value.length < 8) {
                              return 'Password must be at least 8 characters';
                            } else {
                              return null;
                            }
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Sign In',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      inputModerator,
                      style: const TextStyle(color: Colors.red),
                    ),
                    const SizedBox(height: 90),
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
