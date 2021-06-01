import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

abstract class WidgetView<T1, T2> extends StatelessWidget {
  final T2 state;

  T1 get widget => (state as State).widget as T1;

  const WidgetView(this.state, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context);
}

const Color primaryColor = Colors.blue;
const Color whiteColor = Colors.white;
const Color disabledColor = Colors.grey;
const Color textColor = Colors.black54;
