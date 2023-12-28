import 'package:yourlucky/src/A_Context/SACContext.dart';
import 'package:yourlucky/src/A_Context/SACGlobal.dart';
import 'package:yourlucky/src/D_Business/Base/SABBaseModel.dart';

class SABMonthModel extends SABBaseModel {
  SABMonthModel({
    required this.stringSky,
    required this.stringEarth,
    required this.stringElement,
  });
  final String stringSky;
  final String stringEarth;
  final String stringElement;

  //假设日的健康值为30/365,也就是月实际代表的是一月，爻的健康值实际上是根据日月计算出来的；
  final double health =
      double.parse(SACContext.setting().monthHealth.stringValue);

  ///输出值
  final double monthOut = 1;

  ///输出权
  final double monthOutRight = 100.0;

  List<String> arraySeason = ["旺", "相", "余气", "休", "囚", "死"];

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
