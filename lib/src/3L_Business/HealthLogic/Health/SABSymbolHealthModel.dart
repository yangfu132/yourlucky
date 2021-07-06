import 'package:yourlucky/src/1L_Context/SACGlobal.dart';
import 'package:yourlucky/src/3L_Business/HealthLogic/Logic/SABSymbolLogicModel.dart';

class SABSymbolHealthModel {
  SABSymbolHealthModel({
    required this.logicSymbol,
    required this.doubleHealth,
    required this.stringHealth,
    required this.outRight,
  });
  final SABSymbolLogicModel logicSymbol;
  double doubleHealth;
  String? stringHealth;
  OutRightEnum outRight;
}
