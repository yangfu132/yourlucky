import 'package:your_lucky/src/D_Business/Base/sab_base_business.dart';
import 'package:your_lucky/src/D_Business/DigitModel/sab_easy_digit_model.dart';
import 'package:your_lucky/src/D_Business/EasyLogic/Health/sab_health_action_model.dart';
import 'package:your_lucky/src/D_Business/EasyLogic/Health/sab_health_sum_action_model.dart';

import '../../../A_Context/sac_context.dart';
import '../../../A_Context/sac_global.dart';
import '../BaseLogic/sab_easy_logic_model.dart';
import 'sab_health_model.dart';
import 'sab_health_origin_business.dart';
import 'sab_move_health_business.dart';

///静爻的强弱
class SABStaticHealthBusiness extends SABBaseBusiness {
  SABStaticHealthBusiness(this._inputEasyModel);

  late final SABMoveHealthBusiness _moveBusiness =
      SABMoveHealthBusiness(_inputEasyModel);
  final SABEasyDigitModel _inputEasyModel;

  ///Level:指的是OutRightEnum，Level4代指 rightTypeStatic
  void calculateHealthOfAllStaticRight(SABHealthModel tempHealthModel) {
    List arrayStatic =
        originBusiness().rowsAtOutRightLevel(OutRightEnum.rightTypeStatic);
    for (int nRow in arrayStatic) {
      if (tempHealthModel.diagramsModel.isUnFinish(nRow)) {
        calculateHealthOfStaticRightRow(
            tempHealthModel, nRow, EasyTypeEnum.from);
      }
    }
  }

  void calculateHealthOfStaticRightRow(
      SABHealthModel tempHealthModel,
      int nRow,
      EasyTypeEnum easyType) {

    List moveEffects = moveBusiness().effectingArrayAtMoveRightRow(nRow, easyType);
    if (moveEffects.isNotEmpty) {
      for (int effectsItem in moveEffects) {
        if (tempHealthModel.diagramsModel.isUnFinish(effectsItem)) {
          //TODO：calculateHealthOfStaticRightRow(tempHealthModel, effectsItem, easyType);
          coLog(StackTrace.current, LogTypeEnum.error, "此时不应该存在UnFinish的move");
        } //else cont.
        SABHealthSumActionModel sumActionModel = moveBusiness().adjustHealthAtRow(
            tempHealthModel, nRow, easyType, effectsItem, easyType);
        sumActionModel.targetModel.health = tempHealthModel.symbolHealthAtRow(nRow, easyType);
        final actionModel = SABHealthActionModel(nActionType:ActionTypeEnum.update,
            nRow:nRow,
            easyType: easyType,
            doubleHealth: sumActionModel.getResult(),
            sumActionList:[sumActionModel]);
        tempHealthModel.sumHealthAtRow(actionModel);
      } //end for
    } else {
      tempHealthModel.symbol(nRow, EasyTypeEnum.from)?.isBasicHealth = true;
    }
    tempHealthModel.diagramsModel.addToFinishArray(nRow);
  }

  bool isStaticRightLevelHasBeginRow(SABHealthModel tempHealthModel) {
    bool bHasBegin = false;
    List arrayLevel =
        originBusiness().rowsAtOutRightLevel(OutRightEnum.rightTypeStatic);
    if (arrayLevel.isNotEmpty) {
      for (int item in arrayLevel) {
        List arrayEffects = effectingArrayAtStaticRightRow(item, EasyTypeEnum.from);

        if (arrayEffects.isEmpty) {
          //这个分支是对的，下面那个分支可能永远也不会走到。因为在一个Level中，总会有不受同级生克的；而上一级对本级的生克已经计算完成。
          bHasBegin = true;
        } else {
          bool allFinish = true;
          for (int itemEffects in arrayEffects) {
            if (tempHealthModel.diagramsModel.isUnFinish(itemEffects)) {
              allFinish = false;
              break;
            } //else cont.
          } //end if

          if (allFinish) {
            bHasBegin = true;
          } //else cont.
        } //end if
      } //end for
    } else {
      bHasBegin = true;
    }

    return bHasBegin;
  }

  // double baseHealthAtStaticRightRow(
  //     SABHealthModel tempHealthModel, int nRow, EasyTypeEnum easyType) {
  //   double basicHealth =
  //       originBusiness().symbolBasicHealthAtRow(nRow, easyType);
  //
  //   List arrayEffectsInMoveRight = moveBusiness()
  //       .effectingArrayAtMoveRightRow(tempHealthModel, nRow, easyType);
  //
  //   for (int itemEffects in arrayEffectsInMoveRight) {
  //     if (tempHealthModel.diagramsModel.isUnFinish(itemEffects)) {
  //       moveBusiness().calculateHealthOfMoveRightRow(
  //           tempHealthModel, itemEffects, easyType);
  //     } else {
  //       SABHealthSumActionModel sumActionModel = moveBusiness().adjustHealthAtRow(
  //           tempHealthModel, nRow, easyType, itemEffects, easyType);
  //       sumActionModel.targetModel.health = basicHealth;
  //       basicHealth = sumActionModel.getResult();
  //     } //end if
  //   } //end for
  //
  //   return basicHealth;
  // }

  bool isEffectingStaticRightAtRow(int nEffectingRow, EasyTypeEnum easyType) {
    bool bResult = false;

    if (OutRightEnum.rightTypeStatic ==
        originBusiness().symbolOutRightAtRow(nEffectingRow, easyType)) {
      bResult = logicModel().isSeasonStrong(nEffectingRow, easyType);
    } else {
      coLog(StackTrace.current, LogTypeEnum.error, "error!");
    }
    return bResult;
  }

  List effectingArrayAtStaticRightRow(int nRow, EasyTypeEnum easyType) {
    List arrayEffects = [];
    String basicEarth = logicModel().getSymbolEarth(nRow, easyType);
    List staticArray = originBusiness().rowsAtOutRightLevel(OutRightEnum.rightTypeStatic);
    for (int itemRow in staticArray) {
      if (nRow != itemRow) {
        if (isEffectingStaticRightAtRow(itemRow, easyType)) {
          if (moveBusiness().isEffectingEarth(basicEarth, itemRow)) {
            arrayEffects.add(itemRow);
          } //else cont.
        } //else 日冲休囚静爻算是日破
      } //else cont.
    } //end for

    return arrayEffects;
  }

  ///`加载函数`//////////////////////////////////////////////////////
  ///
  SABHealthOriginBusiness originBusiness() {
    return moveBusiness().originBusiness();
  }

  SABMoveHealthBusiness moveBusiness() {
    return _moveBusiness;
  }

  SABEasyLogicModel logicModel() {
    return moveBusiness().logicModel();
  }
}
