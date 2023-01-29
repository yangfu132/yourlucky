import 'package:yourlucky/src/A_Context/SACContext.dart';
import 'package:yourlucky/src/A_Context/SACGlobal.dart';
import 'package:yourlucky/src/D_Business/Base/SABBaseModel.dart';

class SABWordsMonthModel extends SABBaseModel {
  SABWordsMonthModel({
    required this.stringSky,
    required this.stringEarth,
    required this.stringElement,
  });
  final String stringSky;
  final String stringEarth;
  final String stringElement;

  String skyEarth() {
    return stringSky + stringEarth + "月";
  }

  void check() {
    if (stringSky.isEmpty) {
      coLog(StackTrace.current, LogTypeEnum.check, "stringSky.isEmpty");
    }
    if (stringEarth.isEmpty) {
      coLog(StackTrace.current, LogTypeEnum.check, "stringEarth.isEmpty");
    }
    if (stringElement.isEmpty) {
      coLog(StackTrace.current, LogTypeEnum.check, "stringElement.isEmpty");
    }
    super.check();
  }
}
