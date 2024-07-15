import 'package:your_lucky/src/A_Context/sac_context.dart';
import 'package:your_lucky/src/A_Context/sac_global.dart';
import 'package:your_lucky/src/D_Business/Base/sab_base_model.dart';
import 'package:your_lucky/src/D_Business/EasyLogic/Health/sab_health_sum_target_model.dart';
import 'package:your_lucky/src/D_Business/EasyWords/sab_words_symbol_model.dart';

class SABLogicSymbolModel extends SABBaseModel {
  SABLogicSymbolModel({
    required this.nRow,
    required this.easyType,
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
  final int nRow;
  final EasyTypeEnum easyType;

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
    nRow: json['nRow'] as int,
    easyType: json['easyType'] as EasyTypeEnum,
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

  double defensive (){
    /*
     防御值为0到1之间的数值，
     克：1代表完全不受别爻克，0为完全受克;目前只有0和1，还没有见到两者之间的数字呢。
     生：防御值不影响生
     */
    double bResult = 0.0;
    if (isOnMonth) {
      bResult = globalMaxDefensive;
    } else if (isOnDay) {
      bResult = globalMaxDefensive;
    } else if (isEmpty()) {
      bResult = globalMaxDefensive;
    } else if (isMonthPair) {
      bResult = globalMaxDefensive;
    } else if (isDayPair) {
      bResult = globalMaxDefensive;
    } //else cont.
    return bResult;
  }
}
