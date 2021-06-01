import 'package:flutter/material.dart';
import 'package:rgstr/registrations/registration_controller.dart';

class RegistrationPage extends StatefulWidget {
  final String title;

  RegistrationPage({this.title});

  @override
  RegistrationController createState() => RegistrationController();
}
