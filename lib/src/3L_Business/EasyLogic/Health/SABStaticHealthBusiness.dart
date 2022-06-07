import 'package:yourlucky/src/3L_Business/Base/SABBaseBusiness.dart';

import '../../../1L_Context/SACContext.dart';
import '../../../1L_Context/SACGlobal.dart';
import '../BaseLogic/SABEasyLogicModel.dart';
import 'SABHealthModel.dart';
import 'SABHealthOriginBusiness.dart';
import 'SABMoveHealthBusiness.dart';

///静爻的强弱
class SABStaticHealthBusiness extends SABBaseBusiness {
  SABStaticHealthBusiness(this._inputLogicModel);

  late final SABMoveHealthBusiness _moveBusiness =
      SABMoveHealthBusiness(_inputLogicModel);
  final SABEasyLogicModel _inputLogicModel;

  ///Level:指的是OutRightEnum，Level4代指 RIGHT_STATIC
  void calculateHealthOfAllStaticRight(SABHealthModel tempHealthModel) {
    bool bHasBeginStatic = tempHealthModel.hasBeginStaticRow;
    List arrayStatic =
        originBusiness().rowArrayAtOutRightLevel(OutRightEnum.RIGHT_STATIC);
    for (int nRow in arrayStatic) {
      if (tempHealthModel.isUnFinish(nRow)) {
        if (bHasBeginStatic) {
          double doubleHealth = calculateHealthOfStaticRightRow(
              tempHealthModel, nRow, EasyTypeEnum.from);
          tempHealthModel.updateHealthAtRow(nRow, doubleHealth);
          tempHealthModel.addToFinishArray(nRow);
        } else {
          ///如果找不到开始row，就随便指定一个座位开始row；
          tempHealthModel.addToFinishArray(nRow);
        }
      }
    }
  }

  double calculateHealthOfStaticRightRow(
      SABHealthModel tempHealthModel, int nRow, EasyTypeEnum easyType) {
    double basicHealth = tempHealthModel.symbolHealthAtRow(nRow, easyType);
    List arrayEffectsInLevel4 = effectingArrayAtLevel4Row(nRow, easyType);

    for (int effectsItem in arrayEffectsInLevel4) {
      if (tempHealthModel.isUnFinish(effectsItem)) {
        basicHealth = calculateHealthOfStaticRightRow(
            tempHealthModel, effectsItem, easyType);
        tempHealthModel.updateHealthAtRow(nRow, basicHealth);
        tempHealthModel.addToFinishArray(nRow);
      }
      //else cont.

      basicHealth += moveBusiness().adjustHealthAtRow(
          tempHealthModel, nRow, easyType, effectsItem, easyType);
    } //end for
    return basicHealth;
  }

  bool isStaticRightLevelHasBeginRow(SABHealthModel tempHealthModel) {
    bool bHasBegin = false;
    List arrayLevel =
        originBusiness().rowArrayAtOutRightLevel(OutRightEnum.RIGHT_STATIC);
    if (arrayLevel.length > 0) {
      for (int item in arrayLevel) {
        List arrayEffects = effectingArrayAtLevel4Row(item, EasyTypeEnum.from);

        if (0 == arrayEffects.length) {
          //这个分支是对的，下面那个分支可能永远也不会走到。因为在一个Level中，总会有不受同级生克的；而上一级对本级的生克已经计算完成。
          bHasBegin = true;
        } else {
          bool allFinish = true;
          for (int itemEffects in arrayEffects) {
            if (tempHealthModel.isUnFinish(itemEffects)) {
              allFinish = false;
              break;
            }
            //else cont.
          } //endf

          if (allFinish) bHasBegin = true;
          //else cont.

        } //endi

      } //endf
    } else
      bHasBegin = true;

    return bHasBegin;
  }

  double baseHealthAtLevel4Row(
      SABHealthModel tempHealthModel, int nRow, EasyTypeEnum easyType) {
    double basicHealth =
        originBusiness().symbolBasicHealthAtRow(nRow, easyType);

    List arrayEffectsInLevel3 = moveBusiness()
        .effectingArrayAtLevel3Row(tempHealthModel, nRow, easyType);

    for (int itemEffects in arrayEffectsInLevel3) {
      if (tempHealthModel.isUnFinish(itemEffects)) {
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

    if (OutRightEnum.RIGHT_STATIC ==
        originBusiness().symbolOutRightAtRow(nEffectingRow, easyType)) {
      bResult = logicModel().isSeasonStrong(nEffectingRow, easyType);
    } else
      coLog("error!");

    return bResult;
  }

  List effectingArrayAtLevel4Row(int nRow, EasyTypeEnum easyType) {
    List arrayEffects = [];
    String basicEarth = logicModel().getSymbolEarth(nRow, easyType);

    List levelArray =
        originBusiness().rowArrayAtOutRightLevel(OutRightEnum.RIGHT_STATIC);

    for (int itemRow in levelArray) {
      if (nRow != itemRow) {
        if (isEffectingLevel4AtRow(itemRow, easyType)) {
          if (moveBusiness().isEffectingEarth(basicEarth, itemRow))
            arrayEffects.add(itemRow);
          //else cont.
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
    return _inputLogicModel;
  }
}
