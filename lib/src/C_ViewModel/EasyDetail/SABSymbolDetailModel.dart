import 'package:yourlucky/src/A_Context/SACContext.dart';
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
      coLog("symbolHealthDes.isEmpty");
    }
    if (monthRelation.isEmpty) {
      coLog("monthRelation.isEmpty");
    }
    if (dayRelation.isEmpty) {
      coLog("dayRelation.isEmpty");
    }
    super.check();
  }
}
