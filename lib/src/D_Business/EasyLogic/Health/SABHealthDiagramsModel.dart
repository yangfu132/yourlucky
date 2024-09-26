import 'package:yourlucky/src/D_Business/Base/SABBaseModel.dart';
import 'package:yourlucky/src/D_Business/EasyLogic/BaseLogic/SABLogicDiagramsModel.dart';

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
      print("addToFinishArray: $nRow");
    }
  }

  bool isUnFinish(int nRow) {
    return -1 == _finishedList.indexOf(nRow);
  }
}
