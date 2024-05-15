import 'package:flutter/foundation.dart';

class SABBaseService {
  void printMsg (String? message) {
    debugPrint(message);
  }

  static void staticPrintMsg (String? message) {
    debugPrint(message);
  }
}
