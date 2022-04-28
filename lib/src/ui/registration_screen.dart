// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:movies_app/src/service/authentication_service.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatelessWidget {
  static const routeName = '/sign-up';
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repeatPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Sign up")),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: "Email"),
              ),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(labelText: "Password"),
                obscureText: true,
              ),
              TextField(
                controller: repeatPasswordController,
                decoration: InputDecoration(labelText: "Repeat password"),
                obscureText: true,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (!isEmail(emailController.text.trim())) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red[600],
                        content: Text("Enter correct email address",
                            style:
                                Theme.of(context).textTheme.caption?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'muli',
                                    ),
                            textAlign: TextAlign.center),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  } else {
                    if (passwordController.text ==
                        repeatPasswordController.text) {
                      await context.read<AuthenticationService>().signUp(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim());

                      await context.read<AuthenticationService>().signIn(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim());
                      Navigator.of(context).pushReplacementNamed('/');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.green[600],
                          content: Text("You've been signed up!",
                              style:
                                  Theme.of(context).textTheme.caption?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'muli',
                                      ),
                              textAlign: TextAlign.center),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red[600],
                          content: Text("Passwords don't match",
                              style:
                                  Theme.of(context).textTheme.caption?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'muli',
                                      ),
                              textAlign: TextAlign.center),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  }
                },
                child: Text("Sign in"),
              )
            ],
          ),
        ));
  }

  bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(p);
    return regExp.hasMatch(em);
  }
}
