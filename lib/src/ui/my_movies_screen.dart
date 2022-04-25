import 'package:flutter/material.dart';
import 'package:movies_app/src/ui/app_drawer.dart';
import 'package:provider/provider.dart';

class MyMoviesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My movie list')),
      drawer: AppDrawer(),
      body: Container(),
      // body: ListView.builder(
      //     itemCount: orderData.orders.length,
      //     itemBuilder: (ctx, i) => OrderItem(orderData.orders[i])),
    );
  }
}
