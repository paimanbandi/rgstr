import 'package:flutter/material.dart';
import 'package:rgstr/registration_controller.dart';
import 'package:rgstr/registration_page.dart';

import 'global.dart';

class RegistrationView extends WidgetView<RegistrationPage, RegistrationController> {
  RegistrationController state;

  RegistrationView(this.state) : super(state);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[],
        ),
      ),
    );
  }
}
