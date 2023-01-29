import 'package:yourlucky/src/A_Context/SACContext.dart';
import 'package:yourlucky/src/A_Context/SACGlobal.dart';
import 'package:yourlucky/src/D_Business/Base/SABBaseModel.dart';
import 'package:yourlucky/src/D_Business/EasyLogic/BaseLogic/SABEasyLogicModel.dart';

import 'SABHealthDayModel.dart';
import 'SABHealthDiagramsModel.dart';
import 'SABHealthMonthModel.dart';
import 'SABHealthRowModel.dart';
import 'SABHealthSymbolModel.dart';

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

  void check() {
    inputLogicModel.check();
    diagramsModel.check();
    dayModel.check();
    monthModel.check();
    for (SABHealthRowModel row in _listRowModels) {
      row.check();
    }
    super.check();
  }

  double symbolHealthAtRow(int nRow, EasyTypeEnum easyType) {
    return rowModelAtRow(nRow).healthForEasyType(easyType);
  }

  SABHealthSymbolModel? symbol(int nRow, EasyTypeEnum easyType) {
    if (EasyTypeEnum.from == easyType) {
      return rowModelAtRow(nRow).fromSymbol;
    } else if (EasyTypeEnum.to == easyType) {
      return rowModelAtRow(nRow).toSymbol;
    } else if (EasyTypeEnum.hide == easyType) {
      return rowModelAtRow(nRow).hideSymbol;
    } else {
      return null;
    }
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
      coLog(StackTrace.current, LogTypeEnum.error, "intRow:$intRow");
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
