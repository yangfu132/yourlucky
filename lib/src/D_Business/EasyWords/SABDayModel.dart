import 'package:yourlucky/src/A_Context/SACContext.dart';
import 'package:yourlucky/src/A_Context/SACGlobal.dart';
import 'package:yourlucky/src/D_Business/Base/SABBaseModel.dart';

class SABDayModel extends SABBaseModel {
  SABDayModel({
    required this.stringSky,
    required this.stringEarth,
    required this.stringElement,
  });

  ///日
  final String stringEarth;
  final String stringSky;
  final String stringElement;

  //假设日的健康值为10/365,也就是日实际代表的是一旬；爻的健康值实际上是根据日月计算出来的；
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
