import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rgstr/registration_page.dart';
import 'package:rgstr/registration_view.dart';

import 'package:imei_imsi_plugin/imei_imsi_plugin.dart';
import 'package:device_info/device_info.dart';

class RegistrationController extends State<RegistrationPage> {
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  TextEditingController date = new TextEditingController();
  DateTime selectedDate = DateTime.now();
  int age = 0;

  int getAge(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    int dayDiff = (to.difference(from).inHours / 24).round();
    int age = (dayDiff / 365).round();
    return age;
  }

  Future<Null> selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(context: context, initialDate: selectedDate, firstDate: DateTime(1901, 1), lastDate: DateTime(2100));
    if (picked != null && picked != selectedDate) {
      String formattedDateTime = "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year.toString()}";
      final DateTime birthday = DateTime(picked.year, picked.month, picked.day);
      final DateTime now = DateTime.now();
      setState(() {
        selectedDate = picked;
        date.value = TextEditingValue(text: formattedDateTime);
        age = getAge(birthday, now);
      });
    }
  }

  String sPlatformImei = '';

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      initPlatformState();
    });
    super.initState();
  }

  Future<void> initPlatformState() async {
    String platformImei;

    try {
      var androidInfo = await deviceInfoPlugin.androidInfo;
      var sdkInt = androidInfo.version.sdkInt;
      // only works in Android version < 10
      if ((Platform.isAndroid && sdkInt < 29) || Platform.isIOS) {
        platformImei = await ImeiImsiPlugin.getImei(shouldShowRequestPermissionRationale: false);
      } else {
        platformImei = '';
      }
    } on PlatformException {
      print('Failed to get IMEI.');
    }

    if (!mounted) return;

    setState(() {
      sPlatformImei = platformImei;
    });
  }

  @override
  Widget build(BuildContext context) => RegistrationView(this);
}
