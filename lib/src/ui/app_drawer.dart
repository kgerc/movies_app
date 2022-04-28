import 'package:flutter/material.dart';
import 'package:movies_app/src/ui/login_screen.dart';
import 'package:movies_app/src/ui/my_movies_screen.dart';
import 'package:movies_app/src/ui/registration_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DrawerContent();
  }
}

class DrawerContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text("Hello!"),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Home screen"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          ListTile(
            leading: Icon(Icons.movie),
            title: Text("My movies"),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyMoviesScreen(),
                  ));
            },
          ),
          ListTile(
            leading: Icon(Icons.login),
            title: Text("Log in"),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ));
            },
          ),
          ListTile(
            leading: Icon(Icons.person_add),
            title: Text("Sign up"),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegistrationScreen(),
                  ));
            },
          )
        ],
      ),
    );
  }
}
