import 'package:flutter/material.dart';
import 'package:your_lucky/src/A_Context/SACRouteUrl.dart';

class SACNavigator {
  static Future<T?> pushNamed<T extends Object?>(
      BuildContext context, String stringUrl) async {
    return Navigator.push<T>(context, MaterialPageRoute(builder: (context) {
      return mapRouteToPage(stringUrl, null);
    }));
  }

  static pop(BuildContext context) {
    Navigator.pop(context);
  }
}
