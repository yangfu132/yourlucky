import 'package:your_lucky/src/A_Context/sac_context.dart';
import 'package:your_lucky/src/A_Context/sac_global.dart';
import 'package:your_lucky/src/D_Business/Base/sab_base_model.dart';
import 'package:your_lucky/src/D_Business/EasyWords/sab_words_symbol_model.dart';

class SABLogicSymbolModel extends SABBaseModel {
  SABLogicSymbolModel({
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
  //
  SABLogicSymbolModel.fromJson(Map<String, Object?> json)
      : this(
    isOnMonth: json['isOnMonth'] as bool,
    isMonthPair: json['isMonthPair'] as bool,
    bMonthBorn: json['bMonthBorn'] as bool,
    isConflictMonth: json['isConflictMonth'] as bool,
    isMonthRestrict: json['isMonthRestrict'] as bool,
    isOnDay: json['isOnDay'] as bool,
    isDayPair: json['isDayPair'] as bool,
    bDayBorn: json['bDayBorn'] as bool,
    isConflictDay: json['isConflictDay'] as bool,
    isDayRestrict: json['isDayRestrict'] as bool,
    basicEmptyState: json['basicEmptyState'] as EmptyEnum,
    isSeasonStrong: json['isSeasonStrong'] as bool,
    stringSeason: json['stringSeason']! as String,
    isEffectAble: json['isEffectAble'] as bool,
  );

  @override Map<String, Object?> toJson() {
    return {
      'isOnMonth': isOnMonth,
      'isMonthPair': isMonthPair,
      'bMonthBorn': bMonthBorn,
      'isConflictMonth': isConflictMonth,
      'isMonthRestrict': isMonthRestrict,
      'isOnDay': isOnDay,
      'isDayPair': isDayPair,
      'bDayBorn': bDayBorn,
      'isConflictDay': isConflictDay,
      'isDayRestrict': isDayRestrict,
      'basicEmptyState': basicEmptyState,
      'isSeasonStrong': isSeasonStrong,
      'stringSeason': stringSeason,
      'isEffectAble': isEffectAble,
    };
  }

  @override void check() {
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
