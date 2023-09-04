import 'package:yourlucky/src/A_Context/SACContext.dart';
import 'package:yourlucky/src/A_Context/SACGlobal.dart';
import 'package:yourlucky/src/D_Business/Base/SABBaseModel.dart';

class SABWordsDayModel extends SABBaseModel {
  SABWordsDayModel({
    required this.stringSky,
    required this.stringEarth,
    required this.stringElement,
  });

  ///日
  final String stringEarth;
  final String stringSky;
  final String stringElement;

  final double health = 100.0;

  ///输出值
  final double dayOut = 1.2;

  ///输出权
  final double dayOutRight = 100.0;

  String skyEarth() {
    return stringSky + stringEarth + "日";
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
