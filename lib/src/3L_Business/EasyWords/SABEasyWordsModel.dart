import 'package:yourlucky/src/1L_Context/SACContext.dart';
import 'package:yourlucky/src/3L_Business/BasicEasy/SABEightDiagramsModel.dart';
import 'package:yourlucky/src/4L_Service/SASStringService.dart';

import '../../1L_Context/SACGlobal.dart';
import '../StoreEasy/SABEasyDigitModel.dart';
import 'SABRowWordsModel.dart';

class SABEasyWordsModel {
  final SABEasyDigitModel inputDigitModel;
  SABEasyWordsModel(
    this.inputDigitModel, {
    required this.stringFormatTime,
    required this.stringDaySky,
    required this.stringDayEarth,
    required this.stringDayElement,
    required this.stringMonthSky,
    required this.stringMonthEarth,
    required this.stringMonthElement,
    required this.stringFromName,
    required this.stringFromPlace,
    required this.stringFromElement,
    required this.stringToName,
    required this.stringToPlace,
    required this.stringToElement,
    required this.mapFromEasy,
    required this.mapToEasy,
    required this.mapHideEasy,
    required this.bFromPureEasy,
    required this.bToPureEasy,
    required this.elementOfUsefulDeity,
    required this.intLifeIndex,
    required this.intGoalIndex,
  }) {
    if (this.inputDigitModel.isMovement()) {
      this.inputDigitModel.stringDescribe =
          "${this.stringFromName}(${this.stringFromPlace})->${this.stringToName}(${this.stringToPlace})";
    } else {
      this.inputDigitModel.stringDescribe =
          "${this.stringFromName}(${this.stringFromPlace})";
    }
    if (this.inputDigitModel.getEasyGoal().length > 0) {
      this.inputDigitModel.stringTitle =
          this.stringFormatTime + this.inputDigitModel.getEasyGoal();
    } else {
      this.inputDigitModel.stringTitle =
          this.stringFormatTime + this.inputDigitModel.getUsefulDeity();
    }
  }

  late final SABEightDiagramsModel eightDiagrams;

  final List _listRowModels = List.empty(growable: true);

  final String elementOfUsefulDeity;

  ///时间
  final String stringFormatTime;

  ///日
  final String stringDayEarth;
  final String stringDaySky;
  final String stringDayElement;

  ///月
  final String stringMonthSky;
  final String stringMonthEarth;
  final String stringMonthElement;

  ///世应
  final int intLifeIndex;
  final int intGoalIndex;

  ///卦
  final String stringFromName;
  final String stringFromPlace;
  final String stringFromElement;
  final String stringToName;
  final String stringToPlace;
  final String stringToElement;
  final Map mapFromEasy;
  final Map mapToEasy;
  final Map mapHideEasy;

  ///纯卦
  final bool bFromPureEasy;
  final bool bToPureEasy;

  /// `MergeRow函数`///////////////////////////////////////////////////////////
  ///MergeRow的定义
  ///from:0~6
  ///Month:7
  ///Day:8
  ///Fly:10~16
  ///To:20~26
  String symbolNameAtMergeRow(int intRow) {
    String stringResult = "";
    if (0 <= intRow && intRow < 6) {
      stringResult = getSymbolName(intRow, EasyTypeEnum.from);
    } else if (ROW_CHANGE_BEGIN <= intRow && intRow < ROW_CHANGE_END) {
      stringResult = getSymbolName(intRow - ROW_CHANGE_BEGIN, EasyTypeEnum.to);
    } else if (ROW_FLY_BEGIN <= intRow && intRow < ROW_FLY_END) {
      stringResult = getSymbolName(intRow - ROW_FLY_BEGIN, EasyTypeEnum.hide);
    }
    //else cont.

    return stringResult;
  }

  EasyTypeEnum easyTypeOfMergeRow(int intRow) {
    EasyTypeEnum enumResultType = EasyTypeEnum.type_null;
    if (0 <= intRow && intRow < 6) {
      enumResultType = EasyTypeEnum.from;
    } else if (ROW_CHANGE_BEGIN <= intRow && intRow < ROW_CHANGE_END) {
      enumResultType = EasyTypeEnum.to;
    } else if (ROW_FLY_BEGIN <= intRow && intRow < ROW_FLY_END) {
      enumResultType = EasyTypeEnum.hide;
    }
    //else cont.

    return enumResultType;
  }

  String earthAtMergeRow(int intRow) {
    String stringResult = "";
    if (0 <= intRow && intRow < 6) {
      stringResult = getSymbolEarth(intRow, EasyTypeEnum.from);
    } else if (ROW_CHANGE_BEGIN <= intRow && intRow < ROW_CHANGE_END) {
      stringResult = getSymbolEarth(intRow - ROW_CHANGE_BEGIN, EasyTypeEnum.to);
    } else if (ROW_FLY_BEGIN <= intRow && intRow < ROW_FLY_END) {
      stringResult = getSymbolEarth(intRow - ROW_FLY_BEGIN, EasyTypeEnum.hide);
    }
    //else cont.

    return stringResult;
  }

  List earthAtMergeRowArray(List arrayRow) {
    List arrayEarth = [];

    for (int intItem in arrayRow) {
      arrayEarth.add(earthAtMergeRow(intItem));
    } //endf

    return arrayEarth;
  }

  /// `Get & Set函数`///////////////////////////////////////////////////////////
  ///

  ///此方法获取本卦的卦名
  String fromEasyName() {
    String stringResult = "";
    Map fromDict = mapFromEasy;
    if (fromDict.isNotEmpty) {
      stringResult = fromDict["name"];
    }
    //else cont.

    return stringResult;
  }

  ///此方法获取变卦的卦名
  String toEasyName() {
    String stringResult = "";
    Map toDict = mapToEasy;
    if (toDict.isNotEmpty) {
      stringResult = toDict["name"];
    }
    //else cont.
    return stringResult;
  }

  int getDigit(int intRow) {
    return rowModelAtRow(intRow).intDigit;
  }

  String getAnimal(int intRow) {
    return rowModelAtRow(intRow).stringAnimal;
  }

  String getDiagrams(int intRow) {
    return rowModelAtRow(intRow).stringDiagrams;
  }

  List arrayFromRowOfParent(String parent) {
    return arrayRowWithParent(parent, EasyTypeEnum.from);
  }

  List arrayRowWithParent(String parent, EasyTypeEnum easyTypeEnum) {
    List parentArray = List.empty(growable: true);

    for (int intRow = 0; intRow < 6; intRow++) {
      String stringSymbolParent = getSymbolParent(intRow, easyTypeEnum);
      if (stringSymbolParent == parent) {
        parentArray.add(intRow);
      } //else {}
    } //end for

    return parentArray;
  }

  List arrayRowWithElement(String element, EasyTypeEnum easyTypeEnum) {
    List resultArray = List.empty(growable: true);

    for (int intRow = 0; intRow < 6; intRow++) {
      String symbolElement = getSymbolElement(intRow, easyTypeEnum);
      if (symbolElement == element) {
        resultArray.add(intRow);
      }
      //else cont.
    } //endf

    return resultArray;
  }

  List arrayUsefulRow(EasyTypeEnum easyTypeEnum) {
    List parentArray = List.empty(growable: true);

    for (int intRow = 0; intRow < 6; intRow++) {
      String stringSymbolParent = getSymbolParent(intRow, easyTypeEnum);
      if (stringSymbolParent == this.inputDigitModel.getUsefulDeity()) {
        parentArray.add(intRow);
      }
      //else cont.
    } //end for

    return parentArray;
  }

  String monthSkyEarth() {
    return stringMonthSky + stringMonthEarth + "月";
  }

  String daySkyEarth() {
    return stringDaySky + stringDayEarth + "日";
  }

  ///此函数用于判断当前爻是否为动爻
  bool isMovementAtRow(int intRow) {
    return rowModelAtRow(intRow).bMovement;
  }

  String getSymbolName(int intRow, EasyTypeEnum easyTypeEnum) {
    return rowModelAtRow(intRow).getSymbolName(easyTypeEnum);
  }

  String getSymbolParent(int intRow, EasyTypeEnum easyTypeEnum) {
    return rowModelAtRow(intRow).getSymbolParent(easyTypeEnum);
  }

  String getSymbolEarth(int intRow, EasyTypeEnum easyTypeEnum) {
    return rowModelAtRow(intRow).getSymbolEarth(easyTypeEnum);
  }

  String getSymbolElement(int intRow, EasyTypeEnum easyTypeEnum) {
    return rowModelAtRow(intRow).getSymbolElement(easyTypeEnum);
  }

  String getLifeParent() {
    return getSymbolParent(intLifeIndex, EasyTypeEnum.from);
  }

  String getLifeName() {
    return getSymbolName(intLifeIndex, EasyTypeEnum.from);
  }

  String getLifeElement() {
    return getSymbolElement(intLifeIndex, EasyTypeEnum.from);
  }

  String getLifeAnimal() {
    return getAnimal(intLifeIndex);
  }

  String getLifeDiagrams() {
    return getDiagrams(intLifeIndex);
  }

  String stringFromSymbolArray(List hideArray, EasyTypeEnum easyTypeEnum) {
    String stringResult = "";
    for (int intRow in hideArray) {
      String symbol = getSymbolName(intRow, easyTypeEnum);
      if ('' != symbol) {
        SASStringService.appendToString(stringResult, symbol);
      } else {
        stringResult = symbol;
      }
    }
    return stringResult;
  }

  /// `加载函数`/////////////////////////////////////////////////////////////////

  void addRowModel(SABRowWordsModel rowModel) {
    _listRowModels.add(rowModel);
  }

  SABRowWordsModel rowModelAtRow(int intRow) {
    if (intRow > _listRowModels.length) {
      colog("intRow:$intRow");
    }
    return _listRowModels[intRow];
  }

  /// `桥函数`/////////////////////////////////////////////////////////////////
  ///此函数获取内卦变动的爻列表
  List inGuaMovementArray() {
    return inputDigitModel.inGuaMovementArray();
  }

  ///此函数获取外卦变动的爻列表
  List outGuaMovementArray() {
    return inputDigitModel.outGuaMovementArray();
  }
}
