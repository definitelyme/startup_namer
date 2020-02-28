import 'package:flutter/material.dart';
import 'package:startup_namer/screens/Home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Application',
      debugShowCheckedModeBanner: false,
      theme:
          ThemeData(primarySwatch: Colors.deepOrange, splashColor: Colors.grey),
      home: Home(title: 'Startup Namer'),
    );
  }
}