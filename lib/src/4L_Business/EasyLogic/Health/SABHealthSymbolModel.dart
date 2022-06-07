import 'package:yourlucky/src/1L_Context/SACGlobal.dart';
import 'package:yourlucky/src/4L_Business/Base/SABBaseModel.dart';
import 'package:yourlucky/src/4L_Business/EasyLogic/BaseLogic/SABLogicSymbolModel.dart';

class SABHealthSymbolModel extends SABBaseModel {
  SABHealthSymbolModel({
    required this.logicSymbol,
    required this.doubleHealth,
    required this.stringHealth,
    required this.outRight,
  });
  final SABLogicSymbolModel logicSymbol;
  double doubleHealth;
  String? stringHealth;
  OutRightEnum outRight;
}