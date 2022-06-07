import 'package:yourlucky/src/A_Context/SACContext.dart';
import 'package:yourlucky/src/A_Context/SACGlobal.dart';
import 'package:yourlucky/src/D_Business/Base/SABBaseModel.dart';
import 'package:yourlucky/src/D_Business/EasyLogic/Health/SABHealthModel.dart';
import 'package:yourlucky/src/D_Business/EasyLogic/SABHealthLogicRowModel.dart';
import 'package:yourlucky/src/D_Business/Strategy/SABParentInfoModel.dart';

class SABEasyHealthLogicModel extends SABBaseModel {
  SABEasyHealthLogicModel({
    required this.inputHealthModel,
    required this.usefulDeity,
    required this.lifeHealthWithCritical,
    required this.usefulHealthWithCritical,
    required this.isUsefulDeityStrong,
    required this.isUsefulDeityChangeToRestricts,
    required this.isUsefulDeityChangeToConflict,
  });
  final SABHealthModel inputHealthModel;

  //属性：用神的索引号
  final SABParentInfoModel usefulDeity;

  final _listRowModels = <SABHealthLogicRowModel>[];

  final double lifeHealthWithCritical;
  final double usefulHealthWithCritical;
  final bool isUsefulDeityStrong;
  final bool isUsefulDeityChangeToRestricts;
  final bool isUsefulDeityChangeToConflict;

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

  void addSymbol(SABHealthLogicRowModel rowModel) {
    _listRowModels.add(rowModel);
  }

  SABHealthLogicRowModel rowModelAtRow(int intRow) {
    if (intRow > _listRowModels.length) {
      coLog("intRow:$intRow");
    }
    return _listRowModels[intRow];
  }
}
