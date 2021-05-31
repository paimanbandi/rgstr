import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rgstr/registration_page.dart';
import 'package:rgstr/registration_view.dart';

import 'package:imei_imsi_plugin/imei_imsi_plugin.dart';

class RegistrationController extends State<RegistrationPage> {
  TextEditingController tecImei = TextEditingController();

  String sPlatformImei = '';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    String platformImei;
    try {
      // only works in Android version < 10
      platformImei = await ImeiImsiPlugin.getImei(shouldShowRequestPermissionRationale: false);
    } on PlatformException {
      print('Failed to get platform version.');
    }

    if (!mounted) return;

    setState(() {
      sPlatformImei = platformImei;
    });
  }

  @override
  Widget build(BuildContext context) => RegistrationView(this);
}
