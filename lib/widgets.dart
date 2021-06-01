import 'package:flutter/material.dart';
import 'package:rgstr/global.dart';

Widget wProgressIndicator() {
  return Center(
    child: CircularProgressIndicator(),
  );
}

Widget showOverlay() {
  return Dialog(
      child: Container(
    color: Colors.transparent,
    child: Center(
      child: wProgressIndicator(),
    ),
  ));
}

void hideOverlay({bool all = false}) {
  Navigator.pop(navigatorKey.currentContext);
}
