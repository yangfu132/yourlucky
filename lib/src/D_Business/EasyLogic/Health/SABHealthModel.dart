﻿import 'package:yourlucky/src/A_Context/SACContext.dart';
import 'package:yourlucky/src/A_Context/SACGlobal.dart';
import 'package:yourlucky/src/D_Business/Base/SABBaseModel.dart';
import 'package:yourlucky/src/D_Business/EasyLogic/BaseLogic/SABEasyLogicModel.dart';

import 'SABHealthDayModel.dart';
import 'SABHealthDiagramsModel.dart';
import 'SABHealthMonthModel.dart';
import 'SABHealthRowModel.dart';

class SABHealthModel extends SABBaseModel {
  SABHealthModel({
    required this.inputLogicModel,
    required this.diagramsModel,
    required this.monthModel,
    required this.dayModel,
  });
  final SABEasyLogicModel inputLogicModel;
  final SABHealthDiagramsModel diagramsModel;
  final SABHealthDayModel dayModel;
  final SABHealthMonthModel monthModel;

  late final _listRowModels = <SABHealthRowModel>[];

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
    rowModelAtRow(nRow).setHealthForEasyType(EasyTypeEnum.from, health);
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

  /// `加载函数`/////////////////////////////////////////////////////////////////

  SABHealthRowModel rowModelAtRow(int intRow) {
    if (intRow > _listRowModels.length) {
      coLog("intRow:$intRow");
    }
    return _listRowModels[intRow];
  }

  void setRowModelAtRow(int intRow, SABHealthRowModel rowModel) {
    _listRowModels[intRow] = rowModel;
  }

  void addRowModel(SABHealthRowModel rowModel) {
    _listRowModels.add(rowModel);
  }
}
