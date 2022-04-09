import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Icon(Icons.menu, color: Colors.black45),
        title: Text(
          'Movies Web'.toUpperCase(),
          style: Theme.of(context).textTheme.caption?.copyWith(
              color: Colors.black45, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: CircleAvatar(),
          )
        ],
      ),
    );
  }
}
