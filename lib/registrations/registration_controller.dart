import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rgstr/global.dart';
import 'package:rgstr/registrations/registration_dao.dart';
import 'package:rgstr/registrations/registration_model.dart';
import 'package:rgstr/registrations/registration_page.dart';
import 'package:rgstr/registrations/registration_view.dart';

import 'package:imei_imsi_plugin/imei_imsi_plugin.dart';
import 'package:device_info/device_info.dart';
import 'package:image_picker/image_picker.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:rgstr/widgets.dart';

class RegistrationController extends State<RegistrationPage> {
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  TextEditingController tecImei = new TextEditingController();
  TextEditingController tecFirstName = new TextEditingController();
  TextEditingController tecLastName = new TextEditingController();
  TextEditingController tecDob = new TextEditingController();
  TextEditingController tecPassport = new TextEditingController();
  TextEditingController tecEmail = new TextEditingController();

  DateTime selectedDate = DateTime.now();
  int age = 0;
  String sImei = '';
  File fPicture;
  final picker = ImagePicker();
  String sPicture = '';
  String sOSVersion = '';

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      initPlatformState();
    });
    super.initState();
  }

  Future<void> initPlatformState() async {
    String platformImei;
    String osVersion;

    try {
      if (Platform.isAndroid) {
        var androidInfo = await deviceInfoPlugin.androidInfo;
        var sdkInt = androidInfo.version.sdkInt;
        print('version.sdkInt' + androidInfo.version.sdkInt.toString());
        print('version.release' + androidInfo.version.release);
        osVersion = androidInfo.version.release;
        if (sdkInt < 29) {
          platformImei = await ImeiImsiPlugin.getImei(shouldShowRequestPermissionRationale: false);
        } else {
          platformImei = '';
        }
      } else {
        var iosInfo = await deviceInfoPlugin.iosInfo;
        platformImei = await ImeiImsiPlugin.getImei(shouldShowRequestPermissionRationale: false);
        print('systemVersion' + iosInfo.systemVersion);
        osVersion = iosInfo.systemVersion;
      }
    } on PlatformException {
      print('Failed to get IMEI.');
    }

    if (!mounted) return;

    setState(() {
      sImei = platformImei;
      sOSVersion = osVersion;
    });
  }

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
        tecDob.value = TextEditingValue(text: formattedDateTime);
        age = getAge(birthday, now);
      });
    }
  }

  Future<File> openCamOrDirDialog() async {
    final File img = await showDialog<File>(
        barrierDismissible: true,
        context: navigatorKey.currentContext,
        builder: (context) => new AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextButton(
                      onPressed: () async {
                        // showOverlay();
                        final _getImg = await getImageCamera();
                        print("getImageCamera");
                        print(_getImg.path);
                        setState(() {
                          sPicture = _getImg.path;
                        });
                        // hideOverlay();
                      },
                      child: Align(alignment: Alignment.centerLeft, child: Text('Use Camera', textAlign: TextAlign.left))),
                  TextButton(
                      onPressed: () async {
                        // showOverlay();
                        final _getImg = await getImageStorage();
                        print("getImageStorage");
                        print(_getImg.path);
                        setState(() {
                          sPicture = _getImg.path;
                        });
                        // hideOverlay();
                      },
                      child: Align(alignment: Alignment.centerLeft, child: Text('Take from Gallery', textAlign: TextAlign.left))),
                ],
              ),
            ));

    return img;
  }

  Future<File> getImageCamera() async {
    var camera = await Permission.camera.status;
    if (!camera.isGranted) {
      await Permission.camera.request();
    }
    final pickedFile = await picker.getImage(source: ImageSource.camera, imageQuality: 50);
    if (pickedFile != null) {
      final rawFile = File(pickedFile.path);

      return rawFile;
    }
    print('No image taken.');
    return null;
  }

  Future<File> getImageStorage() async {
    var storage = await Permission.storage.status;
    if (!storage.isGranted) {
      await Permission.storage.request();
    }
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) return File(pickedFile.path);
    print('No image selected.');
    return null;
  }

  // Future<int> register(Registration registration) async {
  //   return await RegistrationDao().register(registration);
  // }

  @override
  Widget build(BuildContext context) => RegistrationView(this);
}
