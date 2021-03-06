import 'package:yourlucky/src/1L_Context/SACContext.dart';
import 'package:yourlucky/src/1L_Context/SACGlobal.dart';
import 'package:yourlucky/src/3L_Business/EasyLogic/Health/SABRowHealthModel.dart';
import 'package:yourlucky/src/3L_Business/EasyLogic/SABSymbolHealthLogicModel.dart';

class SABRowHealthLogicModel {
  SABRowHealthLogicModel({
    required this.healthRow,
    required this.fromSymbol,
    required this.toSymbol,
    required this.hideSymbol,
    required this.isSymbolBackMove,
  });
  final SABRowHealthModel healthRow;
  final bool isSymbolBackMove;
  final SABSymbolHealthLogicModel fromSymbol;
  final SABSymbolHealthLogicModel toSymbol;
  final SABSymbolHealthLogicModel hideSymbol;
  bool? isSymbolChangeEmpty;

  String getDeity(EasyTypeEnum easyTypeEnum) {
    if (easyTypeEnum == EasyTypeEnum.from) {
      return fromSymbol.stringDeity;
    } else if (easyTypeEnum == EasyTypeEnum.to) {
      return toSymbol.stringDeity;
    } else if (easyTypeEnum == EasyTypeEnum.hide) {
      return hideSymbol.stringDeity;
    } else {
      colog('easyTypeEnum:$easyTypeEnum');
      return 'easyTypeEnum:$easyTypeEnum';
    }
  }

  EmptyEnum getSymbolEmptyState(EasyTypeEnum easyTypeEnum) {
    if (easyTypeEnum == EasyTypeEnum.from) {
      return fromSymbol.symbolEmptyState;
    } else if (easyTypeEnum == EasyTypeEnum.to) {
      return toSymbol.symbolEmptyState;
    } else if (easyTypeEnum == EasyTypeEnum.hide) {
      return hideSymbol.symbolEmptyState;
    } else {
      colog('easyTypeEnum:$easyTypeEnum');
      return EmptyEnum.Empty_Null;
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
    } else
      colog('easyTypeEnum:$easyTypeEnum');

    return bSymbolDayBroken;
  }

  MonthConflictEnum getConflictOnMonthState(EasyTypeEnum easyTypeEnum) {
    MonthConflictEnum enumResultConflict = MonthConflictEnum.Conflict_Null;
    if (easyTypeEnum == EasyTypeEnum.from) {
      enumResultConflict = fromSymbol.conflictOnMonthState;
    } else if (easyTypeEnum == EasyTypeEnum.to) {
      enumResultConflict = toSymbol.conflictOnMonthState;
    } else if (easyTypeEnum == EasyTypeEnum.hide) {
      enumResultConflict = hideSymbol.conflictOnMonthState;
    } else
      colog('easyTypeEnum:$easyTypeEnum');

    return enumResultConflict;
  }

  DayConflictEnum getConflictOnDayState(EasyTypeEnum easyTypeEnum) {
    DayConflictEnum enumResultConflict = DayConflictEnum.Conflict_Null;
    if (easyTypeEnum == EasyTypeEnum.from) {
      enumResultConflict = fromSymbol.conflictOnDayState;
    } else if (easyTypeEnum == EasyTypeEnum.to) {
      enumResultConflict = toSymbol.conflictOnDayState;
    } else if (easyTypeEnum == EasyTypeEnum.hide) {
      enumResultConflict = hideSymbol.conflictOnDayState;
    } else
      colog('easyTypeEnum:$easyTypeEnum');

    return enumResultConflict;
  }
}
