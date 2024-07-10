import 'package:your_lucky/src/A_Context/sac_context.dart';
import 'package:your_lucky/src/A_Context/sac_global.dart';
import 'package:your_lucky/src/D_Business/Base/sab_base_model.dart';
import 'package:your_lucky/src/D_Business/EasyLogic/Health/sab_health_action_model.dart';
import 'package:your_lucky/src/D_Business/EasyLogic/Health/sab_health_symbol_model.dart';

import '../BaseLogic/sab_logic_row_model.dart';

class SABHealthRowModel extends SABBaseModel {
  SABHealthRowModel({
    required this.inputLogicRow,
    required this.fromSymbol,
    required this.toSymbol,
    required this.hideSymbol,
  });
  final SABLogicRowModel inputLogicRow;

  final SABHealthSymbolModel fromSymbol;
  final SABHealthSymbolModel toSymbol;
  final SABHealthSymbolModel hideSymbol;

  @override void check() {
    inputLogicRow.check();
    fromSymbol.check();
    toSymbol.check();
    hideSymbol.check();
    // for (SABHealthRowModel row in _listRowModels) {
    //   row.check();
    // }
    // if (stringDeity.isEmpty) {
    //   coLog(StackTrace.current,LogTypeEnum.check,"stringDeity.isEmpty");
    // }
    super.check();
  }

  double healthForEasyType(EasyTypeEnum easyType) {
    double fHealth = 0.0;

    if (EasyTypeEnum.from == easyType) {
      fHealth = fromSymbol.getHealthAction();
    } else if (EasyTypeEnum.to == easyType) {
      fHealth = toSymbol.getHealthAction();
    } else if (EasyTypeEnum.hide == easyType) {
      fHealth = hideSymbol.getHealthAction();
    } else {
      coLog(StackTrace.current, LogTypeEnum.error, "error!");
    } //end if
    return fHealth;
  }

  void setHealthForEasyType(SABHealthActionModel actionModel) {
      // EasyTypeEnum easyType, double fHealth) {
    if (EasyTypeEnum.from == actionModel.easyType) {
      fromSymbol.setAction(actionModel);
    } else if (EasyTypeEnum.to == actionModel.easyType) {
      fromSymbol.setAction(actionModel);
    } else if (EasyTypeEnum.hide == actionModel.easyType) {
      fromSymbol.setAction(actionModel);
    } else {
      coLog(StackTrace.current, LogTypeEnum.error, "error!");
    } //end if
  }

  void sumForEasyType(SABHealthActionModel actionModel) {
    if (EasyTypeEnum.from == actionModel.easyType) {
      fromSymbol.sumAction(actionModel);
    } else if (EasyTypeEnum.to == actionModel.easyType) {
      fromSymbol.sumAction(actionModel);
    } else if (EasyTypeEnum.hide == actionModel.easyType) {
      fromSymbol.sumAction(actionModel);
    } else {
      coLog(StackTrace.current, LogTypeEnum.error, "error!");
    } //end if
  }
}
