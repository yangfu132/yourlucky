import 'package:your_lucky/src/A_Context/sac_context.dart';
import 'package:your_lucky/src/A_Context/sac_global.dart';
import 'package:your_lucky/src/D_Business/Base/sab_base_model.dart';
import 'package:your_lucky/src/D_Business/EasyLogic/Health/sab_health_row_model.dart';
import 'package:your_lucky/src/D_Business/EasyLogic/sab_easy_empty_model.dart';
import 'package:your_lucky/src/D_Business/EasyLogic/sab_health_logic_symbol_model.dart';

class SABHealthLogicRowModel extends SABBaseModel {
  SABHealthLogicRowModel({
    required this.healthRow,
    required this.fromSymbol,
    required this.toSymbol,
    required this.hideSymbol,
    required this.isSymbolBackMove,
  });
  final SABHealthRowModel healthRow;
  final bool isSymbolBackMove;
  final SABHealthLogicSymbolModel fromSymbol;
  final SABHealthLogicSymbolModel toSymbol;
  final SABHealthLogicSymbolModel hideSymbol;
  bool? isSymbolChangeEmpty;

  @override void check() {
    healthRow.check();
    fromSymbol.check();
    toSymbol.check();
    hideSymbol.check();
    super.check();
  }

  String? getStringHealth(EasyTypeEnum easyTypeEnum) {
    if (easyTypeEnum == EasyTypeEnum.from) {
      return fromSymbol.inputHealthSymbol?.healthDescription() ?? "from empty";
    } else if (easyTypeEnum == EasyTypeEnum.to) {
      return toSymbol.inputHealthSymbol?.healthDescription() ?? "to empty";
    } else if (easyTypeEnum == EasyTypeEnum.hide) {
      return hideSymbol.inputHealthSymbol?.healthDescription() ?? "hide empty";
    } else {
      coLog(
          StackTrace.current, LogTypeEnum.error, 'easyTypeEnum:$easyTypeEnum');
      return 'easyTypeEnum:$easyTypeEnum';
    }
  }

  String getDeity(EasyTypeEnum easyTypeEnum) {
    if (easyTypeEnum == EasyTypeEnum.from) {
      return fromSymbol.stringDeity;
    } else if (easyTypeEnum == EasyTypeEnum.to) {
      return toSymbol.stringDeity;
    } else if (easyTypeEnum == EasyTypeEnum.hide) {
      return hideSymbol.stringDeity;
    } else {
      coLog(
          StackTrace.current, LogTypeEnum.error, 'easyTypeEnum:$easyTypeEnum');
      return 'easyTypeEnum:$easyTypeEnum';
    }
  }

  SABEasyEmptyModel getSymbolEmptyState(EasyTypeEnum easyTypeEnum) {
    if (easyTypeEnum == EasyTypeEnum.from) {
      return fromSymbol.symbolEmptyState;
    } else if (easyTypeEnum == EasyTypeEnum.to) {
      return toSymbol.symbolEmptyState;
    } else if (easyTypeEnum == EasyTypeEnum.hide) {
      return hideSymbol.symbolEmptyState;
    } else {
      coLog(
          StackTrace.current, LogTypeEnum.error, 'easyTypeEnum:$easyTypeEnum');
      return SABEasyEmptyModel.emptyModel();
    }
  }

  bool getIsSymbolDayBroken(EasyTypeEnum easyTypeEnum) {
    bool bSymbolDayBroken = false;
    if (easyTypeEnum == EasyTypeEnum.from) {
      bSymbolDayBroken = fromSymbol.isSymbolDayBroken;
    } else if (easyTypeEnum == EasyTypeEnum.to) {
      bSymbolDayBroken = toSymbol.isSymbolDayBroken;
    } else if (easyTypeEnum == EasyTypeEnum.hide) {
      bSymbolDayBroken = hideSymbol.isSymbolDayBroken;
    } else {
      coLog(
          StackTrace.current, LogTypeEnum.error, 'easyTypeEnum:$easyTypeEnum');
    }
    return bSymbolDayBroken;
  }

  MonthConflictEnum getConflictOnMonthState(EasyTypeEnum easyTypeEnum) {
    MonthConflictEnum enumResultConflict = MonthConflictEnum.conflictNull;
    if (easyTypeEnum == EasyTypeEnum.from) {
      enumResultConflict = fromSymbol.conflictOnMonthState;
    } else if (easyTypeEnum == EasyTypeEnum.to) {
      enumResultConflict = toSymbol.conflictOnMonthState;
    } else if (easyTypeEnum == EasyTypeEnum.hide) {
      enumResultConflict = hideSymbol.conflictOnMonthState;
    } else {
      coLog(
          StackTrace.current, LogTypeEnum.error, 'easyTypeEnum:$easyTypeEnum');
    }
    return enumResultConflict;
  }

  DayConflictEnum getConflictOnDayState(EasyTypeEnum easyTypeEnum) {
    DayConflictEnum enumResultConflict = DayConflictEnum.conflictNull;
    if (easyTypeEnum == EasyTypeEnum.from) {
      enumResultConflict = fromSymbol.conflictOnDayState;
    } else if (easyTypeEnum == EasyTypeEnum.to) {
      enumResultConflict = toSymbol.conflictOnDayState;
    } else if (easyTypeEnum == EasyTypeEnum.hide) {
      enumResultConflict = hideSymbol.conflictOnDayState;
    } else {
      coLog(
          StackTrace.current, LogTypeEnum.error, 'easyTypeEnum:$easyTypeEnum');
    }
    return enumResultConflict;
  }
}
