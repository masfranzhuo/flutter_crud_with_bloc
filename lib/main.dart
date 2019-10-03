import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_crud/screens/users/users.dart';

void main() {
  SystemChrome.setEnabledSystemUIOverlays([]);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      theme: ThemeData(brightness: Brightness.dark),
      home: UsersScreen()
    );
  }
}
