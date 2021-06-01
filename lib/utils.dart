import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:rgstr/widgets.dart';
import 'package:rgstr/global.dart';

final picker = ImagePicker();

Future<File> openCamOrDirDialog() async {
  final File img = await showDialog<File>(
      barrierDismissible: false,
      context: navigatorKey.currentContext,
      builder: (context) => new AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextButton(
                    onPressed: () async {
                      showOverlay();
                      final _getImg = await getImageCamera();
                      print("getImageCamera");
                      print(_getImg.path);
                      hideOverlay();
                    },
                    child: Align(alignment: Alignment.centerLeft, child: Text('Use Camera', textAlign: TextAlign.left))),
                TextButton(
                    onPressed: () async {
                      showOverlay();
                      final _getImg = await getImageStorage();
                      print("getImageStorage");
                      print(_getImg.path);
                      hideOverlay();
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
