import 'package:yourlucky/src/1L_Context/SACGlobal.dart';
import 'package:yourlucky/src/3L_Business/HealthLogic/Health/SABSymbolHealthModel.dart';

class SABSymbolHealthLogicModel {
  SABSymbolHealthLogicModel({
    required this.healthSymbol,
    required this.isSymbolDayBroken,
    required this.conflictOnMonthState,
    required this.conflictOnDayState,
    required this.symbolEmptyState,
    required this.stringDeity,
  });
  final SABSymbolHealthModel healthSymbol;
  final bool isSymbolDayBroken;
  final MonthConflictEnum conflictOnMonthState;
  final DayConflictEnum conflictOnDayState;
  final EmptyEnum symbolEmptyState;
  final String stringDeity;
}
