import 'package:your_lucky/src/A_Context/sac_context.dart';
import 'package:your_lucky/src/A_Context/sac_global.dart';
import 'package:your_lucky/src/D_Business/Base/sab_base_model.dart';
import 'package:your_lucky/src/D_Business/EasyLogic/BaseLogic/sab_easy_logic_model.dart';

import 'sab_health_diagrams_model.dart';
import 'sab_health_row_model.dart';
import 'sab_health_symbol_model.dart';

class SABHealthModel extends SABBaseModel {
  SABHealthModel({
    required this.inputLogicModel,
    required this.diagramsModel,
  });
  final SABEasyLogicModel inputLogicModel;
  final SABHealthDiagramsModel diagramsModel;

  late final _listRowModels = <SABHealthRowModel>[];

  void check() {
    inputLogicModel.check();
    diagramsModel.check();
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
      return OutRightEnum.rightTypeNull;
    }
  }

  void updateHealthAtRow(int nRow, double health) {
    rowModelAtRow(nRow).setHealthForEasyType(EasyTypeEnum.from, health);
  }

  List moveRightInArray(List arrayRow, easyType) {
    List listMoveRight = List.empty(growable: true);
    for (int intRow in arrayRow) {
      if (OutRightEnum.rightTypeMove == symbolOutRightAtRow(intRow, easyType)) {
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
