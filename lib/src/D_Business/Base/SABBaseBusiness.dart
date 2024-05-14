import 'package:flutter/foundation.dart';
import 'package:your_lucky/src/A_Context/SACContext.dart';
import 'package:your_lucky/src/A_Context/SACGlobal.dart';

class SABBaseBusiness {
  void error() {
    coLog(
      StackTrace.current,
      LogTypeEnum.error,
      '--- $runtimeType error --- ',
    );
    debugPrint("");
  }

  void printMsg (String? message) {
    debugPrint(message);
  }

  static void staticPrintMsg (String? message) {
    debugPrint(message);
  }
}
