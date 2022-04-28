// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/src/service/authentication_service.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/log-in';
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Log in")),
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
              ElevatedButton(
                onPressed: () async {
                  await context.read<AuthenticationService>().signIn(
                      email: emailController.text.trim(),
                      password: passwordController.text.trim());
                  if (FirebaseAuth.instance.currentUser != null) {
                    Navigator.of(context).pushReplacementNamed('/');
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red[600],
                        content: Text("Incorrect email or password!",
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
                },
                child: Text("Sign in"),
              )
            ],
          ),
        ));
  }
}
