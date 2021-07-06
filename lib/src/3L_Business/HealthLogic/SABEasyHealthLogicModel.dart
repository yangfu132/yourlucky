import 'package:yourlucky/src/1L_Context/SACContext.dart';
import 'package:yourlucky/src/1L_Context/SACGlobal.dart';
import 'package:yourlucky/src/3L_Business/ExpertCategory/SABUsefulDeityModel.dart';
import 'package:yourlucky/src/3L_Business/HealthLogic/Health/SABHealthModel.dart';
import 'package:yourlucky/src/3L_Business/HealthLogic/SABRowHealthLogicModel.dart';

class SABEasyHealthLogicModel {
  SABEasyHealthLogicModel({
    required this.inputHealthModel,
    required this.usefulDeity,
  });
  final SABHealthModel inputHealthModel;

  //属性：用神的索引号
  final SABUsefulDeityModel usefulDeity;

  final _listRowModels = <SABRowHealthLogicModel>[];

  EmptyEnum getSymbolEmptyState(int intRow, EasyTypeEnum easyTypeEnum) {
    return rowModelAtRow(intRow).getSymbolEmptyState(easyTypeEnum);
  }

  bool getIsSymbolDayBroken(int intRow, EasyTypeEnum easyTypeEnum) {
    return rowModelAtRow(intRow).getIsSymbolDayBroken(easyTypeEnum);
  }

  MonthConflictEnum getConflictOnMonthState(
      int intRow, EasyTypeEnum easyTypeEnum) {
    return rowModelAtRow(intRow).getConflictOnMonthState(easyTypeEnum);
  }

  DayConflictEnum getConflictOnDayState(int intRow, EasyTypeEnum easyTypeEnum) {
    return rowModelAtRow(intRow).getConflictOnDayState(easyTypeEnum);
  }

  bool? getIsSymbolChangeEmpty(int intRow) {
    return rowModelAtRow(intRow).isSymbolChangeEmpty;
  }

  void setIsSymbolChangeEmpty(int intRow, bool bSymbolChangeEmpty) {
    rowModelAtRow(intRow).isSymbolChangeEmpty = bSymbolChangeEmpty;
  }

  String getDeity(int intRow, EasyTypeEnum easyType) {
    return rowModelAtRow(intRow).getDeity(easyType);
  }

  bool getIsSymbolBackMove(int intRow) {
    return rowModelAtRow(intRow).isSymbolBackMove;
  }

  /// `加载函数`/////////////////////////////////////////////////////////////////

  void addSymbol(SABRowHealthLogicModel rowModel) {
    _listRowModels.add(rowModel);
  }

  SABRowHealthLogicModel rowModelAtRow(int intRow) {
    if (intRow > _listRowModels.length) {
      colog("intRow:$intRow");
    }
    return _listRowModels[intRow];
  }
}
