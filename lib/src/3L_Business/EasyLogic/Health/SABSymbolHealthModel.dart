import 'package:yourlucky/src/1L_Context/SACGlobal.dart';
import 'package:yourlucky/src/3L_Business/Base/SABBaseModel.dart';
import 'package:yourlucky/src/3L_Business/EasyLogic/BaseLogic/SABSymbolLogicModel.dart';

class SABSymbolHealthModel extends SABBaseModel {
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
