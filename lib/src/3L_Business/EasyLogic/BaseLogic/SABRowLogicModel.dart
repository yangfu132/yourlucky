﻿import 'package:yourlucky/src/3L_Business/EasyLogic/BaseLogic/SABSymbolLogicModel.dart';

import '../../../1L_Context/SACContext.dart';
import '../../../1L_Context/SACGlobal.dart';
import '../../EasyWords/SABRowWordsModel.dart';

class SABRowLogicModel {
  SABRowLogicModel({
    required this.fromSymbol,
    required this.toSymbol,
    required this.hideSymbol,
    required this.inputWordsRow,
    required this.isSymbolChangeBorn,
    required this.isSymbolChangeRestrict,
    required this.isSymbolChangeConflict,
    required this.stringSymbolForwardOrBack,
    required this.isSymbolChangeForward,
    required this.isSymbolChangeBack,
  });
  final SABRowWordsModel inputWordsRow;
  final SABSymbolLogicModel fromSymbol;
  final SABSymbolLogicModel toSymbol;
  final SABSymbolLogicModel hideSymbol;
  final bool isSymbolChangeBorn;
  final bool isSymbolChangeRestrict;
  final bool isSymbolChangeConflict;

  final String stringSymbolForwardOrBack;
  final bool isSymbolChangeForward;
  final bool isSymbolChangeBack;

  SABSymbolLogicModel? symbolModel(EasyTypeEnum easyTypeEnum) {
    SABSymbolLogicModel? resultSymbol;
    if (easyTypeEnum == EasyTypeEnum.from) {
      resultSymbol = fromSymbol;
    } else if (easyTypeEnum == EasyTypeEnum.to) {
      resultSymbol = toSymbol;
    } else if (easyTypeEnum == EasyTypeEnum.hide) {
      resultSymbol = hideSymbol;
    } else {
      colog('easyTypeEnum:$easyTypeEnum');
    }
    return resultSymbol;
  }

  bool getIsEffectAble(EasyTypeEnum easyTypeEnum) {
    bool bEffectAble = false;
    if (easyTypeEnum == EasyTypeEnum.from) {
      bEffectAble = fromSymbol.isEffectAble;
    } else if (easyTypeEnum == EasyTypeEnum.to) {
      bEffectAble = toSymbol.isEffectAble;
    } else if (easyTypeEnum == EasyTypeEnum.hide) {
      bEffectAble = hideSymbol.isEffectAble;
    } else
      colog('easyTypeEnum:$easyTypeEnum');

    return bEffectAble;
  }

  bool getIsSeasonStrong(EasyTypeEnum easyTypeEnum) {
    bool bResultStrong = false;
    if (easyTypeEnum == EasyTypeEnum.from) {
      bResultStrong = fromSymbol.isSeasonStrong;
    } else if (easyTypeEnum == EasyTypeEnum.to) {
      bResultStrong = toSymbol.isSeasonStrong;
    } else if (easyTypeEnum == EasyTypeEnum.hide) {
      bResultStrong = hideSymbol.isSeasonStrong;
    } else
      colog('easyTypeEnum:$easyTypeEnum');

    return bResultStrong;
  }

  EmptyEnum getBasicEmptyState(EasyTypeEnum easyTypeEnum) {
    EmptyEnum enumResultEmpty = EmptyEnum.Empty_Null;
    if (easyTypeEnum == EasyTypeEnum.from) {
      enumResultEmpty = fromSymbol.basicEmptyState;
    } else if (easyTypeEnum == EasyTypeEnum.to) {
      enumResultEmpty = toSymbol.basicEmptyState;
    } else if (easyTypeEnum == EasyTypeEnum.hide) {
      enumResultEmpty = hideSymbol.basicEmptyState;
    } else
      colog('easyTypeEnum:$easyTypeEnum');

    return enumResultEmpty;
  }

  bool getIsMonthPair(EasyTypeEnum easyTypeEnum) {
    bool bResultIsMonthPair = false;
    if (easyTypeEnum == EasyTypeEnum.from) {
      bResultIsMonthPair = fromSymbol.isMonthPair;
    } else if (easyTypeEnum == EasyTypeEnum.to) {
      bResultIsMonthPair = toSymbol.isMonthPair;
    } else if (easyTypeEnum == EasyTypeEnum.hide) {
      bResultIsMonthPair = hideSymbol.isMonthPair;
    } else
      colog('easyTypeEnum:$easyTypeEnum');

    return bResultIsMonthPair;
  }

  bool getIsOnMonth(EasyTypeEnum easyTypeEnum) {
    bool bResultIsOnMonth = false;
    if (easyTypeEnum == EasyTypeEnum.from) {
      bResultIsOnMonth = fromSymbol.isOnMonth;
    } else if (easyTypeEnum == EasyTypeEnum.to) {
      bResultIsOnMonth = toSymbol.isOnMonth;
    } else if (easyTypeEnum == EasyTypeEnum.hide) {
      bResultIsOnMonth = hideSymbol.isOnMonth;
    } else
      colog('easyTypeEnum:$easyTypeEnum');

    return bResultIsOnMonth;
  }

  bool getIsDayPair(EasyTypeEnum easyTypeEnum) {
    bool bResultIsDayPair = false;
    if (easyTypeEnum == EasyTypeEnum.from) {
      bResultIsDayPair = fromSymbol.isDayPair;
    } else if (easyTypeEnum == EasyTypeEnum.to) {
      bResultIsDayPair = toSymbol.isDayPair;
    } else if (easyTypeEnum == EasyTypeEnum.hide) {
      bResultIsDayPair = hideSymbol.isDayPair;
    } else
      colog('easyTypeEnum:$easyTypeEnum');

    return bResultIsDayPair;
  }

  bool getIsOnDay(EasyTypeEnum easyTypeEnum) {
    bool bResultIsOnDay = false;
    if (easyTypeEnum == EasyTypeEnum.from) {
      bResultIsOnDay = fromSymbol.isOnDay;
    } else if (easyTypeEnum == EasyTypeEnum.to) {
      bResultIsOnDay = toSymbol.isOnDay;
    } else if (easyTypeEnum == EasyTypeEnum.hide) {
      bResultIsOnDay = hideSymbol.isOnDay;
    } else
      colog('easyTypeEnum:$easyTypeEnum');

    return bResultIsOnDay;
  }
}
