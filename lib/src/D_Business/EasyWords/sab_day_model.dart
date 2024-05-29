import 'package:your_lucky/src/A_Context/sac_context.dart';
import 'package:your_lucky/src/A_Context/sac_global.dart';
import 'package:your_lucky/src/D_Business/Base/sab_base_model.dart';

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
  final double health =
      double.parse(SACContext.setting().dayHealth.stringValue);

  ///输出值
  final double dayOut = 1.2;

  ///输出权
  final double dayOutRight = 100.0;

  String skyEarth() {
    return "$stringSky$stringEarth日";
  }

  String healthDes() {
    return SACContext.setting().dayHealth.stringValue;
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
