import 'package:yourlucky/src/A_Context/SACContext.dart';
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

  String skyEarth() {
    return stringSky + stringEarth + "日";
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
