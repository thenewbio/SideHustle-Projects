import 'package:flutter/material.dart';
import '../dashboard_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme:
            ThemeData(primarySwatch: Colors.purple, accentColor: Colors.orange),
        title: 'Flutter Demo',
        home: DashboardScreen());
  }
}
