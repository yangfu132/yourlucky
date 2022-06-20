import 'package:yourlucky/src/A_Context/SACGlobal.dart';
import 'package:yourlucky/src/D_Business/Base/SABBaseModel.dart';
import 'package:yourlucky/src/D_Business/EasyLogic/BaseLogic/SABLogicSymbolModel.dart';

class SABHealthSymbolModel extends SABBaseModel {
  SABHealthSymbolModel({
    required this.logicSymbol,
    required this.doubleHealth,
    required this.outRight,
    required this.critical,
  });
  final SABLogicSymbolModel logicSymbol;
  final double critical;
  double doubleHealth;
  OutRightEnum outRight;

  void check() {
    logicSymbol.check();
    // for (SABHealthRowModel row in _listRowModels) {
    //   row.check();
    // }
    // if (stringDeity.isEmpty) {
    //   coLog("stringDeity.isEmpty");
    // }
    super.check();
  }

  double healthWithCritical() {
    return doubleHealth - critical;
  }

  bool isStrong() {
    return healthWithCritical() > 0;
  }

  String healthDescription() {
    String strResult = "??";
    if (isStrong()) {
      strResult = "强";
    } else {
      strResult = "弱";
    }
    strResult = healthWithCritical().toStringAsFixed(4) + '($strResult)';
    return strResult;
  }
}
