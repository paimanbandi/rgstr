import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rgstr/registration_controller.dart';
import 'package:rgstr/registration_page.dart';

import 'global.dart';

class RegistrationView extends WidgetView<RegistrationPage, RegistrationController> {
  RegistrationController state;

  RegistrationView(this.state) : super(state);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.normal);
    bool _bErrImei = false;
    bool _bErrFirstName = false;
    bool _bErrLastName = false;
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(30),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        'IMEI',
                        style: textStyle,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(17),
                        ],
                        initialValue: state.sPlatformImei,
                        decoration: InputDecoration(
                          errorText: _bErrImei ? "Can't be empty" : null,
                        ),
                        style: textStyle,
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        'First Name',
                        style: textStyle,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(50),
                        ],
                        decoration: InputDecoration(
                          errorText: _bErrFirstName ? "Can't be empty" : null,
                        ),
                        style: textStyle,
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Last Name',
                        style: textStyle,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(50),
                        ],
                        decoration: InputDecoration(
                          errorText: _bErrLastName ? "Can't be empty" : null,
                        ),
                        style: textStyle,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
