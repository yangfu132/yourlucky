import 'package:your_lucky/src/A_Context/sac_context.dart';
import 'package:your_lucky/src/A_Context/sac_global.dart';
import 'package:your_lucky/src/D_Business/Base/sab_base_model.dart';

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
    return "$stringSky$stringEarth月";
  }

  String healthDes() {
    return SACContext.setting().monthHealth.stringValue;
  }

  @override void check() {
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
