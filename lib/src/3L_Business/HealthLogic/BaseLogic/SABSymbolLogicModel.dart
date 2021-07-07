import 'package:yourlucky/src/1L_Context/SACGlobal.dart';
import 'package:yourlucky/src/3L_Business/EasyWords/SABSymbolWordsModel.dart';

class SABSymbolLogicModel {
  SABSymbolLogicModel({
    required this.wordsSymbol,
    required this.isOnMonth,
    required this.isMonthPair,
    required this.bMonthBorn,
    required this.isMonthRestrict,
    required this.isConflictMonth,
    required this.isOnDay,
    required this.isDayPair,
    required this.bDayBorn,
    required this.isDayRestrict,
    required this.isConflictDay,
    required this.basicEmptyState,
    required this.isSeasonStrong,
    required this.stringSeason,
    required this.isEffectAble,
  });
  final SABSymbolWordsModel wordsSymbol;

  final bool isOnMonth;
  final bool isMonthPair;
  final bool bMonthBorn;
  final bool isConflictMonth;
  final bool isMonthRestrict;

  final bool isOnDay;
  final bool isDayPair;
  final bool bDayBorn;
  final bool isConflictDay;
  final bool isDayRestrict;
  final EmptyEnum basicEmptyState;

  final bool isSeasonStrong;
  final String stringSeason;
  final bool isEffectAble;

  bool isEmpty() {
    return EmptyEnum.Empty_YES == basicEmptyState ||
        EmptyEnum.Empty_Real == basicEmptyState;
  }
}
