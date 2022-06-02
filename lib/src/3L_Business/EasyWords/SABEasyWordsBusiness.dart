import 'package:yourlucky/src/3L_Business/DigitModel/SABEasyDigitModel.dart';
import 'package:yourlucky/src/3L_Business/EarthBranch/SABEarthBranchBusiness.dart';
import 'package:yourlucky/src/3L_Business/EasyWords/SABWordsSymbolModel.dart';
import 'package:yourlucky/src/3L_Business/Time/SABDayModel.dart';
import 'package:yourlucky/src/3L_Business/Time/SABMonthModel.dart';

import '../../1L_Context/SACContext.dart';
import '../../1L_Context/SACGlobal.dart';
import '../BasicEasy/SABDiagramsInfoModel.dart';
import '../BasicEasy/SABElementInfoModel.dart';
import 'SABEasyWordsModel.dart';
import 'SABWordsRowModel.dart';

///此Business用于将EasyModel与数据进行关联；
class SABEasyWordsBusiness {
  final SABEasyDigitModel _inputEasyModel;
  SABEasyWordsBusiness(this._inputEasyModel);

  late final SABDiagramsInfoModel _eightDiagrams = SABDiagramsInfoModel();

  late final SABEarthBranchBusiness _branchBusiness = SABEarthBranchBusiness();

  late final SABEasyWordsModel _outEasyWordsModel = _initEasyWordsModel();

  /// `此模块包含世应相关的方法`///////////////////////////////////////////////////

  /// `访问函数`/////////////////////////////////////////////////////////////////

  SABDiagramsInfoModel eightDiagrams() {
    return _eightDiagrams;
  }

  SABEasyWordsModel outEasyWordsModel() {
    return _outEasyWordsModel;
  }

  /// `子model`/////////////////////////////////////////////////////////////////

  SABMonthModel monthModel() {
    SABMonthModel result = SABMonthModel(
      stringEarth: monthEarth(),
      stringSky: monthSky(),
      stringElement: monthElement(),
    );
    return result;
  }

  SABDayModel dayModel() {
    SABDayModel result = SABDayModel(
      stringEarth: dayEarth(),
      stringSky: daySky(),
      stringElement: dayElement(),
    );
    return result;
  }

  String monthEarth() {
    return businessCalendar().earthBranchMonth().stringName() ?? "未知monthEarth";
  }

  String monthSky() {
    return businessCalendar().skyTrunkMonth().stringName() ?? "monthSky";
  }

  String monthElement() {
    return _branchBusiness.earthElement(monthEarth());
  }

  String dayEarth() {
    return businessCalendar().earthBranchDay().stringName() ?? "未知dayEarth";
  }

  String daySky() {
    return businessCalendar().skyTrunkDay().stringName() ?? "未知daySky";
  }

  String dayElement() {
    return _branchBusiness.earthElement(dayEarth());
  }

  /// `symbol`/////////////////////////////////////////////////////////////////

  String symbolStringAtRow(int intIndex, Map mapEasy) {
    String stringResult;
    List array = mapEasy["data"];
    stringResult = array[intIndex];
    return stringResult;
  }

  String symbolAtFromRow(int intIndex) {
    String result;

    if (0 <= intIndex && intIndex <= 5) {
      Map fromDict = fromEasyDictionary();
      String strSymbol = symbolStringAtRow(intIndex, fromDict);

      if (strSymbol.length >= 4) {
        String symbolDes =
            strSymbol.substring(strSymbol.length - 4, strSymbol.length);
        int nValue = _inputEasyModel.digitAtIndex(intIndex);
        if (8 == nValue) {
          result = "×" + symbolDes;
        } else if (9 == nValue) {
          result = "○" + symbolDes;
        } else
          result = strSymbol;
      } else {
        result = "error_symbol_length";
        coLog("error!");
      }
    } else {
      result = "error_symbol_index";
      coLog("error!");
    }
    return result;
  }

  String symbolAtToRow(int intIndex) {
    String stringResult;
    if (0 <= intIndex && intIndex <= 5) {
      String fromEasyElement = eightDiagrams().elementOfEasy(fromEasyName());
      Map toDict = toEasyDictionary();
      String toSymbol = symbolStringAtRow(intIndex, toDict);
      String toElement = symbolElement(toSymbol);

      String strValue =
          SABElementInfoModel.elementRelative(fromEasyElement, toElement);
      stringResult = toSymbol.replaceRange(toSymbol.length - 4, 2, strValue);
    } else {
      stringResult = "error_symbol_index";
      coLog("error!");
    }

    return stringResult;
  }

  String symbolAtHideRow(int intIndex) {
    String result;
    int intHideIndex = intIndex;

    if (intHideIndex >= 0) {
      result = symbolStringAtRow(intHideIndex, placeFirstEasy());
    } else
      result = "卦中用神未现"; //coLog("error!");

    return result;
  }

  String symbolElement(String symbol) {
    String stringResult = "";

    if (symbol.length >= 1)
      stringResult = symbol.substring(symbol.length - 1, symbol.length);
    else
      coLog("");

    return stringResult;
  }

  String symbolParent(String stringSymbol) {
    String stringResult = "";

    if (stringSymbol.length >= 4)
      stringResult = stringSymbol.substring(
          stringSymbol.length - 4, stringSymbol.length - 2);
    else
      coLog("");

    return stringResult;
  }

  bool isSymbolMovement(String stringSymbol) {
    bool bResult = false;
    if (stringSymbol.isNotEmpty) {
      String strMark = stringSymbol.substring(0, 1);
      bResult = "×" == strMark || "○" == strMark;
    } else
      coLog("error!");

    return bResult;
  }

  String symbolEarth(String stringSymbol) {
    String stringResult = "";
    if (stringSymbol.length >= 2)
      stringResult = stringSymbol.substring(
          stringSymbol.length - 2, stringSymbol.length - 1);
    else
      stringResult = "卦中用神未现"; //coLog("error!");

    return stringResult;
  }

  SABWordsSymbolModel fromSymbol(int intRow) {
    String stringSymbol = symbolAtFromRow(intRow);
    return SABWordsSymbolModel(
      intRow: intRow,
      easyType: EasyTypeEnum.from,
      symbolName: stringSymbol,
      stringParent: symbolParent(stringSymbol),
      stringEarth: symbolEarth(stringSymbol),
      stringElement: symbolElement(stringSymbol),
      earlyPlace: earlyPlace(intRow),
      latePlace: latePlace(intRow),
    );
  }

  SABWordsSymbolModel toSymbol(int intRow) {
    String stringSymbol = symbolAtToRow(intRow);
    return SABWordsSymbolModel(
      intRow: intRow,
      easyType: EasyTypeEnum.to,
      symbolName: stringSymbol,
      stringParent: symbolParent(stringSymbol),
      stringEarth: symbolEarth(stringSymbol),
      stringElement: symbolElement(stringSymbol),
      earlyPlace: earlyPlace(intRow),
      latePlace: latePlace(intRow),
    );
  }

  SABWordsSymbolModel hideSymbol(int intRow) {
    String stringSymbol = symbolAtHideRow(intRow);
    return SABWordsSymbolModel(
      intRow: intRow,
      easyType: EasyTypeEnum.hide,
      symbolName: stringSymbol,
      stringParent: symbolParent(stringSymbol),
      stringEarth: symbolEarth(stringSymbol),
      stringElement: symbolElement(stringSymbol),
      earlyPlace: earlyPlace(intRow),
      latePlace: latePlace(intRow),
    );
  }

  String earlyPlace(int intRow) {
    String strGua = eightGuaAtFromRow(intRow);
    return eightDiagrams().earlyPlace()[strGua];
  }

  String latePlace(int intRow) {
    String strGua = eightGuaAtFromRow(intRow);
    return eightDiagrams().latePlace()[strGua];
  }

  /// `输出model`/////////////////////////////////////////////////////////////////
  String animalAtRow(int intIndex) {
    String stringResult = "";
    String dayName = daySky();
    if ("甲" == dayName || "乙" == dayName) {
      List array = ["玄武", "白虎", "螣蛇", "勾陈", "朱雀", "青龙"];

      stringResult = array[intIndex];
    } else if ("丙" == dayName || "丁" == dayName) {
      List array = ["青龙", "玄武", "白虎", "螣蛇", "勾陈", "朱雀"];

      stringResult = array[intIndex];
    } else if ("戊" == dayName) {
      List array = ["朱雀", "青龙", "玄武", "白虎", "螣蛇", "勾陈"];
      stringResult = array[intIndex];
    } else if ("己" == dayName) {
      List array = [
        "勾陈",
        "朱雀",
        "青龙",
        "玄武",
        "白虎",
        "螣蛇",
      ];
      stringResult = array[intIndex];
    } else if ("庚" == dayName || "辛" == dayName) {
      List array = [
        "螣蛇",
        "勾陈",
        "朱雀",
        "青龙",
        "玄武",
        "白虎",
      ];
      stringResult = array[intIndex];
    } else if ("壬" == dayName || "癸" == dayName) {
      List array = ["白虎", "螣蛇", "勾陈", "朱雀", "青龙", "玄武"];
      stringResult = array[intIndex];
    }

    return stringResult;
  }

  String elementOfUsefulDeity() {
    String fromEasyElement = eightDiagrams().elementOfEasy(fromEasyName());
    return SABElementInfoModel.elementByRelative(
        fromEasyElement, _inputEasyModel.getUsefulDeity());
  }

  ///此方法获取当前爻所在的八卦
  String eightGuaAtFromRow(int nRow) {
    String result = "";

    String fromEasyKey = _inputEasyModel.fromEasyKey();
    if (fromEasyKey.length >= 6) {
      String guaKey = "";
      if (nRow < 3)
        guaKey = fromEasyKey.substring(0, 3);
      else
        guaKey = fromEasyKey.substring(3, 6);

      result = SABDiagramsInfoModel.palaceNameForKey(guaKey);
    } else
      coLog("error!");

    return result;
  }

  SABEasyWordsModel _initEasyWordsModel() {
    SABEasyWordsModel wordsModel = SABEasyWordsModel(
      _inputEasyModel,
      diagramsModel(),
      intLifeIndex: _getLifeIndex(),
      intGoalIndex: _goalIndex(),
      stringFormatTime: businessCalendar().stringFromDate(),
      monthModel: monthModel(),
      dayModel: dayModel(),
      elementOfUsefulDeity: elementOfUsefulDeity(),
    );
    for (int intRow = 0; intRow < 6; intRow++) {
      var desOfGoalOrLife = "";
      if (_getLifeIndex() == intRow) {
        desOfGoalOrLife = "世";
      } else if (_goalIndex() == intRow) {
        desOfGoalOrLife = "应";
      } //else desOfGoalOrLife = "";

      SABWordsRowModel row = SABWordsRowModel(
        intDigit: _inputEasyModel.digitAtIndex(intRow),
        fromSymbol: fromSymbol(intRow),
        toSymbol: toSymbol(intRow),
        hideSymbol: hideSymbol(intRow),
        bMovement: _inputEasyModel.isMovementAtRow(intRow),
        stringAnimal: animalAtRow(intRow),
        desOfGoalOrLife: desOfGoalOrLife,
        stringDiagrams: eightGuaAtFromRow(intRow),
      );
      wordsModel.addRowModel(row);
    }

    return wordsModel;
  }
}
