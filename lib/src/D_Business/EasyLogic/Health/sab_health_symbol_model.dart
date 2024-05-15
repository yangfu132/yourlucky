import 'package:your_lucky/src/A_Context/sac_global.dart';
import 'package:your_lucky/src/D_Business/Base/sab_base_model.dart';
import 'package:your_lucky/src/D_Business/EasyLogic/BaseLogic/sab_logic_symbol_model.dart';

class SABHealthSymbolModel extends SABBaseModel {
  SABHealthSymbolModel({
    required this.inputLogicSymbol,
    required this.doubleHealth,
    required this.outRight,
    required this.critical,
  });
  final SABLogicSymbolModel inputLogicSymbol;
  final double critical;
  double doubleHealth;
  OutRightEnum outRight;

  @override void check() {
    inputLogicSymbol.check();
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
    strResult = '${healthWithCritical().toStringAsFixed(4)}($strResult)';
    return strResult;
  }
}
