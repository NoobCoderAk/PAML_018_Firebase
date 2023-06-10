// ignore_for_file: avoid_print

import 'package:app_contact/controller/auth_controller.dart';
import 'package:app_contact/model/usermdl.dart';
import 'package:app_contact/view/contact.dart';
import 'package:app_contact/view/register.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final form = GlobalKey<FormState>();
  final authCt = AuthController();

  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: form,
            child: Column(
              children: [
                const Text(
                  'Login',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  decoration: const InputDecoration(hintText: 'Email'),
                  onChanged: (value) {
                    setState(() {
                      email = value;
                    });
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(hintText: 'Password'),
                  onChanged: (value) {
                    password = value;
                  },
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (form.currentState!.validate()) {
                      UserModel? registeredUser =
                          await authCt.signInWithEmailAndPassword(
                        email!,
                        password!,
                      );
                      if (registeredUser != null) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Login Successful'),
                              content: const Text(
                                  'You have been successfully Login'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    print(registeredUser.name);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: ((context) => const Contact()),
                                      ),
                                    );
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    }
                  },
                  child: const Text('Login'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => const Register()),
                      ),
                    );
                  },
                  child: Text('register akun'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
