import 'package:yourlucky/src/A_Context/SACContext.dart';
import 'package:yourlucky/src/A_Context/SACGlobal.dart';
import 'package:yourlucky/src/D_Business/Base/SABBaseModel.dart';
import 'package:yourlucky/src/D_Business/EasyLogic/Health/SABHealthSymbolModel.dart';

class SABHealthLogicSymbolModel extends SABBaseModel {
  SABHealthLogicSymbolModel({
    required this.healthSymbol,
    required this.isSymbolDayBroken,
    required this.conflictOnMonthState,
    required this.conflictOnDayState,
    required this.symbolEmptyState,
    required this.stringDeity,
  });
  final SABHealthSymbolModel healthSymbol;
  final bool isSymbolDayBroken;
  final MonthConflictEnum conflictOnMonthState;
  final DayConflictEnum conflictOnDayState;
  final EmptyEnum symbolEmptyState;
  final String stringDeity;

  void check() {
    healthSymbol.check();

    // for (SABHealthLogicRowModel row in _listRowModels) {
    //   row.check();
    // }
    if (stringDeity.isEmpty) {
      coLog(StackTrace.current, LogTypeEnum.check, "stringDeity.isEmpty");
    }
    super.check();
  }
}
