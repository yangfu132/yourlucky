import 'package:yourlucky/src/A_Context/SACContext.dart';
import 'package:yourlucky/src/A_Context/SACGlobal.dart';
import 'package:yourlucky/src/D_Business/Base/SABBaseModel.dart';

class SABSymbolDetailModel extends SABBaseModel {
  SABSymbolDetailModel(
      {required this.symbolHealthDes,
      required this.monthRelation,
      required this.dayRelation});
  final String symbolHealthDes;

  final String monthRelation;

  final String dayRelation;
  void check() {
    if (symbolHealthDes.isEmpty) {
      coLog(StackTrace.current, LogTypeEnum.check, "symbolHealthDes.isEmpty");
    }
    if (monthRelation.isEmpty) {
      coLog(StackTrace.current, LogTypeEnum.check, "monthRelation.isEmpty");
    }
    if (dayRelation.isEmpty) {
      coLog(StackTrace.current, LogTypeEnum.check, "dayRelation.isEmpty");
    }
    super.check();
  }
}
