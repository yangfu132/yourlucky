import 'package:yourlucky/src/3L_Business/Base/SABBaseModel.dart';
import 'package:yourlucky/src/3L_Business/EasyLogic/BaseLogic/SABLogicSymbolModel.dart';

import '../../../1L_Context/SACContext.dart';
import '../../../1L_Context/SACGlobal.dart';
import '../../EarthBranch/SABEarthBranchModel.dart';
import '../../EasyWords/SABEasyWordsModel.dart';
import 'SABLogicRowModel.dart';

class SABEasyLogicModel extends SABBaseModel {
  SABEasyLogicModel({
    required this.inputWordsModel,
    required this.listStaticSeasonStrong,
    required this.bFromEasySixPair,
    required this.bToEasySixPair,
    required this.bHideEasySixPair,
    required this.bStaticEasy,
    required this.bFromEasySixConflict,
    required this.bToEasySixConflict,
    required this.bHideEasySixConflict,
    required this.stringEmptyBranch,
    required this.stringEasyParent,
    required this.isEasyRepeatedGroan,
    required this.isEasyInPartRepeated,
    required this.isEasyOutPartRepeated,
    required this.isEasyRestrictsGroan,
    required this.isEasyInPartRestricts,
    required this.isEasyOutPartRestricts,
  });

  final SABEasyWordsModel inputWordsModel;

  final List listStaticSeasonStrong;

  late final SABEarthBranchModel _earthBranchModel = SABEarthBranchModel();

  late final List _listRowModels = List.empty(growable: true);

  final bool bStaticEasy;

  final bool bFromEasySixPair;
  final bool bToEasySixPair;
  final bool bHideEasySixPair;

  final bool bFromEasySixConflict;
  final bool bToEasySixConflict;
  final bool bHideEasySixConflict;

  final String stringEmptyBranch;

  ///卦变生克墓绝章第二十四
  final String stringEasyParent;

  ///反伏章第二十五
  final bool isEasyRepeatedGroan;

  final bool isEasyInPartRepeated;

  final bool isEasyOutPartRepeated;

  final bool isEasyRestrictsGroan;

  final bool isEasyInPartRestricts;

  final bool isEasyOutPartRestricts;

  /// `Public`//////////////////////////////////////////////////////////////

  ///此函数包含十天干
  static String skyTrunkString() {
    return "甲乙丙丁戊己庚辛壬癸";
  }

  ///此函数包含十二地支
  static String earthBranchString() {
    return "子丑寅卯辰巳午未申酉戌亥";
  }

  bool isEasySixPair(EasyTypeEnum enumEasyType) {
    bool bResult = false;
    if (enumEasyType == EasyTypeEnum.from) {
      bResult = bFromEasySixPair;
    } else if (enumEasyType == EasyTypeEnum.to) {
      bResult = bToEasySixPair;
    } else if (enumEasyType == EasyTypeEnum.hide) {
      bResult = bHideEasySixPair;
    } else {
      coLog("error!");
    }
    return bResult;
  }

  bool isEasySixConflict(EasyTypeEnum enumEasyType) {
    bool bResult = false;
    if (enumEasyType == EasyTypeEnum.from) {
      bResult = bFromEasySixConflict;
    } else if (enumEasyType == EasyTypeEnum.to) {
      bResult = bToEasySixConflict;
    } else if (enumEasyType == EasyTypeEnum.hide) {
      bResult = bHideEasySixConflict;
    } else {
      coLog("error!");
    }
    return bResult;
  }

  String getSymbolEarth(int intRow, EasyTypeEnum easyTypeEnum) {
    return rowModelAtRow(intRow).inputWordsRow.getSymbolEarth(easyTypeEnum);
  }

  bool isMovementAtRow(int intRow) {
    return inputWordsModel.isMovementAtRow(intRow);
  }

  /// `Get & Set`//////////////////////////////////////////////////////////////
  ///

  SABLogicSymbolModel symbolAtRow(int intRow, EasyTypeEnum easyType) {
    SABLogicSymbolModel resultSymbol;
    if (easyType == EasyTypeEnum.from) {
      resultSymbol = rowModelAtRow(intRow).fromSymbol;
    } else if (easyType == EasyTypeEnum.to) {
      resultSymbol = rowModelAtRow(intRow).toSymbol;
    } else /*if (easyType == EasyTypeEnum.hide)*/ {
      resultSymbol = rowModelAtRow(intRow).hideSymbol;
    }
    return resultSymbol;
  }

  String getSymbolForwardOrBack(int intRow) {
    return rowModelAtRow(intRow).stringSymbolForwardOrBack;
  }

  bool getIsSymbolChangeBorn(int intRow) {
    return rowModelAtRow(intRow).isSymbolChangeBorn;
  }

  bool getIsSymbolChangeRestrict(int intRow) {
    return rowModelAtRow(intRow).isSymbolChangeRestrict;
  }

  bool getIsSymbolChangeConflict(int intRow) {
    return rowModelAtRow(intRow).isSymbolChangeConflict;
  }

  bool isEffectAble(int intRow, EasyTypeEnum easyType) {
    return rowModelAtRow(intRow).getIsEffectAble(easyType);
  }

  bool isSeasonStrong(int intRow, EasyTypeEnum easyType) {
    return rowModelAtRow(intRow).getIsSeasonStrong(easyType);
  }

  EmptyEnum getBasicEmptyState(int intRow, EasyTypeEnum easyType) {
    return rowModelAtRow(intRow).getBasicEmptyState(easyType);
  }

  bool isOnMonth(int intRow, EasyTypeEnum easyType) {
    return rowModelAtRow(intRow).getIsOnMonth(easyType);
  }

  bool isOnDay(int intRow, EasyTypeEnum easyType) {
    return rowModelAtRow(intRow).getIsOnDay(easyType);
  }

  bool isMonthPair(int intRow, EasyTypeEnum easyType) {
    return rowModelAtRow(intRow).getIsMonthPair(easyType);
  }

  bool isDayPair(int intRow, EasyTypeEnum easyType) {
    return rowModelAtRow(intRow).getIsDayPair(easyType);
  }

  /// `加载函数`/////////////////////////////////////////////////////////////////

  void addSymbol(SABLogicRowModel symbol) {
    _listRowModels.add(symbol);
  }

  SABLogicRowModel rowModelAtRow(int intRow) {
    if (intRow > _listRowModels.length) {
      coLog("intRow:$intRow");
    }
    return _listRowModels[intRow];
  }

  SABEarthBranchModel earthBranchModel() {
    return _earthBranchModel;
  }
}
