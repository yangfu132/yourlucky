import 'package:your_lucky/src/A_Context/sac_context.dart';
import 'package:your_lucky/src/A_Context/sac_global.dart';
import 'package:your_lucky/src/D_Business/Base/sab_base_model.dart';
import 'package:your_lucky/src/D_Business/EasyLogic/Health/sab_health_symbol_model.dart';
import 'package:your_lucky/src/D_Business/EasyLogic/sab_easy_empty_model.dart';

class SABHealthLogicSymbolModel extends SABBaseModel {
  SABHealthLogicSymbolModel({
    required this.inputHealthSymbol,
    required this.isSymbolDayBroken,
    required this.conflictOnMonthState,
    required this.conflictOnDayState,
    required this.symbolEmptyState,
    required this.stringDeity,
  });
  final SABHealthSymbolModel? inputHealthSymbol;
  final bool isSymbolDayBroken;
  final MonthConflictEnum conflictOnMonthState;
  final DayConflictEnum conflictOnDayState;
  final SABEasyEmptyModel symbolEmptyState;
  final String stringDeity;

  @override void check() {
    inputHealthSymbol?.check();

    // for (SABHealthLogicRowModel row in _listRowModels) {
    //   row.check();
    // }
    if (stringDeity.isEmpty) {
      coLog(StackTrace.current, LogTypeEnum.check, "stringDeity.isEmpty");
    }
    super.check();
  }
}
