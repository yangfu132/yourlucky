import 'package:your_lucky/src/A_Context/sac_context.dart';
import 'package:your_lucky/src/D_Business/Base/sab_base_model.dart';
import 'package:your_lucky/src/D_Business/EasyLogic/sab_easy_health_logic_model.dart';

import '../../A_Context/sac_global.dart';
import 'sab_easy_analysis_row_model.dart';

class SABEasyAnalysisModel extends SABBaseModel {
  SABEasyAnalysisModel(
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
      SABEasyAnalysisRowModel model =
          SABEasyAnalysisRowModel(inputHealthLogicModel.rowModelAtRow(intRow));
      listRowModels.add(model);
    }
    return listRowModels;
  }

  SABEasyAnalysisRowModel rowModelAtRow(int intRow) {
    if (intRow > _listRowModels.length) {
      coLog(StackTrace.current,LogTypeEnum.error,"intRow:$intRow");
    }
    return _rowModelsArray()[intRow];
  }
}
