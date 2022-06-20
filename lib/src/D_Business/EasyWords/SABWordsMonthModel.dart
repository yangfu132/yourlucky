import 'package:yourlucky/src/A_Context/SACContext.dart';
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
      coLog("stringSky.isEmpty");
    }
    if (stringEarth.isEmpty) {
      coLog("stringEarth.isEmpty");
    }
    if (stringElement.isEmpty) {
      coLog("stringElement.isEmpty");
    }
    super.check();
  }
}
