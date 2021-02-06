import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xFFEDD5D0),
      body: Container(
        // color: Color(0xFFEDD5D0),
        child: Center(
          child: Text("Home Pages"),
        ),
      ),
    );
  }
}
