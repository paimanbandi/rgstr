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
    bool _bErrDob = false;
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          centerTitle: true,
        ),
        body: Padding(
            padding: EdgeInsets.all(30),
            child: Center(
              child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
                SingleChildScrollView(
                  child: Column(
                    children: [
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
                                hintText: 'IMEI on your phone',
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
                                hintText: 'Your first name',
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
                                hintText: 'Your last name',
                                errorText: _bErrLastName ? "Can't be empty" : null,
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
                              'DoB',
                              style: textStyle,
                            ),
                          ),
                          Expanded(
                              flex: 3,
                              child: GestureDetector(
                                onTap: () => state.selectDate(context),
                                child: AbsorbPointer(
                                  child: TextFormField(
                                    controller: state.date,
                                    keyboardType: TextInputType.datetime,
                                    decoration: InputDecoration(
                                      hintText: 'Date of Birth',
                                      errorText: _bErrDob ? "Can't be empty" : null,
                                      prefixIcon: Icon(
                                        Icons.calendar_today,
                                      ),
                                    ),
                                  ),
                                ),
                              ))
                        ],
                      ),
                    ],
                  ),
                )
              ]),
            )));
  }
}
