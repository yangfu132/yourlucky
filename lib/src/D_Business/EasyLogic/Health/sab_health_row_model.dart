import 'package:your_lucky/src/A_Context/sac_context.dart';
import 'package:your_lucky/src/A_Context/sac_global.dart';
import 'package:your_lucky/src/D_Business/Base/sab_base_model.dart';
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
      fHealth = fromSymbol.doubleHealth;
    } else if (EasyTypeEnum.to == easyType) {
      fHealth = toSymbol.doubleHealth;
    } else if (EasyTypeEnum.hide == easyType) {
      fHealth = hideSymbol.doubleHealth;
    } else {
      coLog(StackTrace.current, LogTypeEnum.error, "error!");
    } //end if
    return fHealth;
  }

  void setHealthForEasyType(EasyTypeEnum easyType, double fHealth) {
    if (EasyTypeEnum.from == easyType) {
      fromSymbol.doubleHealth = fHealth;
    } else if (EasyTypeEnum.to == easyType) {
      toSymbol.doubleHealth = fHealth;
    } else if (EasyTypeEnum.hide == easyType) {
      hideSymbol.doubleHealth = fHealth;
    } else {
      coLog(StackTrace.current, LogTypeEnum.error, "error!");
    } //end if
  }
}
