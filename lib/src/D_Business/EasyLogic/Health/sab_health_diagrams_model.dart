import 'package:your_lucky/src/D_Business/Base/sab_base_model.dart';
import 'package:your_lucky/src/D_Business/EasyLogic/BaseLogic/sab_logic_diagrams_model.dart';

class SABHealthDiagramsModel extends SABBaseModel {
  SABHealthDiagramsModel({
    required this.logicModel,
    required this.healthCritical,
    required this.listMoveRight,
  });
  final SABLogicDiagramsModel logicModel;
  final double healthCritical;
  List<int> listMoveRight;
  late final _finishedList = <int>[];
  late final bool hasBeginMoveRow;
  late final bool hasBeginStaticRow;

  bool bValidEasy() {
    return hasBeginMoveRow && hasBeginStaticRow;
  }

  void addToFinishArray(int nRow) {
    if (-1 == _finishedList.indexOf(nRow)) {
      _finishedList.add(nRow);
      printMsg("addToFinishArray: $nRow");
    }
  }

  bool isUnFinish(int nRow) {
    return -1 == _finishedList.indexOf(nRow);
  }
}
