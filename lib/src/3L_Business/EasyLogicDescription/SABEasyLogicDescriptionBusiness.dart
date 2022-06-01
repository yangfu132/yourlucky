﻿import 'package:yourlucky/src/3L_Business/DigitModel/SABEasyDigitModel.dart';
import 'package:yourlucky/src/3L_Business/EasyLogic/Health/SABHealthModel.dart';
import 'package:yourlucky/src/3L_Business/EasyLogic/SABEasyHealthLogicModel.dart';
import 'package:yourlucky/src/4L_Service/SASStringService.dart';

import '../../1L_Context/SACContext.dart';
import '../../1L_Context/SACGlobal.dart';
import '../EarthBranch/SABEarthBranchBusiness.dart';
import '../EasyLogic/BaseLogic/SABEasyLogicModel.dart';
import '../EasyWords/SABEasyWordsModel.dart';
import 'SABEasyLogicDescriptionModel.dart';

class SABEasyLogicDescriptionBusiness {
  SABEasyLogicDescriptionBusiness(this._inputHealthLogicModel);

  final SABEasyHealthLogicModel _inputHealthLogicModel;

  late final SABEarthBranchBusiness _branchBusiness = SABEarthBranchBusiness();

  late final SABEasyLogicDescriptionModel _analysisModel = initAnalysisModel();

  ///`basic`//////////////////////////////////////////////////////

  String positionAtMerge(int nRow) {
    String strResult = "";

    if (0 <= nRow && nRow < 6) {
      strResult = positionAtRow(nRow, EasyTypeEnum.from);
    } else if (ROW_CHANGE_BEGIN <= nRow && nRow < ROW_CHANGE_END) {
      strResult = positionAtRow(nRow - ROW_CHANGE_BEGIN, EasyTypeEnum.to);
    } else if (ROW_FLY_BEGIN <= nRow && nRow < ROW_FLY_END) {
      strResult = positionAtRow(nRow - ROW_FLY_BEGIN, EasyTypeEnum.hide);
    }
    //else cont.

    return strResult;
  }

  String positionAtRow(int nRow, EasyTypeEnum easyType) {
    String strResult = "";

    if (EasyTypeEnum.from == easyType) {
      List arrayPosition = ["上爻", "五爻", "四爻", "三爻", "二爻", "初爻"];
      strResult = arrayPosition[nRow];
    } else if (EasyTypeEnum.to == easyType) {
      List arrayPosition = ["上爻变", "五爻变", "四爻变", "三爻变", "二爻变", "初爻变"];
      strResult = arrayPosition[nRow];
    } else if (EasyTypeEnum.hide == easyType) {
      List arrayPosition = ["上爻伏神", "五爻伏神", "四爻伏神", "三爻伏神", "二爻伏神", "初爻伏神"];
      strResult = arrayPosition[nRow];
    }
    //else cont.

    return strResult;
  }

  ///`六亲歌章第五`//////////////////////////////////////////////////////
  ///参见 SABEasyHealthLogicBusiness

  ///`世应章第六 -- 世（Life） 应（Goal）`/////////////////////////////////////////

  String roleDescriptionAtRow(int intRow) {
    return wordsModel().rowModelAtRow(intRow).desOfGoalOrLife;
  }

  ///`动静生克章第十四`//////////////////////////////////////////////////////

  String movementDescriptionAtRow(int intRow) {
    String result = "";
    if (wordsModel().isMovementAtRow(intRow)) {
      result = "动";
    } else {
      OutRightEnum outright =
          healthModel().symbolOutRightAtRow(intRow, EasyTypeEnum.from);
      if (OutRightEnum.RIGHT_MOVE == outright) {
        result = "暗动";
      } else {
        result = '静';
      }
    } //end if
    return result;
  }

  String resultParentEffectAtRow(int nRow, EasyTypeEnum easyType) {
    String strResult = parentEffectAtRow(nRow, easyType);
    String strPair = symbolMovePairDescriptionAtRow(nRow, easyType);
    strResult = strResult + "\r\n" + strPair;
    return strResult;
  }

  String parentEffectAtRow(int intRow, EasyTypeEnum easyType) {
    String result = "";

    if (logicModel().bStaticEasy)
      result = staticEffectedAtRow(intRow, easyType);
    else
      result = movementEffectedAtRow(intRow, easyType);

    return result;
  }

  String movementEffectedAtRow(int intRow, EasyTypeEnum easyType) {
    String result = "";

    List arrayEffects = healthModel().listMoveRight;

    //把自己从列表中移除
    if (EasyTypeEnum.from == easyType) arrayEffects.remove(intRow);
    //else cont.

    //卦有动爻能克静爻，即使静爻旺相亦不能克动爻。
    result = symbolEffected(intRow, easyType, arrayEffects);

    //六爻安静，旺相之爻可以生得休囚之爻，亦可以克得休囚之爻。
    if (!digitModel().isMovementAtRow(intRow)) {
      String staticResult = staticEffectedAtRow(intRow, easyType);
      result = SASStringService.appendToString(result, staticResult);
    } //else cont.

    return result;
  }

  String staticEffectedAtRow(int nIndex, EasyTypeEnum easyType) {
    //六爻安静，旺相之爻可以生得休囚之爻，亦可以克得休囚之爻。

    String result = "";

    List arrayEffects = logicModel().listStaticSeasonStrong;
    //把自己从列表中移除
    if (EasyTypeEnum.from == easyType) arrayEffects.remove(nIndex);
    //else cont.

    if (!logicModel().isSeasonStrong(nIndex, easyType)) {
      result = symbolEffected(nIndex, easyType, arrayEffects);
    }
    //else cont.

    return result;
  }

  String symbolEffected(int intRow, EasyTypeEnum easyType, List arrayEffects) {
    String strResult = "";

    String basicEarth = logicModel().getSymbolEarth(intRow, easyType);

    for (int numItem in arrayEffects) {
      String earth = wordsModel().getSymbolEarth(numItem, EasyTypeEnum.from);
      String stringElement =
          wordsModel().getSymbolElement(numItem, EasyTypeEnum.from);
      bool bEffect = logicModel().isEffectAble(numItem, EasyTypeEnum.from);

      String strEffect = bEffect ? "" : "无效：";

      if (_branchBusiness.isEarthBorn(earth, basicEarth)) {
        if ("" == strResult) {
          strResult = strEffect +
              positionAtMerge(numItem) +
              earth +
              stringElement +
              "生";
        } else {
          strResult = "\r\n" +
              strEffect +
              positionAtMerge(numItem) +
              earth +
              stringElement +
              "生";
        } //endi
      } else if (_branchBusiness.isEarthRestricts(earth, basicEarth)) {
        if ("" == strResult) {
          strResult = strEffect +
              positionAtMerge(numItem) +
              earth +
              stringElement +
              "克";
        } else {
          strResult = "\r\n" +
              strEffect +
              positionAtMerge(numItem) +
              earth +
              stringElement +
              "克";
        } //endi
      }
      //else cont.
    } //endf

    return strResult;
  }

  ///`动静生克冲合章第十五`//////////////////////////////////////////////////////

  String changeAnalysisAtRow(int nRow) {
    String result = "";

    String fromEarth = wordsModel().getSymbolEarth(nRow, EasyTypeEnum.from);
    String toEarth = wordsModel().getSymbolEarth(nRow, EasyTypeEnum.to);
    if ("" != toEarth) {
      if (logicModel().getIsSymbolChangeBorn(nRow))
        result = SASStringService.appendToString(result, "回头生");
      //else cont.

      if (logicModel().getIsSymbolChangeRestrict(nRow))
        result = SASStringService.appendToString(result, "回头克");
      //else cont.

      if (logicModel().getIsSymbolChangeConflict(nRow))
        result = SASStringService.appendToString(result, "回头冲");
      //else cont.

      String strPair = changePairDescriptionAtRow(nRow);
      if ("" != strPair)
        result = SASStringService.appendToString(result, strPair);
      //else cont.

      String strForwardOrBack = logicModel().getSymbolForwardOrBack(nRow);
      if ("" != strForwardOrBack)
        result = SASStringService.appendToString(result, strForwardOrBack);
      //else cont.

      String strTwelveDeity =
          _branchBusiness.earthTwelveDeity(fromEarth, toEarth);
      if ("长生" == strTwelveDeity ||
          "帝旺" == strTwelveDeity ||
          "墓" == strTwelveDeity ||
          "绝" == strTwelveDeity) {
        if ("" != result)
          result = "\r\n化$strTwelveDeity";
        else
          result = "化$strTwelveDeity";
      }
      //else cont.

      bool? bToEmpty = healthLogicModel().getIsSymbolChangeEmpty(nRow);
      if (null != bToEmpty && bToEmpty)
        result = SASStringService.appendToString(result, "化空");
      //else cont.
    }
    //else cont.

    return result;
  }

  ///`月将章第十六`//////////////////////////////////////////////////////

  String getMonthRelationAtRow(int nRow, EasyTypeEnum easyType) {
    String strResult = "";

    String stringSymbol = wordsModel().getSymbolName(nRow, easyType);

    if ("" != stringSymbol) {
      String strEarth = logicModel().getSymbolEarth(nRow, easyType);

      if (logicModel().isOnMonth(nRow, easyType))
        strResult = SASStringService.appendToString(strResult, "[临]");
      //else cont.

      String monthBroken = monthBrokenDescriptionAtRow(nRow, easyType);
      if ("" != monthBroken)
        strResult = SASStringService.appendToString(strResult, monthBroken);
      //else cont.

      String strPair = earthMonthPairDescription(strEarth);
      if ("" != strPair)
        strResult = SASStringService.appendToString(strResult, strPair);
      //else cont.

      String strTwelveDeity = _branchBusiness.earthTwelveDeity(
          strEarth, wordsModel().monthModel.stringEarth);
      if ("长生" == strTwelveDeity ||
          "帝旺" == strTwelveDeity ||
          "绝" == strTwelveDeity) {
        String strMark = "[$strTwelveDeity]";
        strResult = SASStringService.appendToString(strResult, strMark);
      }
      //else cont.

    }
    //else cont.

    return strResult;
  }

  ///`日辰章第十七`//////////////////////////////////////////////////////

  String getDayRelationAtRow(int nRow, EasyTypeEnum easyType) {
    String strResult = "";

    String stringSymbol = wordsModel().getSymbolName(nRow, easyType);
    String strEarth = logicModel().getSymbolEarth(nRow, easyType);
    if ("" != stringSymbol) {
      String strDayEarth = wordsModel().dayModel.stringEarth;
      String strTwelveDeity =
          _branchBusiness.earthTwelveDeity(strEarth, strDayEarth);

      if (logicModel().isOnDay(nRow, easyType))
        strResult = SASStringService.appendToString(strResult, "[临]");
      //else cont.

      bool bConflicted = _branchBusiness.isEarthConflict(strDayEarth, strEarth);
      if (bConflicted) {
        if (healthLogicModel().getIsSymbolBackMove(nRow))
          strResult = SASStringService.appendToString(strResult, "[暗动]");
        else if (healthLogicModel().getIsSymbolDayBroken(nRow, easyType))
          strResult = SASStringService.appendToString(strResult, "[日破]");
        else
          strResult = SASStringService.appendToString(strResult, "[冲]");
      }
      //else cont.

      String strPair = earthDayPairDescription(nRow, easyType);
      if ("" != strPair)
        strResult = SASStringService.appendToString(strResult, strPair);
      //else cont.

      String strEmpty = resultSymbolEmpty(nRow, easyType);
      if ("" != strEmpty)
        strResult = SASStringService.appendToString(strResult, strEmpty);
      //else cont.

      if ("长生" == strTwelveDeity ||
          "帝旺" == strTwelveDeity ||
          "墓" == strTwelveDeity ||
          "绝" == strTwelveDeity) {
        String strMark = "[$strTwelveDeity]";
        strResult = SASStringService.appendToString(strResult, strMark);
      }
      //else cont.
    }
    //else cont.

    return strResult;
  }

  String resultSymbolEmpty(int nRow, EasyTypeEnum easyType) {
    String strEmpty = "";
    switch (healthLogicModel().getSymbolEmptyState(nRow, easyType)) {
      case EmptyEnum.Empty_NO:
        break;
      case EmptyEnum.Empty_YES:
        strEmpty = "[空]";
        break;
      case EmptyEnum.Empty_False:
        strEmpty = "[假空]";
        break;
      case EmptyEnum.Empty_Real:
        strEmpty = "[真空]";
        break;
      case EmptyEnum.Empty_Conflict:
        strEmpty = "[冲空不空]";
        break;
      default:
        break;
    } //ends

    return strEmpty;
  }

  ///`六合章第十九`//////////////////////////////////////////////////////

  ///`爻的六合分析`//////////////////////////////////////////////////////

  String resultMonthPairAtRow(int nRow, EasyTypeEnum easyType) {
    String strResult = "";

    String strEarth = logicModel().getSymbolEarth(nRow, easyType);

    if ("" != strEarth) {
      String strMonthPair = earthMonthPairDescription(strEarth);
      if ("" != strMonthPair) {
        if (EasyTypeEnum.from == easyType) {
          if (digitModel().isMovementAtRow(nRow)) {
            strMonthPair =
                "本爻与月合: $strMonthPair; 动而逢合谓之合绊。爻动或与日月动爻合者，谓之逢合而绊住，反不能动之意。";
          } else {
            strMonthPair =
                "月合: $strMonthPair; 爻之合者，静而逢合谓之合起。爻静或与日月动爻合者，得合而起，即使爻值休囚亦有旺相之意。";
          } //endi
        } else if (EasyTypeEnum.from == easyType) {
          strMonthPair = "变爻与月合: $strMonthPair; 即使爻值休囚亦有旺相之意。";
        } else if (EasyTypeEnum.hide == easyType) {
          strMonthPair = "伏神与月合: $strMonthPair; 即使爻值休囚亦有旺相之意。";
        } else
          colog("error!");
      }
      //else cont.

      strResult = SASStringService.appendToString(strResult, strMonthPair);
    }
    //else cont.

    return strResult;
  }

  String resultDayPairAtRow(int intRow, EasyTypeEnum easyType) {
    String strResult = "";

    String strPairResult = logicModel().getSymbolEarth(intRow, easyType);
    if ("" != strPairResult) {
      if (EasyTypeEnum.from == easyType) {
        if (digitModel().isMovementAtRow(intRow)) {
          strPairResult =
              "本爻与日合: $strPairResult; 动而逢合谓之合绊。爻动或与日月动爻合者，谓之逢合而绊住，反不能动之意。";
        } else {
          strPairResult =
              "本爻与日合: $strPairResult; 爻之合者，静而逢合谓之合起。爻静或与日月动爻合者，得合而起，即使爻值休囚亦有旺相之意。";
        } //endi
      } else if (EasyTypeEnum.to == easyType) {
        strPairResult = "变爻与日合: $strPairResult; 即使爻值休囚亦有旺相之意。";
      } else if (EasyTypeEnum.hide == easyType) {
        strPairResult = "伏神与日合: $strPairResult; 即使爻值休囚亦有旺相之意。";
      } else
        colog("error!");
    }
    //else cont.

    strResult = SASStringService.appendToString(strResult, strPairResult);

    return strResult;
  }

  String resultMovePairAtRow(int intRow, EasyTypeEnum easyType) {
    String strResult = "";
    String baseEarth = logicModel().getSymbolEarth(intRow, easyType);
    if ("" != baseEarth) {
      if (EasyTypeEnum.from == easyType) {
        String strSymbolPair = "";
        //爻与爻合者，二也; 两爻都需要是动爻才能合
        List movementArray = healthModel().listMoveRight;
        if (movementArray.length >= 2) {
          for (int item in movementArray) {
            String tempEarth =
                logicModel().getSymbolEarth(item, EasyTypeEnum.from);
            String strPair = earthPairedDescription(baseEarth, tempEarth);
            if ("" != strPair) {
              strSymbolPair =
                  SASStringService.appendSentence(strSymbolPair, strPair);
            }
          } //endf

          if ("" != strSymbolPair) {
            strSymbolPair = "动爻与动爻合: $strSymbolPair；爻动与动爻相合，乃得他来合我，与我和好相助之意。";
            strResult =
                SASStringService.appendToString(strResult, strSymbolPair);
          }
          //else cont.
        }
        //else cont.
      }
      //else cont.
    }
    //else cont.

    return strResult;
  }

  String resultChangePairAtRow(int nRow, EasyTypeEnum easyType) {
    String strResult = "";

    if (EasyTypeEnum.from == easyType) {
      String strSymbolPair = changePairDescriptionAtRow(nRow);
      if ("" != strResult) {
        strSymbolPair =
            "爻动化合者：$strSymbolPair；爻动化合谓之化扶。爻动化出之爻回头相合者，谓之化扶，得他扶助之意。";
        strResult = SASStringService.appendToString(strResult, strSymbolPair);
      }
      //else cont.
    }
    //else cont.

    return strResult;
  }

  String earthDayPairDescription(int nRow, EasyTypeEnum easyType) {
    String strResult = "";
    String strEarth = logicModel().getSymbolEarth(nRow, easyType);
    if (_branchBusiness.isEarthPairDay(
        strEarth, wordsModel().dayModel.stringEarth)) {
      strResult = _branchBusiness.sixPairDescription(
          strEarth, wordsModel().dayModel.stringEarth);
    }
    //else cont.

    return strResult;
  }

  String earthMonthPairDescription(String strEarth) {
    String strResult = "";
    String strDay = wordsModel().dayModel.stringEarth;
    if (!_branchBusiness.isEarthConflict(strDay, strEarth) &&
        !_branchBusiness.isEarthConflict(
            strDay, wordsModel().monthModel.stringEarth)) {
      strResult = _branchBusiness.sixPairDescription(
          strEarth, wordsModel().monthModel.stringEarth);
    }
    //else cont.

    return strResult;
  }

  String symbolMovePairDescriptionAtRow(int nRow, EasyTypeEnum easyType) {
    String strSymbolPair = "";
    String basicEarth = logicModel().getSymbolEarth(nRow, easyType);

    if (logicModel().isMovementAtRow(nRow)) {
      List movementArray = healthModel().listMoveRight;
      for (int item in movementArray) {
        if (nRow != item) {
          String tempEarth =
              logicModel().getSymbolEarth(item, EasyTypeEnum.from);
          String strPair = earthPairedDescription(basicEarth, tempEarth);
          if ("" != strPair)
            strSymbolPair =
                SASStringService.appendToString(strSymbolPair, strPair);
          //else cont.
        }
        //else cont.

      } //endf
    }
    //else cont.

    return strSymbolPair;
  }

  String earthPairedDescription(String basicEarth, String otherEarth) {
    String strResult = "";
    //爻逢合住，遇日建以冲开，谓之合处逢冲，是也。
    String stringDayEarth = wordsModel().dayModel.stringEarth;
    if (!_branchBusiness.isEarthConflict(stringDayEarth, basicEarth) &&
        !_branchBusiness.isEarthConflict(stringDayEarth, otherEarth)) {
      strResult = _branchBusiness.sixPairDescription(basicEarth, otherEarth);
    }
    //else cont.

    return strResult;
  }

  String changePairDescriptionAtRow(int intRow) {
    String result = "";
    String fromEarth = logicModel().getSymbolEarth(intRow, EasyTypeEnum.from);
    String toEarth = logicModel().getSymbolEarth(intRow, EasyTypeEnum.to);
    if ("" != fromEarth && "" != toEarth)
      result = earthPairedDescription(fromEarth, toEarth);
    //else cont.
    return result;
  }

  ///`-- 爻的三合`//////////////////////////////////////////////////////

  String resultThreePair() {
    /*
     此三合者有四；
     一卦之内有三爻动而合局者，一也。
     若两爻动，一爻不动亦成合局者，二也。
     有内卦初爻三爻动，动而变出之爻成三合者，三也。
     又有外卦四爻六爻动，动而变出之爻成合者，四也。
     */

    String strResult = "";

    //一卦之内有三爻动而合局者，一也。
    strResult = SASStringService.appendToString(strResult, moveThreePair());

    //有内卦初爻三爻动，动而变出之爻成三合者，三也。
    strResult =
        SASStringService.appendToString(strResult, insideEasyThreePair());

    //外卦四爻六爻动，动而变出之爻成合者，四也。
    strResult =
        SASStringService.appendToString(strResult, outsideEasyThreePair());

    return strResult;
  }

  String moveThreePair() {
    String strResult = "";

    //一卦之内有三爻动而合局者，一也。
    List movementArray = healthModel().listMoveRight;
    String strThreePair = subResultThreePairOfRowArray(movementArray);

    List array = [0, 1, 2, 3, 4, 5];
    String strVirtual = subResultThreePairOfRowArray(array);
    if ("" != strThreePair || "" != strVirtual) {
      strResult = SASStringService.appendToString(strResult, "动爻三合");

      if ("" != strThreePair)
        strResult = SASStringService.appendToString(strResult, strThreePair);
      //else cont.

      if ("" != strVirtual)
        strResult = SASStringService.appendToString(strResult, strVirtual);
      //else cont.
    }
    //else cont.

    return strResult;
  }

  int moveCountInArray(List arrayPairRow) {
    int nCount = 0;
    List movementArray = healthModel().listMoveRight;
    for (String item in arrayPairRow) {
      if (-1 != movementArray.indexOf(item)) nCount++;
      //else cont.
    } //endf

    return nCount;
  }

  String subResultThreePairdAtRow(int nRow) {
    String strResult = "";

    String posionLeft = positionAtMerge(nRow);

    if (0 <= nRow && nRow < 6) {
      if (digitModel().isMovementAtRow(nRow))
        strResult = strResult + posionLeft;
      else
        strResult = strResult + "$posionLeft(待)";
    } else
      strResult = strResult + posionLeft;

    return strResult;
  }

  String subThreePairAtRowArray(List arrayPairRow) {
    String strResult = "";

    List arrayR = _branchBusiness
        .earthThreePairInArray(wordsModel().earthAtMergeRowArray(arrayPairRow));

    if (arrayR.length == 1) {
      if (moveCountInArray(arrayPairRow) >= 2) {
        String strPairItem = "";

        String strLeft = subResultThreePairdAtRow(arrayPairRow[0]);
        if ("" != strLeft)
          strPairItem = strPairItem + "$strLeft、";
        else
          colog("error!");

        String strMiddle = subResultThreePairdAtRow(arrayPairRow[1]);
        if ("" != strMiddle)
          strPairItem = strPairItem + "$strMiddle";
        else
          colog("error!");

        String strRight = subResultThreePairdAtRow(arrayPairRow[2]);
        if ("" != strRight)
          strPairItem = strPairItem + "$strRight";
        else
          colog("error!");

        for (String itemResult in arrayR) {
          strPairItem = strPairItem + itemResult;
          strResult = SASStringService.appendToString(strResult, strPairItem);
        } //endf
      }
      //else cont.
    }
    //else cont. 没有匹配

    return strResult;
  }

  String subResultThreePairOfRowArray(List arrayRow) {
    String strThreePair = "";

    if (arrayRow.length >= 3) {
      for (int nFirst = 0; nFirst < arrayRow.length; nFirst++) {
        int itemLeft = arrayRow[nFirst];
        for (int nSecond = nFirst + 1; nSecond < arrayRow.length; nSecond++) {
          int itemMiddle = arrayRow[nSecond];
          for (int nThird = nSecond + 1; nThird < arrayRow.length; nThird++) {
            int itemRight = arrayRow[nThird];
            String itemResult =
                subThreePairAtRowArray([itemLeft, itemMiddle, itemRight]);
            if ("" != itemResult)
              strThreePair =
                  SASStringService.appendToString(strThreePair, itemResult);
            //else cont.
          } //endf
        } //endf
      } //endf
    }
    //else cont.

    return strThreePair;
  }

  String insideEasyThreePair() {
    String strResult = "";
    //有内卦初爻三爻动，动而变出之爻成三合者，三也。

    List movementArray = healthModel().listMoveRight;
    if (-1 != movementArray.indexOf(3) && -1 != movementArray.indexOf(5)) {
      String strPair = "";
      List arrayRow1 = [];
      arrayRow1.add(3);
      arrayRow1.add(3 + ROW_CHANGE_BEGIN);
      arrayRow1.add(5);
      String tempResult1 = subResultThreePairOfRowArray(arrayRow1);
      if ("" != tempResult1)
        strPair = SASStringService.appendToString(strPair, tempResult1);
      //else cont.

      List arrayRow2 = [];
      arrayRow2.add(3);
      arrayRow2.add(5);
      arrayRow2.add(5 + ROW_CHANGE_BEGIN);
      String tempResult2 = subResultThreePairOfRowArray(arrayRow2);
      if ("" != tempResult2)
        strPair = SASStringService.appendToString(strPair, tempResult2);
      //else cont.

      if ("" != strPair) {
        strResult = SASStringService.appendToString(strResult, "内卦三合:");
        strResult = SASStringService.appendToString(strResult, strPair);
      }
      //else cont.
    }
    //else cont.

    return strResult;
  }

  String outsideEasyThreePair() {
    String strResult = "";
    //有外卦四爻六爻动，动而变出之爻成合者，四也。
    int nFirst = 0;
    int nSecond = 0;
    List movementArray = healthModel().listMoveRight;
    if (-1 != movementArray.indexOf(nFirst) &&
        -1 != movementArray.indexOf(nSecond)) {
      String strPair = "";
      List arrayRow1 = [];
      arrayRow1.add(nFirst);
      arrayRow1.add(nFirst + ROW_CHANGE_BEGIN);
      arrayRow1.add(nSecond);
      String tempResult1 = subResultThreePairOfRowArray(arrayRow1);
      if ("" != tempResult1)
        strPair = SASStringService.appendToString(strPair, tempResult1);
      //else cont.

      List arrayRow2 = [];
      arrayRow2.add(nFirst);
      arrayRow2.add(nSecond);
      arrayRow2.add(nSecond + ROW_CHANGE_BEGIN);

      String tempResult2 = subResultThreePairOfRowArray(arrayRow2);
      if ("" != tempResult2)
        strPair = SASStringService.appendToString(strPair, tempResult2);
      //else cont.

      if ("" != strPair) {
        strResult = SASStringService.appendToString(strResult, "外卦三合:");
        strResult = SASStringService.appendToString(strResult, strPair);
      }
      //else cont.
    }
    //else cont.

    return strResult;
  }

  ///`-- 月破章第二十七`//////////////////////////////////////////////////////

  String monthBrokenDescriptionAtRow(int nRow, EasyTypeEnum easyType) {
    String monthBroken = "";
    switch (healthLogicModel().getConflictOnMonthState(nRow, easyType)) {
      case MonthConflictEnum.Conflict_NO:
        break;
      case MonthConflictEnum.Conflict_Broken:
        monthBroken = "[月破]";
        break;
      case MonthConflictEnum.Conflict_OnDay:
        monthBroken = "[冲日建不破]";
        break;
      case MonthConflictEnum.Conflict_Move:
        monthBroken = "[冲动不破]";
        break;
      case MonthConflictEnum.Conflict_DayBorn:
        monthBroken = "[冲日生不破]";
        break;
      case MonthConflictEnum.Conflict_MoveBorn:
        monthBroken = "[冲动生不破]";
        break;
      default:
        colog("error!");
        break;
    }

    return monthBroken;
  }

  ///`加载函数`//////////////////////////////////////////////////////
  SABEasyHealthLogicModel healthLogicModel() {
    return _inputHealthLogicModel;
  }

  SABHealthModel healthModel() {
    return _inputHealthLogicModel.inputHealthModel;
  }

  SABEasyLogicModel logicModel() {
    return healthModel().inputLogicModel;
  }

  SABEasyWordsModel wordsModel() {
    return logicModel().inputWordsModel;
  }

  SABEasyDigitModel digitModel() {
    return wordsModel().inputDigitModel;
  }

  SABEasyLogicDescriptionModel outAnalysisModel() {
    return _analysisModel;
  }

  SABEasyLogicDescriptionModel initAnalysisModel() {
    var analysisModel = SABEasyLogicDescriptionModel(_inputHealthLogicModel);
    for (int intRow = 0; intRow < 6; intRow++) {
      ///MonthBrokenDescription
      analysisModel.setMonthRelation(intRow, EasyTypeEnum.from,
          getMonthRelationAtRow(intRow, EasyTypeEnum.from));
      analysisModel.setMonthRelation(intRow, EasyTypeEnum.to,
          getMonthRelationAtRow(intRow, EasyTypeEnum.to));
      analysisModel.setMonthRelation(intRow, EasyTypeEnum.hide,
          getMonthRelationAtRow(intRow, EasyTypeEnum.hide));

      ///DayRelation
      analysisModel.setDayRelation(intRow, EasyTypeEnum.from,
          getDayRelationAtRow(intRow, EasyTypeEnum.from));
      analysisModel.setDayRelation(intRow, EasyTypeEnum.to,
          getDayRelationAtRow(intRow, EasyTypeEnum.to));
      analysisModel.setDayRelation(intRow, EasyTypeEnum.hide,
          getDayRelationAtRow(intRow, EasyTypeEnum.hide));

      ///SymbolRelation
      analysisModel.setSymbolRelation(
          intRow, parentEffectAtRow(intRow, EasyTypeEnum.from));

      ///EmptyDescription
      analysisModel.setEmptyDescription(intRow, EasyTypeEnum.from,
          resultSymbolEmpty(intRow, EasyTypeEnum.from));
      analysisModel.setEmptyDescription(
          intRow, EasyTypeEnum.to, resultSymbolEmpty(intRow, EasyTypeEnum.to));
      analysisModel.setEmptyDescription(intRow, EasyTypeEnum.hide,
          resultSymbolEmpty(intRow, EasyTypeEnum.hide));

      analysisModel.setMovementDescription(
          intRow, movementDescriptionAtRow(intRow));
    }

    return analysisModel;
  }
}
