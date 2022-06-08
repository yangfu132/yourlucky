import 'package:yourlucky/src/D_Business/Base/SABBaseBusiness.dart';
import 'package:yourlucky/src/D_Business/EasyLogic/BaseLogic/SABEasyLogicModel.dart';

import '../../../A_Context/SACGlobal.dart';
import 'SABHealthModel.dart';
import 'SABHealthOriginBusiness.dart';
import 'SABMoveHealthBusiness.dart';
import 'SABStaticHealthBusiness.dart';

class SABEasyHealthBusiness extends SABBaseBusiness {
  SABEasyHealthBusiness(this._inputLogicModel);
  final SABEasyLogicModel _inputLogicModel;

  late final SABStaticHealthBusiness _staticBusiness =
      SABStaticHealthBusiness(_inputLogicModel);

  late final SABHealthModel _outHealthModel = initHealthModel();

  SABHealthModel calculateHealth(SABHealthModel tempHealthModel) {
    // 找到不受生克的动爻，如果找不到这个卦就没办法解开，最好重新占卜，这叫做乱动；
    // 子丑寅卯辰巳午未申酉戌亥，扣除旬空与日临，也可以形成闭环，比如：
    // 甲子月 甲子日 子 寅 巳 未 酉
    //备注：这句话应该是程序实现时的定义，将乱动对应到程序实现时，出现的查询方法；

    //  月破、日破都不能形成这样的条件，因为：
    //  月破；月破的爻在月支上的health为0，依然可以起到生克作用，但是力量非常弱。
    //  日破，对health没有影响，对right的影响与日冲是一样的。

    isValidEasy(tempHealthModel);
    List arrayMoveRightRow = originBusiness().rowArrayAtOutRightLevel(
      OutRightEnum.RIGHT_MOVE,
    );
    moveBusiness().calculateHealthOfAllMoveRight(
      tempHealthModel,
      arrayMoveRightRow,
    );
    List<int> conflictMove = updateDayConflictOutRight(tempHealthModel);
    moveBusiness().calculateHealthOfAllMoveRight(tempHealthModel, conflictMove);
    tempHealthModel.listMoveRight =
        rowArrayAtOutRightLevel(OutRightEnum.RIGHT_MOVE);
    staticBusiness().calculateHealthOfAllStaticRight(tempHealthModel);
    return tempHealthModel;
  }

  List<int> updateDayConflictOutRight(SABHealthModel tempHealthModel) {
    final resultRow = <int>[];
    final rowList = originBusiness()
        .rowArrayAtOutRightLevel(OutRightEnum.RIGHT_Day_Conflict);
    for (final intRow in rowList) {
      double fHealth =
          tempHealthModel.symbolHealthAtRow(intRow, EasyTypeEnum.from);

      if (fHealth > tempHealthModel.diagramsModel.healthCritical) {
        tempHealthModel.rowModelAtRow(intRow).fromSymbol.outRight =
            OutRightEnum.RIGHT_MOVE;
        resultRow.add(intRow);
      } else {
        tempHealthModel.rowModelAtRow(intRow).fromSymbol.outRight =
            OutRightEnum.RIGHT_STATIC;
      }
    }
    return resultRow;
  }

  bool isValidEasy(SABHealthModel tempHealthModel) {
    tempHealthModel.diagramsModel.hasBeginMoveRow =
        moveBusiness().isMoveRightLevelHasBeginRow(tempHealthModel);
    tempHealthModel.diagramsModel.hasBeginStaticRow =
        staticBusiness().isStaticRightLevelHasBeginRow(tempHealthModel);
    return tempHealthModel.diagramsModel.bValidEasy();
  }

  ///`SABEasyHealthDelegate`

  List rowArrayAtOutRightLevel(OutRightEnum level) {
    return originBusiness().rowArrayAtOutRightLevel(level);
  }

  ///`加载函数`
  SABHealthModel outHealthModel1() {
    return _outHealthModel;
  }

  SABHealthModel initHealthModel() {
    SABHealthModel healthModel = originBusiness().outputHealthModel();
    calculateHealth(healthModel);
    return healthModel;
  }

  SABEasyLogicModel logicModel() {
    return _inputLogicModel;
  }

  SABStaticHealthBusiness staticBusiness() {
    return _staticBusiness;
  }

  SABMoveHealthBusiness moveBusiness() {
    return staticBusiness().moveBusiness();
  }

  SABHealthOriginBusiness originBusiness() {
    return moveBusiness().originBusiness();
  }
}
