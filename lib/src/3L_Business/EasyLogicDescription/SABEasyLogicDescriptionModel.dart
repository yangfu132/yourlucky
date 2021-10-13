import 'package:yourlucky/src/1L_Context/SACContext.dart';
import 'package:yourlucky/src/3L_Business/EasyLogic/SABEasyHealthLogicModel.dart';

import '../../1L_Context/SACGlobal.dart';
import 'SABRowLogicDescriptionModel.dart';

class SABEasyLogicDescriptionModel {
  SABEasyLogicDescriptionModel(
    this.inputHealthLogicModel,
  );

  final SABEasyHealthLogicModel inputHealthLogicModel;

  late List _listRowModels = _initRowModelsArray();

  /// `Public`//////////////////////////////////////////////////////////////

  /// `Get & Set`//////////////////////////////////////////////////////////////
  String getMonthRelation(int intRow, EasyTypeEnum easyTypeEnum) {
    return rowModelAtRow(intRow).getMonthRelation(easyTypeEnum);
  }

  void setMonthRelation(
      int intRow, EasyTypeEnum easyTypeEnum, String stringMonthRelation) {
    rowModelAtRow(intRow).setMonthRelation(easyTypeEnum, stringMonthRelation);
  }

  String getDayRelation(int intRow, EasyTypeEnum easyTypeEnum) {
    return rowModelAtRow(intRow).getDayRelation(easyTypeEnum);
  }

  void setDayRelation(
      int intRow, EasyTypeEnum easyTypeEnum, String stringDayRelation) {
    rowModelAtRow(intRow).setDayRelation(easyTypeEnum, stringDayRelation);
  }

  void setSymbolRelation(int intRow, String stringParentRelation) {
    rowModelAtRow(intRow).setSymbolRelation(stringParentRelation);
  }

  void setMovementDescription(int intRow, String movementDescription) {
    rowModelAtRow(intRow).movementDescription = movementDescription;
  }

  String getEmptyDescription(int intRow, EasyTypeEnum easyTypeEnum) {
    return rowModelAtRow(intRow).getEmptyDescription(easyTypeEnum);
  }

  void setEmptyDescription(
      int intRow, EasyTypeEnum easyTypeEnum, String emptyDescription) {
    rowModelAtRow(intRow).setEmptyDescription(easyTypeEnum, emptyDescription);
  }

  /// `加载函数`/////////////////////////////////////////////////////////////////
  List _rowModelsArray() {
    return _listRowModels;
  }

  List _initRowModelsArray() {
    var listRowModels = [];
    for (int intRow = 0; intRow < 6; intRow++) {
      SABRowLogicDescriptionModel model = SABRowLogicDescriptionModel(
          inputHealthLogicModel.rowModelAtRow(intRow));
      listRowModels.add(model);
    }
    return listRowModels;
  }

  SABRowLogicDescriptionModel rowModelAtRow(int intRow) {
    if (intRow > _listRowModels.length) {
      colog("intRow:$intRow");
    }
    return _rowModelsArray()[intRow];
  }
}
