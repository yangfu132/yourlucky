﻿import 'package:yourlucky/src/1L_Context/SACContext.dart';
import 'package:yourlucky/src/1L_Context/SACGlobal.dart';

import '../BaseLogic/SABEasyLogicModel.dart';
import 'SABRowHealthModel.dart';

class SABHealthModel {
  SABHealthModel({
    required this.inputLogicModel,
    required this.healthCritical,
    required this.monthHealth,
    required this.dayHealth,
    required this.listMoveRight,
  });
  final double monthHealth;
  final double dayHealth;

  final SABEasyLogicModel inputLogicModel;
  List listMoveRight;
  final double healthCritical;
  late final _finishedList = <int>[];
  late final _listRowModels = <SABRowHealthModel>[];
  late final bool hasBeginMoveRow;
  late final bool hasBeginStaticRow;

  bool bValidEasy() {
    return hasBeginMoveRow && hasBeginStaticRow;
  }

  double symbolHealthAtRow(int nRow, EasyTypeEnum easyType) {
    return rowModelAtRow(nRow).healthForEasyType(easyType);
  }

  OutRightEnum symbolOutRightAtRow(int nRow, EasyTypeEnum easyType) {
    if (EasyTypeEnum.from == easyType) {
      return rowModelAtRow(nRow).fromSymbol.outRight;
    } else if (EasyTypeEnum.to == easyType) {
      return rowModelAtRow(nRow).toSymbol.outRight;
    } else if (EasyTypeEnum.hide == easyType) {
      return rowModelAtRow(nRow).hideSymbol.outRight;
    } else {
      return OutRightEnum.RIGHT_NULL;
    }
  }

  void updateHealthAtRow(int nRow, double health) {
    return rowModelAtRow(nRow).setHealthForEasyType(EasyTypeEnum.from, health);
  }

  void addToFinishArray(int nRow) {
    if (-1 == _finishedList.indexOf(nRow)) {
      _finishedList.add(nRow);
      print("addToFinishArray: $nRow");
    }
  }

  List moveRightInArray(List arrayRow, easyType) {
    List listMoveRight = List.empty(growable: true);
    for (int intRow in arrayRow) {
      if (OutRightEnum.RIGHT_MOVE == symbolOutRightAtRow(intRow, easyType)) {
        listMoveRight.add(intRow);
      }

      /// else not add
    }

    /// end for
    return listMoveRight;
  }

  bool isUnFinish(int nRow) {
    return -1 == _finishedList.indexOf(nRow);
  }

  /// `加载函数`/////////////////////////////////////////////////////////////////

  SABRowHealthModel rowModelAtRow(int intRow) {
    if (intRow > _listRowModels.length) {
      colog("intRow:$intRow");
    }
    return _listRowModels[intRow];
  }

  void setRowModelAtRow(int intRow, SABRowHealthModel rowModel) {
    _listRowModels[intRow] = rowModel;
  }

  void addRowModel(SABRowHealthModel rowModel) {
    _listRowModels.add(rowModel);
  }
}
