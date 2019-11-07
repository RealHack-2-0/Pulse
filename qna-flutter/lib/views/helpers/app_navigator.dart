import 'package:flutter/cupertino.dart';

class AppNavigator {
  static void push(context, WidgetBuilder wb) {
    Navigator.push(
      context,
      CupertinoPageRoute(builder: wb),
    );
  }

  static void pushAsFirst(context, WidgetBuilder wb) {
    Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: wb),
        (Route<dynamic> route) => false);
  }
}