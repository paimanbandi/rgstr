import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rgstr/global.dart';
import 'package:rgstr/registrations/registration_controller.dart';
import 'package:rgstr/registrations/registration_dao.dart';
import 'package:rgstr/registrations/registration_model.dart';
import 'package:rgstr/registrations/registration_page.dart';
import 'package:rgstr/registrations/registration_validations.dart';
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
                  Expanded(
                      child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                'IMEI *',
                                style: textStyle,
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
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
                              flex: 2,
                              child: Text(
                                'First Name *',
                                style: textStyle,
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: TextFormField(
                                keyboardType: TextInputType.name,
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
                              flex: 2,
                              child: Text(
                                'Last Name *',
                                style: textStyle,
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: TextFormField(
                                keyboardType: TextInputType.name,
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
                              flex: 2,
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
                                      keyboardType: TextInputType.datetime,
                                      controller: state.tecDob,
                                      onChanged: (value) {
                                        if (value.isEmpty) {
                                          _bErrDob = true;
                                        } else {
                                          _bErrDob = false;
                                        }
                                        pSetState(() {});
                                      },
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
                                    flex: 2,
                                    child: Text(
                                      'Passport *',
                                      style: textStyle,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: TextFormField(
                                      keyboardType: TextInputType.text,
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
                              flex: 2,
                              child: Text(
                                'Email',
                                style: textStyle,
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: TextFormField(
                                keyboardType: TextInputType.emailAddress,
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
                              flex: 2,
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
                                    if (result != null) {
                                      state.setState(() {
                                        state.fPicture = result;
                                        state.sPicture = result.path;
                                      });
                                      pSetState(() {});
                                    }
                                  }),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                state.sPicture,
                                style: textStyle,
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                  margin: EdgeInsets.only(top: 20),
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
                                          if (states.contains(MaterialState.disabled)) return blackColor;
                                          return whiteColor;
                                        }),
                                      ),
                                      onPressed: () async {
                                        // showOverlay();
                                        print("submit");
                                        Registration registration = Registration(
                                            imei: state.tecImei.text,
                                            firstName: state.tecFirstName.text,
                                            lastName: state.tecLastName.text,
                                            dob: state.tecDob.text,
                                            passport: state.tecPassport.text,
                                            email: state.tecEmail.text,
                                            picture: state.sPicture,
                                            osName: Platform.isAndroid ? "Android" : "iOS",
                                            osVersion: state.sOSVersion);

                                        int res = await RegistrationDao().register(registration); //await state.register(registration);
                                        print("res nya " + res.toString());
                                        if (res > 0) {
                                          ScaffoldMessenger.of(context).showSnackBar(snackBarSucceed);
                                        } else {
                                          ScaffoldMessenger.of(context).showSnackBar(snackBarFailed);
                                        }

                                        // hideOverlay();
                                      },
                                      child: Text(
                                        'Submit',
                                      ))),
                            ),
                            // ),
                          ],
                        ),
                      ],
                    ),
                  ))
                ]),
              )));
    });
  }
}
