import 'package:yourlucky/src/D_Business/Base/SABBaseBusiness.dart';
import 'package:yourlucky/src/D_Business/EarthBranch/SABEarthBranchBusiness.dart';
import 'package:yourlucky/src/D_Business/EasyWords/SABEasyWordsModel.dart';

import '../../../A_Context/SACContext.dart';
import '../../../A_Context/SACGlobal.dart';
import '../BaseLogic/SABEasyLogicModel.dart';
import 'SABHealthModel.dart';
import 'SABHealthOriginBusiness.dart';

///动爻的强弱计算
class SABMoveHealthBusiness extends SABBaseBusiness {
  SABMoveHealthBusiness(this._inputLogicModel);

  late final SABHealthOriginBusiness _originBusiness =
      SABHealthOriginBusiness(_inputLogicModel);
  final SABEasyLogicModel _inputLogicModel;

  late final SABEarthBranchBusiness _branchBusiness = SABEarthBranchBusiness();

  SABHealthOriginBusiness originBusiness() {
    return _originBusiness;
  }

  void calculateHealthOfAllMoveRight(SABHealthModel healthModel, List listRow) {
    bool hasBegin = healthModel.diagramsModel.hasBeginMoveRow;
    for (int item in listRow) {
      final fromSymbol = healthModel.rowModelAtRow(item).fromSymbol;
      if (healthModel.isUnFinish(item)) {
        double moveHealth = fromSymbol.doubleHealth;
        if (hasBegin) {
          moveHealth = calculateHealthOfMoveRightRow(
            healthModel,
            item,
            EasyTypeEnum.from,
          );
        } else {
          if (wordsModel().isMovementAtRow(item)) {
            moveHealth = moveSymbolBasicHealthAtRow(healthModel, item);
          } else {}
        } //end if
        healthModel.updateHealthAtRow(item, moveHealth);
        healthModel.addToFinishArray(item);
      }
      //else cont.
    } //endf
  }

  //calculateHealthOfAllMoveRightRow
  double calculateHealthOfMoveRightRow(
      SABHealthModel tempHealthModel, int item, EasyTypeEnum easyType) {
    double moveHealth = 0;
    if (wordsModel().isMovementAtRow(item))
      moveHealth = moveSymbolBasicHealthAtRow(tempHealthModel, item);
    else
      moveHealth = originBusiness().symbolBasicHealthAtRow(item, easyType);

    List arrayEffects =
        effectingArrayAtLevel3Row(tempHealthModel, item, easyType);

    for (int effectsItem in arrayEffects) {
      if (tempHealthModel.isUnFinish(effectsItem)) {
        moveHealth = calculateHealthOfMoveRightRow(
            tempHealthModel, effectsItem, easyType);
        tempHealthModel.updateHealthAtRow(item, moveHealth);
        tempHealthModel.addToFinishArray(item);
      }
      //else cont.
      moveHealth += adjustHealthAtRow(
          tempHealthModel, item, easyType, effectsItem, easyType);
    } //endf
    return moveHealth;
  }

  double adjustHealthAtRow(SABHealthModel tempHealthModel, int basicRow,
      EasyTypeEnum baseEasyType, int effectsRow, EasyTypeEnum effectsEasyType) {
    double fHealth = 0;

    double basicDefense =
        originBusiness().symbolDefensiveAtRow(basicRow, EasyTypeEnum.from);

    String basicEarth =
        logicModel().getSymbolEarth(basicRow, EasyTypeEnum.from);

    String effectsEarth =
        logicModel().getSymbolEarth(effectsRow, effectsEasyType);

    if (_branchBusiness.isEarthBorn(effectsEarth, basicEarth)) {
      fHealth += symbolOutAtRow(tempHealthModel, effectsRow, effectsEasyType);
    }
    //else cont.

    if (_branchBusiness.isEarthRestricts(effectsEarth, basicEarth)) {
      fHealth -= (MAX_DEFENSIVE - basicDefense) *
          symbolOutAtRow(tempHealthModel, effectsRow, effectsEasyType);
    }
    //else cont.

    return fHealth;
  }

  double symbolOutAtRow(
      SABHealthModel tempHealthModel, int nRow, EasyTypeEnum easyType) {
    double result = 0.0;

    if (EasyTypeEnum.to == easyType) {
      double toHealth = toSymbolHealthAtRow(nRow);
      result = toHealth * originBusiness().conversionRateAtRow(nRow, easyType);
    } else if (EasyTypeEnum.from == easyType) {
      if (!tempHealthModel.isUnFinish(nRow)) {
        double health = tempHealthModel.symbolHealthAtRow(nRow, easyType);
        result = health * originBusiness().conversionRateAtRow(nRow, easyType);
      } //else { moving row }
    } else if (EasyTypeEnum.hide == easyType) {
      coLog("error!");
    }
    return result;
  }

  ///`变爻的health`//////////////////////////////////////////////////////

  double toSymbolHealthAtRow(int nRow) {
    return originBusiness().symbolBasicHealthAtRow(nRow, EasyTypeEnum.to);
  }

  ///`动爻的基本值`//////////////////////////////////////////////////////

  ///动爻的基本值----------------------------------------------
  // 基础值加上变爻的生克
// 基础值加上变爻的生克
  double moveSymbolBasicHealthAtRow(SABHealthModel tempHealthModel, int nRow) {
    double fResult = -100.0;

    fResult = originBusiness().symbolBasicHealthAtRow(nRow, EasyTypeEnum.from);

    if (isSymbolEffectableAtRow(nRow, EasyTypeEnum.from)) {
      fResult += adjustHealthAtRow(
          tempHealthModel, nRow, EasyTypeEnum.from, nRow, EasyTypeEnum.to);
    }
    //else cont.

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
        MAX_DEFENSIVE != originBusiness().symbolDefensiveAtRow(nRow, easyType);
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

  List effectingArrayAtLevel3Row(
      SABHealthModel tempHealthModel, int nLevel3Row, EasyTypeEnum easyType) {
    List arrayEffects = [];

    ///TODO:yangfu132为了找到分析的开头，假设日建或者月建是不受其他爻生克的;
    if (logicModel().isOnDay(nLevel3Row, easyType) ||
        logicModel().isOnMonth(nLevel3Row, easyType)) {
      String basicEarth = logicModel().getSymbolEarth(nLevel3Row, easyType);
      List level3Array =
          originBusiness().rowArrayAtOutRightLevel(OutRightEnum.RIGHT_MOVE);

      for (int itemRow in level3Array) {
        if (nLevel3Row != itemRow) {
          if (isEffectingLevel3AtRow(tempHealthModel, itemRow, easyType)) {
            if (isEffectingEarth(basicEarth, itemRow))
              arrayEffects.add(itemRow);
            //else cont.
          }
          //else 日冲休囚静爻算是日破
        }
        //else cont.

      } //endf
    }

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
        originBusiness().rowArrayAtOutRightLevel(OutRightEnum.RIGHT_MOVE);
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

  bool isEffectingLevel3AtRow(SABHealthModel tempHealthModel, int nEffectingRow,
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
    } else
      coLog("error!");

    return bResult;
  }

  bool isMoveRightLevelHasBeginRow(SABHealthModel tempHealthModel) {
    bool bHasBegin = false;
    List arrayMoveRightRow =
        originBusiness().rowArrayAtOutRightLevel(OutRightEnum.RIGHT_MOVE);
    if (arrayMoveRightRow.length > 0) {
      for (int intItem in arrayMoveRightRow) {
        List arrayEffects = effectingArrayAtLevel3Row(
            tempHealthModel, intItem, EasyTypeEnum.from);

        if (0 == arrayEffects.length) {
          ///这个分支是对的，下面那个分支可能永远也不会走到。因为在一个Level中，总会有不受同级生克的；而上一级对本级的生克已经计算完成。
          bHasBegin = true;
        } else {
          bool allFinish = true;
          for (int itemEffects in arrayEffects) {
            if (tempHealthModel.isUnFinish(itemEffects)) {
              allFinish = false;
              break;
            } //else cont.
          } //end if

          bHasBegin = allFinish;
        } //end if

      } //end for
    } else
      bHasBegin = true;

    return bHasBegin;
  }

  ///`加载函数`//////////////////////////////////////////////////////
  SABEasyLogicModel logicModel() {
    return _inputLogicModel;
  }

  SABEasyWordsModel wordsModel() {
    return _inputLogicModel.inputWordsModel;
  }
}
