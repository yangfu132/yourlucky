import 'package:your_lucky/src/D_Business/Base/sab_base_business.dart';
import 'package:your_lucky/src/D_Business/DigitModel/sab_easy_digit_model.dart';
import 'package:your_lucky/src/D_Business/EasyLogic/Health/sab_health_action_model.dart';
import 'package:your_lucky/src/D_Business/EasyLogic/Health/sab_health_symbol_model.dart';

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
    bool bHasBeginStatic = tempHealthModel.diagramsModel.hasBeginStaticRow;
    List arrayStatic =
        originBusiness().rowArrayAtOutRightLevel(OutRightEnum.rightTypeStatic);
    for (int nRow in arrayStatic) {
      if (tempHealthModel.diagramsModel.isUnFinish(nRow)) {
        if (bHasBeginStatic) {
          double doubleHealth = calculateHealthOfStaticRightRow(
              tempHealthModel, nRow, EasyTypeEnum.from);
          SABHealthActionModel actionModel = SABHealthActionModel(nRow:nRow,
            easyType: EasyTypeEnum.from,
            doubleHealth: doubleHealth,
          );
          tempHealthModel.updateHealthAtRow(actionModel);
          // tempHealthModel.updateHealthAtRow(nRow, doubleHealth);
          tempHealthModel.diagramsModel.addToFinishArray(nRow);
        } else {
          ///如果找不到开始row，就随便指定一个座位开始row；
          tempHealthModel.diagramsModel.addToFinishArray(nRow);
        }
      }
    }
  }

  double calculateHealthOfStaticRightRow(
      SABHealthModel tempHealthModel,
      int nRow,
      EasyTypeEnum easyType) {

    List arrayEffectsInLevel4 = effectingArrayAtLevel4Row(nRow, easyType);
    for (int effectsItem in arrayEffectsInLevel4) {
      if (tempHealthModel.diagramsModel.isUnFinish(effectsItem)) {
        calculateHealthOfStaticRightRow(tempHealthModel, effectsItem, easyType);
      } //else cont.

      double adjustHealth = moveBusiness().adjustHealthAtRow(
          tempHealthModel, nRow, easyType, effectsItem, easyType);
      SABHealthActionModel actionModel = SABHealthActionModel(nRow:nRow,
        easyType: EasyTypeEnum.from,
        doubleHealth: adjustHealth,
      );
      tempHealthModel.sumHealthAtRow(actionModel);
    } //end for

    tempHealthModel.diagramsModel.addToFinishArray(nRow);
    return tempHealthModel.symbolHealthAtRow(nRow, easyType);
  }

  bool isStaticRightLevelHasBeginRow(SABHealthModel tempHealthModel) {
    bool bHasBegin = false;
    List arrayLevel =
        originBusiness().rowArrayAtOutRightLevel(OutRightEnum.rightTypeStatic);
    if (arrayLevel.isNotEmpty) {
      for (int item in arrayLevel) {
        List arrayEffects = effectingArrayAtLevel4Row(item, EasyTypeEnum.from);

        if (arrayEffects.isEmpty) {
          //这个分支是对的，下面那个分支可能永远也不会走到。因为在一个Level中，总会有不受同级生克的；而上一级对本级的生克已经计算完成。
          bHasBegin = true;
        } else {
          bool allFinish = true;
          for (int itemEffects in arrayEffects) {
            if (tempHealthModel.diagramsModel.isUnFinish(itemEffects)) {
              allFinish = false;
              break;
            }
            //else cont.
          } //endf

          if (allFinish) bHasBegin = true;
          //else cont.

        } //endi

      } //endf
    } else {
      bHasBegin = true;
    }

    return bHasBegin;
  }

  double baseHealthAtLevel4Row(
      SABHealthModel tempHealthModel, int nRow, EasyTypeEnum easyType) {
    double basicHealth =
        originBusiness().symbolBasicHealthAtRow(nRow, easyType);

    List arrayEffectsInLevel3 = moveBusiness()
        .effectingArrayAtLevel3Row(tempHealthModel, nRow, easyType);

    for (int itemEffects in arrayEffectsInLevel3) {
      if (tempHealthModel.diagramsModel.isUnFinish(itemEffects)) {
        moveBusiness().calculateHealthOfMoveRightRow(
            tempHealthModel, itemEffects, easyType);
      } else {
        basicHealth += moveBusiness().adjustHealthAtRow(
            tempHealthModel, nRow, easyType, itemEffects, easyType);
      } //endi
    } //endf

    return basicHealth;
  }

  bool isEffectingLevel4AtRow(int nEffectingRow, EasyTypeEnum easyType) {
    bool bResult = false;

    if (OutRightEnum.rightTypeStatic ==
        originBusiness().symbolOutRightAtRow(nEffectingRow, easyType)) {
      bResult = logicModel().isSeasonStrong(nEffectingRow, easyType);
    } else {
      coLog(StackTrace.current, LogTypeEnum.error, "error!");
    }
    return bResult;
  }

  List effectingArrayAtLevel4Row(int nRow, EasyTypeEnum easyType) {
    List arrayEffects = [];
    String basicEarth = logicModel().getSymbolEarth(nRow, easyType);

    List levelArray =
        originBusiness().rowArrayAtOutRightLevel(OutRightEnum.rightTypeStatic);

    for (int itemRow in levelArray) {
      if (nRow != itemRow) {
        if (isEffectingLevel4AtRow(itemRow, easyType)) {
          if (moveBusiness().isEffectingEarth(basicEarth, itemRow)) {
            arrayEffects.add(itemRow);
          } //else cont.
        }
        //else 日冲休囚静爻算是日破
      }
      //else cont.

    } //endf

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
