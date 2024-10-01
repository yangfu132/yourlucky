import 'package:flutter/material.dart';
import 'package:your_lucky/src/A_Context/sac_route_url.dart';

class SACNavigator {
  static Future<T?> pushNamed<T extends Object?>(
      BuildContext context, String stringUrl, Object? arguments) async {
    return Navigator.push<T>(context, MaterialPageRoute(builder: (context) {
      return mapRouteToPage(stringUrl, arguments);
    }));
  }

  static pop(BuildContext context) {
    Navigator.pop(context);
  }
}
