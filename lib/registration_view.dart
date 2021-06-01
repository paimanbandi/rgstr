import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rgstr/global.dart';
import 'package:rgstr/registration_controller.dart';
import 'package:rgstr/registration_page.dart';
import 'package:rgstr/validations.dart';
import 'package:rgstr/utils.dart';

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
    bool _bErrPassport = false;
    bool _bErrEmail = false;

    String _sErrImei = "";
    String _sErrFirstName = "";
    String _sErrLastName = "";
    String _sErrPassport = "";

    return StatefulBuilder(builder: (context, pSetState) {
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
                                'IMEI *',
                                style: textStyle,
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: TextFormField(
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(17),
                                ],
                                controller: state.tecImei,
                                onChanged: (value) {
                                  if (value.isEmpty) {
                                    _bErrImei = true;
                                  } else {
                                    _bErrImei = false;
                                  }

                                  if (!isImeiValid(value) || value.length < 15) {
                                    _sErrImei = "Not valid IMEI";
                                  } else {
                                    _sErrImei = "";
                                  }

                                  pSetState(() {});
                                },
                                decoration: InputDecoration(
                                  hintText: 'IMEI on your phone',
                                  errorText: _bErrImei
                                      ? "Can't be empty"
                                      : _sErrImei != ""
                                          ? _sErrImei
                                          : null,
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
                                'First Name *',
                                style: textStyle,
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: TextFormField(
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(50),
                                ],
                                controller: state.tecFirstName,
                                onChanged: (value) {
                                  if (value.isEmpty) {
                                    _bErrFirstName = true;
                                  } else {
                                    _bErrFirstName = false;
                                  }

                                  if (!isNameValid(value)) {
                                    _sErrFirstName = 'Not valid name';
                                  } else {
                                    _sErrFirstName = "";
                                  }
                                  pSetState(() {});
                                },
                                decoration: InputDecoration(
                                  hintText: 'Your first name',
                                  errorText: _bErrFirstName
                                      ? "Can't be empty"
                                      : _sErrFirstName != ""
                                          ? _sErrFirstName
                                          : null,
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
                                'Last Name *',
                                style: textStyle,
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: TextFormField(
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(50),
                                ],
                                controller: state.tecLastName,
                                onChanged: (value) {
                                  if (value.isEmpty) {
                                    _bErrLastName = true;
                                  } else {
                                    _bErrLastName = false;
                                  }

                                  if (!isNameValid(value)) {
                                    _sErrLastName = 'Not valid name';
                                  } else {
                                    _sErrLastName = "";
                                  }

                                  pSetState(() {});
                                },
                                decoration: InputDecoration(
                                  hintText: 'Your last name',
                                  errorText: _bErrLastName
                                      ? "Can't be empty"
                                      : _sErrLastName != ""
                                          ? _sErrLastName
                                          : null,
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
                                'DoB *',
                                style: textStyle,
                              ),
                            ),
                            Expanded(
                                flex: 3,
                                child: GestureDetector(
                                  onTap: () => state.selectDate(context),
                                  child: AbsorbPointer(
                                    child: TextFormField(
                                      controller: state.tecDob,
                                      onChanged: (value) {
                                        if (value.isEmpty) {
                                          _bErrDob = true;
                                        } else {
                                          _bErrDob = false;
                                        }
                                        pSetState(() {});
                                      },
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
                        state.age >= 18
                            ? Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      'Passport *',
                                      style: textStyle,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: TextFormField(
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(20),
                                      ],
                                      controller: state.tecPassport,
                                      onChanged: (value) {
                                        if (value == "") {
                                          _bErrPassport = true;
                                        } else {
                                          _bErrPassport = false;
                                        }

                                        if (!isPassportValid(value)) {
                                          _sErrPassport = "Not valid passport";
                                        } else {
                                          _sErrPassport = "";
                                        }
                                        pSetState(() {});
                                      },
                                      decoration: InputDecoration(
                                        hintText: 'Your passport',
                                        errorText: _bErrPassport
                                            ? "Can't be empty"
                                            : _sErrPassport != ""
                                                ? _sErrPassport
                                                : null,
                                      ),
                                      style: textStyle,
                                    ),
                                  )
                                ],
                              )
                            : Container(),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                'Email',
                                style: textStyle,
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: TextFormField(
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(50),
                                ],
                                onChanged: (value) {
                                  print(value);
                                  if (!isEmailValid(value)) {
                                    _bErrEmail = true;
                                  }

                                  if (isEmailValid(value)) {
                                    _bErrEmail = false;
                                  }

                                  if (value.isEmpty) {
                                    _bErrEmail = false;
                                  }

                                  pSetState(() {});
                                },
                                decoration: InputDecoration(
                                  hintText: 'Your email',
                                  errorText: _bErrEmail ? "Not valid email" : null,
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
                                'Picture *',
                                style: textStyle,
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: TextButton(
                                  child: Row(
                                    children: [
                                      Icon(Icons.add_photo_alternate_outlined),
                                      SizedBox(width: 10),
                                      Text('Take a Picture'),
                                    ],
                                  ),
                                  onPressed: () async {
                                    final File result = await openCamOrDirDialog();
                                    if (result != null) state.setState(() => state.fPicture = result);
                                  }),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                      padding: MaterialStateProperty.all(EdgeInsets.all(15)),
                                      elevation: MaterialStateProperty.all(0),
                                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10))),
                                      backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                                        if (states.contains(MaterialState.disabled)) return disabledColor;
                                        return primaryColor;
                                      }),
                                      foregroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                                        if (states.contains(MaterialState.disabled)) return textColor;
                                        return whiteColor;
                                      }),
                                    ),
                                    onPressed: () => null,
                                    child: Text(
                                      'Submit',
                                    ))),
                            // ),
                          ],
                        ),
                      ],
                    ),
                  )
                ]),
              )));
    });
  }
}
