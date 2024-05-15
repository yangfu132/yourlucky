import 'package:your_lucky/src/A_Context/sac_context.dart';
import 'package:your_lucky/src/A_Context/sac_global.dart';
import 'package:your_lucky/src/D_Business/Base/SABBaseModel.dart';
import 'package:your_lucky/src/D_Business/EasyWords/SABWordsSymbolModel.dart';

class SABLogicSymbolModel extends SABBaseModel {
  SABLogicSymbolModel({
    required this.inputWordsSymbol,
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
  final SABWordsSymbolModel inputWordsSymbol;

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

  void check() {
    inputWordsSymbol.check();
    if (stringSeason.isEmpty) {
      coLog(StackTrace.current, LogTypeEnum.check, 'stringSeason.isEmpty');
    }
    super.check();
  }

  bool isEmpty() {
    return EmptyEnum.emptyYES == basicEmptyState ||
        EmptyEnum.emptyReal == basicEmptyState;
  }
}
