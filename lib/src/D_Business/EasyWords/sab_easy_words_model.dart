import 'package:your_lucky/src/A_Context/sac_context.dart';
import 'package:your_lucky/src/D_Business/Base/sab_base_model.dart';
import 'package:your_lucky/src/D_Business/DigitModel/sab_easy_digit_model.dart';
import 'package:your_lucky/src/D_Business/EasyWords/sab_day_model.dart';
import 'package:your_lucky/src/D_Business/EasyWords/sab_month_model.dart';
import 'package:your_lucky/src/E_Service/sas_string_service.dart';

import '../../A_Context/sac_global.dart';
import 'sab_words_row_model.dart';

class SABEasyWordsModel extends SABBaseModel {
  SABEasyWordsModel(
    this.inputDigitModel, {
    required this.monthModel,
    required this.dayModel,
  });

  final SABEasyDigitModel inputDigitModel;
  final SABMonthModel monthModel;
  final SABDayModel dayModel;
  final List<SABWordsRowModel> _listRowModels = List.empty(growable: true);

  @override void check() {
    inputDigitModel.check();
    monthModel.check();
    dayModel.check();
    for (SABWordsRowModel row in _listRowModels) {
      row.check();
    }
    super.check();
  }

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
    } else if (globalRowChangeBegin <= intRow && intRow < globalRowChangeEnd) {
      stringResult = getSymbolName(intRow - globalRowChangeBegin, EasyTypeEnum.to);
    } else if (globalRowFlyBegin <= intRow && intRow < globalRowFlyEnd) {
      stringResult = getSymbolName(intRow - globalRowFlyBegin, EasyTypeEnum.hide);
    }
    //else cont.

    return stringResult;
  }

  EasyTypeEnum easyTypeOfMergeRow(int intRow) {
    EasyTypeEnum enumResultType = EasyTypeEnum.typeNull;
    if (0 <= intRow && intRow < 6) {
      enumResultType = EasyTypeEnum.from;
    } else if (globalRowChangeBegin <= intRow && intRow < globalRowChangeEnd) {
      enumResultType = EasyTypeEnum.to;
    } else if (globalRowFlyBegin <= intRow && intRow < globalRowFlyEnd) {
      enumResultType = EasyTypeEnum.hide;
    }
    //else cont.

    return enumResultType;
  }

  String earthAtMergeRow(int intRow) {
    String stringResult = "";
    if (0 <= intRow && intRow < 6) {
      stringResult = getSymbolEarth(intRow, EasyTypeEnum.from);
    } else if (globalRowChangeBegin <= intRow && intRow < globalRowChangeEnd) {
      stringResult = getSymbolEarth(intRow - globalRowChangeBegin, EasyTypeEnum.to);
    } else if (globalRowFlyBegin <= intRow && intRow < globalRowFlyEnd) {
      stringResult = getSymbolEarth(intRow - globalRowFlyBegin, EasyTypeEnum.hide);
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

  int getLifeIndex() {
    return inputDigitModel.diagramsModel.lifeIndex;
  }

  int getGoalIndex() {
    return inputDigitModel.diagramsModel.goalIndex;
  }

  ///此方法获取本卦的卦名
  String getFromEasyName() {
    return inputDigitModel.diagramsModel.stringFromName;
  }

  ///此方法获取变卦的卦名
  String getToEasyName() {
    return inputDigitModel.diagramsModel.stringToName;
  }

  int getDigit(int nRow) {
    return inputDigitModel.getDigit(nRow);
  }

  String getAnimal(int intRow) {
    return rowModelAtRow(intRow).fromSymbol.stringAnimal;
  }

  String getDiagrams(int intRow) {
    return rowModelAtRow(intRow).fromSymbol.stringDiagrams;
  }

  List arrayFromRowOfParent(String parent) {
    return arrayRowWithParent(parent, EasyTypeEnum.from);
  }

  List arrayRowWithParent(String parent, EasyTypeEnum easyType) {
    List parentArray = List.empty(growable: true);

    for (int intRow = 0; intRow < 6; intRow++) {
      String stringSymbolParent = getSymbolParent(intRow, easyType);
      if (stringSymbolParent == parent) {
        parentArray.add(intRow);
      } //else {}
    } //end for

    return parentArray;
  }

  List arrayRowWithElement(String element, EasyTypeEnum easyType) {
    List resultArray = List.empty(growable: true);

    for (int intRow = 0; intRow < 6; intRow++) {
      String symbolElement = getSymbolElement(intRow, easyType);
      if (symbolElement == element) {
        resultArray.add(intRow);
      }
      //else cont.
    } //endf

    return resultArray;
  }

  List arrayUsefulRow(EasyTypeEnum easyType) {
    List parentArray = List.empty(growable: true);

    for (int intRow = 0; intRow < 6; intRow++) {
      String stringSymbolParent = getSymbolParent(intRow, easyType);
      if (stringSymbolParent == inputDigitModel.strUsefulDeity) {
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
    return rowModelAtRow(intRow).isMovement();
  }

  String getSymbolName(int intRow, EasyTypeEnum easyType) {
    return rowModelAtRow(intRow).getSymbolName(easyType);
  }

  String getSymbolParent(int intRow, EasyTypeEnum easyType) {
    return rowModelAtRow(intRow).getSymbolParent(easyType);
  }

  String getSymbolEarth(int intRow, EasyTypeEnum easyType) {
    return rowModelAtRow(intRow).getSymbolEarth(easyType);
  }

  String getSymbolElement(int intRow, EasyTypeEnum easyType) {
    return rowModelAtRow(intRow).getSymbolElement(easyType);
  }

  String getEarlyPlace(int intRow, EasyTypeEnum easyType) {
    return rowModelAtRow(intRow).getEarlyPlace(easyType);
  }

  String getLatePlace(int intRow, EasyTypeEnum easyType) {
    return rowModelAtRow(intRow).getLatePlace(easyType);
  }

  String getLifeParent() {
    return getSymbolParent(getLifeIndex(), EasyTypeEnum.from);
  }

  String getLifeName() {
    return getSymbolName(getLifeIndex(), EasyTypeEnum.from);
  }

  String getGoalName() {
    return getSymbolName(getGoalIndex(), EasyTypeEnum.from);
  }

  String getLifeElement() {
    return getSymbolElement(getLifeIndex(), EasyTypeEnum.from);
  }

  String getLifeAnimal() {
    return getAnimal(getLifeIndex());
  }

  String getLifeDiagrams() {
    return getDiagrams(getLifeIndex());
  }

  String stringFromSymbolArray(List hideArray, EasyTypeEnum easyType) {
    String stringResult = "";
    for (int intRow in hideArray) {
      String symbol = getSymbolName(intRow, easyType);
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
      coLog(StackTrace.current, LogTypeEnum.error, "intRow:$intRow");
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
