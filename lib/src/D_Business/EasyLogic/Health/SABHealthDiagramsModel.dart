import 'package:yourlucky/src/D_Business/Base/SABBaseModel.dart';
import 'package:yourlucky/src/D_Business/EasyLogic/BaseLogic/SABLogicDiagramsModel.dart';

class SABHealthDiagramsModel extends SABBaseModel {
  SABHealthDiagramsModel({
    required this.logicModel,
    required this.healthCritical,
  });
  final SABLogicDiagramsModel logicModel;
  late final bool hasBeginMoveRow;
  late final bool hasBeginStaticRow;
  final double healthCritical;
  bool bValidEasy() {
    return hasBeginMoveRow && hasBeginStaticRow;
  }
}
