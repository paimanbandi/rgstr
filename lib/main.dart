import 'package:flutter/material.dart';
import 'package:rgstr/global.dart';
import 'package:rgstr/registrations/registration_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RegistrationPage(title: 'Registration'),
    );
  }
}
