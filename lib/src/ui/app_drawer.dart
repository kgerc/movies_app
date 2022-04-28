import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/src/service/authentication_service.dart';
import 'package:movies_app/src/ui/login_screen.dart';
import 'package:movies_app/src/ui/my_movies_screen.dart';
import 'package:movies_app/src/ui/registration_screen.dart';
import 'package:provider/provider.dart';

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
          FirebaseAuth.instance.currentUser?.uid != null
              ? ListTile(
                  leading: Icon(Icons.movie),
                  title: Text("My movies"),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyMoviesScreen(),
                        ));
                  },
                )
              : SizedBox.shrink(),
          FirebaseAuth.instance.currentUser?.uid == null
              ? ListTile(
                  leading: Icon(Icons.login),
                  title: Text("Log in"),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ));
                  },
                )
              : SizedBox.shrink(),
          FirebaseAuth.instance.currentUser?.uid == null
              ? ListTile(
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
              : SizedBox.shrink(),
          FirebaseAuth.instance.currentUser?.uid != null
              ? ListTile(
                  leading: Icon(Icons.logout),
                  title: Text("Log out"),
                  onTap: () {
                    context.read<AuthenticationService>().signOut();
                    Navigator.of(context).pushReplacementNamed('/');
                  })
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}
