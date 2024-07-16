import 'package:your_lucky/src/D_Business/Base/sab_base_business.dart';
import 'package:your_lucky/src/D_Business/DigitModel/sab_easy_digit_model.dart';
import 'package:your_lucky/src/D_Business/EarthBranch/sab_earth_branch_business.dart';
import 'package:your_lucky/src/D_Business/EasyLogic/Health/sab_health_action_model.dart';
import 'package:your_lucky/src/D_Business/EasyLogic/Health/sab_health_sum_action_model.dart';
import 'package:your_lucky/src/D_Business/EasyLogic/Health/sab_health_sum_addend_model.dart';
import 'package:your_lucky/src/D_Business/EasyLogic/Health/sab_health_sum_target_model.dart';
import 'package:your_lucky/src/D_Business/EasyWords/sab_easy_words_model.dart';

import '../../../A_Context/sac_context.dart';
import '../../../A_Context/sac_global.dart';
import '../BaseLogic/sab_easy_logic_model.dart';
import 'sab_health_model.dart';
import 'sab_health_origin_business.dart';

///动爻的强弱计算
class SABMoveHealthBusiness extends SABBaseBusiness {
  SABMoveHealthBusiness(this._inputEasyModel);

  late final SABHealthOriginBusiness _originBusiness =
      SABHealthOriginBusiness(_inputEasyModel);
  final SABEasyDigitModel _inputEasyModel;

  late final SABEarthBranchBusiness _branchBusiness = SABEarthBranchBusiness();

  void calculateHealthOfAllMoveRight(SABHealthModel healthModel, List listRow) {
    bool hasBegin = healthModel.diagramsModel.hasBeginMoveRow;
    for (int nRow in listRow) {
      if (healthModel.diagramsModel.isUnFinish(nRow)) {
        if (hasBegin) {
          calculateHealthOfMoveRightRow(healthModel, nRow, EasyTypeEnum.from);
        } else {
          if (wordsModel().isMovementAtRow(nRow)) {
            moveSymbolBasicHealthAtRow(healthModel, nRow);
          } //else {}
        } //end if
      } //else {}
    } //end for
  }

  //calculateHealthOfAllMoveRightRow
  SABHealthActionModel calculateHealthOfMoveRightRow(
      SABHealthModel tempHealthModel, int nRow, EasyTypeEnum easyType) {
    double moveHealth = 0;
    if (wordsModel().isMovementAtRow(nRow)) {
      moveHealth = moveSymbolBasicHealthAtRow(tempHealthModel, nRow);
    } else {
      moveHealth = originBusiness().symbolBasicHealthAtRow(nRow, easyType);
    } //end if

    List arrayEffects = effectingArrayAtMoveRightRow(tempHealthModel, nRow, easyType);

    List<SABHealthSumActionModel> sumActionList = <SABHealthSumActionModel>[];
    for (int effectsItem in arrayEffects) {
      if (tempHealthModel.diagramsModel.isUnFinish(effectsItem)) {
        calculateHealthOfMoveRightRow(tempHealthModel, effectsItem, easyType);
      }
      //else cont.

      SABHealthSumActionModel sumActionModel =  adjustHealthAtRow(
          tempHealthModel, nRow, easyType, effectsItem, easyType);
      sumActionModel.targetModel.health = moveHealth;
      moveHealth = sumActionModel.getResult();
      arrayEffects.add(sumActionModel);
    } //end for

    SABHealthActionModel actionModel = SABHealthActionModel(nActionType:ActionTypeEnum.update,
        nRow:nRow,
        easyType: easyType,
        doubleHealth: moveHealth,
        sumActionList:sumActionList
    );
    tempHealthModel.updateHealthAtRow(actionModel);
    tempHealthModel.diagramsModel.addToFinishArray(nRow);
    return actionModel;
  }

  SABHealthSumActionModel adjustHealthAtRow(SABHealthModel tempHealthModel,
      int basicRow,
      EasyTypeEnum baseEasyType,
      int effectsRow,
      EasyTypeEnum effectsEasyType) {

     SABDefensiveModel basicDefenseModel =
     originBusiness().symbolDefensiveAtRow(basicRow, baseEasyType);
     SABHealthSumTargetModel targetModel = SABHealthSumTargetModel(
       nRow: basicRow,
       easyType: baseEasyType,
       symbolEarth:logicModel().getSymbolEarth(basicRow, baseEasyType),
       defenseModel:basicDefenseModel,
     );

     SABOutModel outModel = symbolOutAtRow(tempHealthModel,basicRow, effectsRow, effectsEasyType);
     SABHealthSumAddendModel addendModel = SABHealthSumAddendModel(
       nRow: effectsRow,
       easyType: effectsEasyType,
       symbolEarth:logicModel().getSymbolEarth(effectsRow, effectsEasyType),
       outModel: outModel,
     );

     String basicEarth = logicModel().getSymbolEarth(basicRow, EasyTypeEnum.from);
     String effectsEarth = logicModel().getSymbolEarth(effectsRow, effectsEasyType);
     bool isEarthAddendBornTarget = _branchBusiness.isEarthBorn(effectsEarth, basicEarth);
     bool isEarthAddendRestrictsTarget = _branchBusiness.isEarthRestricts(effectsEarth, basicEarth);
     SABHealthSumActionModel  sumModel = SABHealthSumActionModel(
       targetModel:targetModel,
       addendModel:addendModel,
       isEarthAddendBornTarget:isEarthAddendBornTarget,
       isEarthAddendRestrictsTarget:isEarthAddendRestrictsTarget,
     );

    return sumModel;
  }

  SABOutModel symbolOutAtRow(
      SABHealthModel tempHealthModel,
      int targetRow,
      int nOutRow,
      EasyTypeEnum outEasyType) {

    SABOutModel outModel = originBusiness().conversionRateAtRow(targetRow,nOutRow, outEasyType);
    if (EasyTypeEnum.to == outEasyType) {
      outModel.health = symbolBasicHealthAtRow(nOutRow);
    } else if (EasyTypeEnum.from == outEasyType) {
      if (!tempHealthModel.diagramsModel.isUnFinish(nOutRow)) {
        outModel.health = tempHealthModel.symbolHealthAtRow(nOutRow, outEasyType);
      } else {
        coLog(StackTrace.current, LogTypeEnum.remark, "这种情况如何处理？");
      }
    } else if (EasyTypeEnum.hide == outEasyType) {
      outModel.health = symbolBasicHealthAtRow(nOutRow);
    } else {
      coLog(StackTrace.current, LogTypeEnum.error, "error!");
    }
    return outModel;
  }

  ///`变爻的health`//////////////////////////////////////////////////////

  double symbolBasicHealthAtRow(int nRow) {
    return originBusiness().symbolBasicHealthAtRow(nRow, EasyTypeEnum.to);
  }

  ///`动爻的基本值`//////////////////////////////////////////////////////

  ///动爻的基本值----------------------------------------------
  // 基础值加上变爻的生克
  double moveSymbolBasicHealthAtRow(SABHealthModel tempHealthModel, int nRow) {
    double fResult = originBusiness().symbolBasicHealthAtRow(nRow, EasyTypeEnum.from);
    List<SABHealthSumActionModel> sumActionList = <SABHealthSumActionModel>[];
    if (isSymbolEffectableAtRow(nRow, EasyTypeEnum.from)) {
      SABHealthSumActionModel sumActionModel = adjustHealthAtRow(
          tempHealthModel, nRow, EasyTypeEnum.from, nRow, EasyTypeEnum.to);
      sumActionModel.targetModel.health = fResult;
      fResult = sumActionModel.getResult();
      sumActionList.add(sumActionModel);
    } //else cont.

    SABHealthActionModel actionModel = SABHealthActionModel(nActionType:ActionTypeEnum.update,
      nRow:nRow,
      easyType: EasyTypeEnum.from,
      doubleHealth: fResult,
      sumActionList:sumActionList,
    );
    tempHealthModel.updateHealthAtRow(actionModel);
    tempHealthModel.diagramsModel.addToFinishArray(nRow);
    return fResult;
  }

  bool isSymbolEffectableAtRow(int nRow, EasyTypeEnum easyType) {
    /*
     不受生克有以下几种情况:
     1、旬空；旬空的爻，health不变，但在生克上不起作用，但是在判断时机上起作用；
     2、日临月临：health无限大，不受生克冲合的影响。
     3、日合：health保持不变，但是对动爻的生克权有影响。
     最后、没有爻生克这个爻，或者没有1、2、3爻以外的爻影响；

     其中旬空、日合改变防御值与right，日临月临改变防御值与health，；
     */
    bool bResult = false;
    bResult =
        globalMaxDefensive != originBusiness().symbolDefensiveAtRow(nRow, easyType);
    return bResult;
  }

  bool isEffectingEarth(String basicEarth, int itemRow) {
    bool bResult = false;
    String earth = wordsModel().getSymbolEarth(itemRow, EasyTypeEnum.from);
    if (_branchBusiness.isEarthBorn(earth, basicEarth)) {
      bResult = true;
    } else if (_branchBusiness.isEarthRestricts(earth, basicEarth)) {
      bResult = true;
    }
    //else cont.

    return bResult;
  }

  List effectingArrayAtMoveRightRow(
      SABHealthModel tempHealthModel, int basicRow, EasyTypeEnum easyType) {
    List arrayEffects = [];
    final symbol = logicModel().symbolAtRow(basicRow, easyType);
    ///TODO:yangfu132为了找到分析的开头，假设globalMaxDefensive的爻不受其他爻生克的;
    if (symbol.defensive() != globalMaxDefensive) {
      String basicEarth = logicModel().getSymbolEarth(basicRow, easyType);
      List moveRightArray =
          originBusiness().rowArrayAtOutRightLevel(OutRightEnum.rightTypeMove);
      for (int itemRow in moveRightArray) {
        if (basicRow != itemRow) {
          if (isEffectingEarth(basicEarth, itemRow)) {
            arrayEffects.add(itemRow);
          } //else cont.
        }//else cont.
      } //end for
    } // else cont.

    return arrayEffects;
  }

  bool isLevel6EffectableAtRow(int nRow, EasyTypeEnum easyType) {
    bool bResult = false;
    //TODO:yangfu132除了动爻，静爻可以生克伏神吗？
    //TODO:yangfu132除了旬空的不可以生克伏神，还有别的不可以生克伏神吗？
    final symbol = logicModel().rowModelAtRow(nRow).symbolModel(easyType);
    if (null != symbol) {
      bResult = !symbol.isEmpty();
    }

    return bResult;
  }

  List effectingArrayAtLevel6Row(int nRow, EasyTypeEnum easyType) {
    List arrayEffects = [];

    String basicEarth = logicModel().getSymbolEarth(nRow, easyType);

    List levelArray =
        originBusiness().rowArrayAtOutRightLevel(OutRightEnum.rightTypeMove);
    levelArray.add(nRow);

    for (int itemRow in levelArray) {
      if (isLevel6EffectableAtRow(itemRow, EasyTypeEnum.from)) {
        if (isEffectingEarth(basicEarth, itemRow)) arrayEffects.add(itemRow);
        //else cont.
      }
      //else cont.

    } //endf

    return arrayEffects;
  }

  bool isEffectingMoveRightAtRow(SABHealthModel tempHealthModel, int nEffectingRow,
      EasyTypeEnum easyType) {
    bool bResult = false;

    if (EasyTypeEnum.from == easyType) {
      //明动爻对其它爻都有生克权
      if (wordsModel().isMovementAtRow(nEffectingRow)) {
        bResult = logicModel().isEffectAble(nEffectingRow, easyType);
      } else {
        //被日冲的爻只有在strong时才是暗动，才能生克动爻
        bResult = logicModel().isEffectAble(nEffectingRow, easyType);
      }
    } else {
      coLog(StackTrace.current, LogTypeEnum.error, "error!");
    } //end if
    return bResult;
  }

  bool isMoveRightLevelHasBeginRow(SABHealthModel tempHealthModel) {
    bool bHasBegin = false;
    List arrayMoveRightRow =
        originBusiness().rowArrayAtOutRightLevel(OutRightEnum.rightTypeMove);
    if (arrayMoveRightRow.isNotEmpty) {
      for (int intItem in arrayMoveRightRow) {
        List arrayEffects = effectingArrayAtMoveRightRow(
            tempHealthModel, intItem, EasyTypeEnum.from);

        if (arrayEffects.isEmpty) {
          ///这个分支是对的，下面那个分支可能永远也不会走到。因为在一个Level中，总会有不受同级生克的；而上一级对本级的生克已经计算完成。
          bHasBegin = true;
        } else {
          bool allFinish = true;
          for (int itemEffects in arrayEffects) {
            if (tempHealthModel.diagramsModel.isUnFinish(itemEffects)) {
              allFinish = false;
              break;
            } //else cont.
          } //end if

          bHasBegin = allFinish;
        } //end if
      } //end for
    } else {
      bHasBegin = true;
    } //end if
    return bHasBegin;
  }

  ///`加载函数`//////////////////////////////////////////////////////
  SABHealthOriginBusiness originBusiness() {
    return _originBusiness;
  }

  SABEasyLogicModel logicModel() {
    return originBusiness().logicModel();
  }

  SABEasyWordsModel wordsModel() {
    return originBusiness().wordsModel();
  }
}
