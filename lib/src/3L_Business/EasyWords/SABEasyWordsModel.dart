import 'package:yourlucky/src/1L_Context/SACContext.dart';
import 'package:yourlucky/src/3L_Business/Base/SABBaseModel.dart';
import 'package:yourlucky/src/3L_Business/Diagrams/SABDiagramsModel.dart';
import 'package:yourlucky/src/3L_Business/DigitModel/SABEasyDigitModel.dart';
import 'package:yourlucky/src/3L_Business/Goal/SABGoalModel.dart';
import 'package:yourlucky/src/3L_Business/Time/SABDayModel.dart';
import 'package:yourlucky/src/3L_Business/Time/SABMonthModel.dart';
import 'package:yourlucky/src/4L_Service/SASStringService.dart';

import '../../1L_Context/SACGlobal.dart';
import 'SABWordsRowModel.dart';

class SABEasyWordsModel extends SABBaseModel {
  SABEasyWordsModel(
    this.inputDigitModel, {
    required this.monthModel,
    required this.dayModel,
    required this.goalModel,
    required this.elementOfUsefulDeity,
  });

  final SABEasyDigitModel inputDigitModel;
  final List _listRowModels = List.empty(growable: true);
  final String elementOfUsefulDeity;

  ///时间
  final SABMonthModel monthModel;
  final SABDayModel dayModel;
  final SABGoalModel goalModel;

  ///世应
  late final SABDiagramsModel diagramsModel = inputDigitModel.diagramsModel;
  late final int intLifeIndex = diagramsModel.lifeIndex;
  late final int intGoalIndex = diagramsModel.goalIndex;

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
    } //end for

    return arrayEarth;
  }

  /// `Get & Set函数`///////////////////////////////////////////////////////////
  ///

  ///此方法获取本卦的卦名
  String fromEasyName() {
    String stringResult = "";
    Map fromDict = diagramsModel.mapFromEasy;
    if (fromDict.isNotEmpty) {
      stringResult = fromDict["name"];
    }
    //else cont.

    return stringResult;
  }

  ///此方法获取变卦的卦名
  String toEasyName() {
    String stringResult = "";
    Map toDict = diagramsModel.mapToEasy;
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
      if (stringSymbolParent == this.inputDigitModel.strUsefulDeity) {
        parentArray.add(intRow);
      }
      //else cont.
    } //end for

    return parentArray;
  }

  String monthSkyEarth() {
    return monthModel.skyEarth();
  }

  String daySkyEarth() {
    return dayModel.skyEarth();
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

  String getEarlyPlace(int intRow, EasyTypeEnum easyTypeEnum) {
    return rowModelAtRow(intRow).getEarlyPlace(easyTypeEnum);
  }

  String getLatePlace(int intRow, EasyTypeEnum easyTypeEnum) {
    return rowModelAtRow(intRow).getLatePlace(easyTypeEnum);
  }

  String getLifeParent() {
    return getSymbolParent(intLifeIndex, EasyTypeEnum.from);
  }

  String getLifeName() {
    return getSymbolName(intLifeIndex, EasyTypeEnum.from);
  }

  String getGoalName() {
    return getSymbolName(intGoalIndex, EasyTypeEnum.from);
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

  void addRowModel(SABWordsRowModel rowModel) {
    _listRowModels.add(rowModel);
  }

  SABWordsRowModel rowModelAtRow(int intRow) {
    if (intRow > _listRowModels.length) {
      coLog("intRow:$intRow");
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
