import 'package:yourlucky/src/D_Business/Base/SABBaseBusiness.dart';
import 'package:yourlucky/src/D_Business/DigitModel/SABDigitDiagramsModel.dart';
import 'package:yourlucky/src/D_Business/DigitModel/SABEasyDigitModel.dart';
import 'package:yourlucky/src/D_Business/EarthBranch/SABEarthBranchBusiness.dart';
import 'package:yourlucky/src/D_Business/EasyLogic/BaseLogic/SABCommonLogicBusiness.dart';
import 'package:yourlucky/src/D_Business/EasyLogic/BaseLogic/SABLogicRowModel.dart';
import 'package:yourlucky/src/D_Business/EasyLogic/BaseLogic/SABLogicSymbolModel.dart';
import 'package:yourlucky/src/D_Business/EasyWords/SABWordsRowModel.dart';
import 'package:yourlucky/src/D_Business/EasyWords/SABWordsSymbolModel.dart';

import '../../../A_Context/SACContext.dart';
import '../../../A_Context/SACGlobal.dart';
import '../../BasicEasy/SABElementInfoModel.dart';
import '../../EasyWords/SABEasyWordsBusiness.dart';
import '../../EasyWords/SABEasyWordsModel.dart';
import 'SABEasyLogicModel.dart';
import 'SABLogicDiagramsModel.dart';

class SABEasyLogicBusiness extends SABBaseBusiness {
  SABEasyLogicBusiness(this._inputEasyModel);
  final SABEasyDigitModel _inputEasyModel;
  late final SABEarthBranchBusiness _branchBusiness = SABEarthBranchBusiness();
  late final SABCommonLogicBusiness _commonLogicBusiness =
      SABCommonLogicBusiness();
  late final SABEasyWordsBusiness _wordsBusiness =
      SABEasyWordsBusiness(_inputEasyModel);
  late final SABEasyLogicModel _outLogicModel = initLogicModel();

  get symbol => null;

  ///`六亲歌章第五`//////////////////////////////////////////////////////
  ///参见 SABEasyHealthLogicBusiness

  ///`动变章第七`//////////////////////////////////////////////////////
  bool isSymbolChangeGuiAtRow(int intRow) {
    bool bResult = false;
    String fromEarth = earthAtFromRow(intRow);
    String strTo = earthAtToRow(intRow);
    if (strTo.isNotEmpty) {
      String fromElement = earthElement(fromEarth);
      String toElement = earthElement(strTo);
      String parent =
          SABElementInfoModel.elementRelative(fromElement, toElement);
      bResult = "官鬼" == parent;
    }
    //else cont.

    return bResult;
  }

  ///`用神章第八--用神旺相`//////////////////////////////////////////////////////
  ///参见SABEasyHealthLogicBusiness

  ///`用神元神忌神仇神章第九`//////////////////////////////////////////////////////
  ///参见SABEasyHealthLogicBusiness

  ///`--生世克世`//////////////////////////////////////////////////////
  List lifeBornArray() {
    String lifeElement =
        wordsModel().getSymbolElement(getLifeIndex(), EasyTypeEnum.from);
    return arrayParent("父母", lifeElement);
  }

  List lifeEnemyArray() {
    String lifeElement =
        wordsModel().getSymbolElement(getLifeIndex(), EasyTypeEnum.from);
    return arrayParent("官鬼", lifeElement);
  }

  List arrayParent(String strParent, String strElement) {
    List arrayResult = [];
    for (int intIndex = 0; intIndex < 6; intIndex++) {
      String currentElement =
          branchBusiness().earthElement(earthAtFromRow(intIndex));

      String tempParent =
          SABElementInfoModel.elementRelative(strElement, currentElement);
      if (tempParent == strParent) {
        arrayResult.add(intIndex);
      }
      //else cont.

    } //end for

    return arrayResult;
  }

  ///`元神忌神衰旺章第十`//////////////////////////////////////////////////////
  ///参见SABEasyHealthLogicBusiness

  ///`克处逢生章第十三`//////////////////////////////////////////////////////
  bool isEffectAbleRow(int intRow, EasyTypeEnum easyType) {
    bool bResult = false;

    bResult = !isSymbolOverpoweredByMonthAtRow(intRow, easyType);

    return bResult;
  }

  ///`动静生克章第十四`//////////////////////////////////////////////////////
  bool isStaticEasy() {
    return getDiagramsModel().fromEasyKey == getDiagramsModel().toEasyKey;
  }

  List staticSeasonStrong() {
    List _staticStrongArray = List.empty(growable: true);
    for (int intIndex = 0; intIndex < 6; intIndex++) {
      if (!isMovementAtRow(intIndex)) {
        String stringSymbol = symbolAtFromRow(intIndex);
        if (isSymbolSeasonStrong(stringSymbol))
          _staticStrongArray.add(intIndex);
        //else cont.
      }
      //else cont.
    } //end for

    return _staticStrongArray;
  }

//被静爻生
  bool isSymbolBornedByStaticAtIndex(int intIndex, EasyTypeEnum easyType) {
    bool bResult = false;
    String stringSymbol = "";
    if (easyType == EasyTypeEnum.from) {
      if (!isMovementAtRow(intIndex)) stringSymbol = symbolAtFromRow(intIndex);
      //else cont.
    } else if (easyType == EasyTypeEnum.hide)
      stringSymbol = symbolAtHideRow(intIndex);
    else
      coLog(StackTrace.current, LogTypeEnum.error, "error!");

    if ("" != stringSymbol) {
      List arrayEffects = staticSeasonStrong();

      for (int numItem in arrayEffects) {
        String stringSymbolItem = symbolAtFromRow(numItem);
        if (commonLogicBusiness()
            .isSymbolBorn(stringSymbol, stringSymbolItem)) {
          bResult = true;
          break;
        }
        //else cont.

      } //endf
    }
    //else cont.

    return bResult;
  }

  //被静爻克
  bool isSymbolRestrictedByStaticAtIndex(int intIndex, EasyTypeEnum easyType) {
    bool bResult = false;
    if (!isMovementAtRow(intIndex)) {
      String stringSymbol = "";
      if (easyType == EasyTypeEnum.from)
        stringSymbol = symbolAtFromRow(intIndex);
      else if (easyType == EasyTypeEnum.hide)
        stringSymbol = symbolAtHideRow(intIndex);
      //else cont.

      if (!isSymbolSeasonStrong(stringSymbol)) {
        List arrayEffects = staticSeasonStrong();

        for (int numItem in arrayEffects) {
          String stringSymbolItem = symbolAtFromRow(numItem);
          if (commonLogicBusiness()
              .isSymbolRestrict(stringSymbol, stringSymbolItem)) {
            bResult = true;
            break;
          }
          //else cont.

        } //endf
      }
      //else cont.
    }
    //else cont.

    return bResult;
  }

  /// `动静生克冲合章第十五`/////////////////////////////////////////////

  ///动化回头生
  bool isSymbolChangeBornAtRow(int intIndex) {
    bool bResult = false;
    if (isMovementAtRow(intIndex)) {
      String strFrom = earthAtFromRow(intIndex);
      String strTo = earthAtToRow(intIndex);
      bResult = commonLogicBusiness().isEarthBorn(strTo, strFrom);
    }
    //else cont.

    return bResult;
  }

  ///动化回头克
  bool isSymbolChangeRestrictAtRow(int intRow) {
    bool bResult = false;

    if (0 <= intRow && intRow <= 5) {
      String fromEarth = earthAtFromRow(intRow);
      String strTo = earthAtToRow(intRow);
      if (strTo.isNotEmpty) bResult = isEarthRestricts(strTo, fromEarth);
      //else cont.
    } else
      coLog(StackTrace.current, LogTypeEnum.error, "error!");

    return bResult;
  }

  ///动化回头冲
  bool isSymbolChangeConflictAtRow(int intRow) {
    bool bResult = false;
    String fromEarth = earthAtFromRow(intRow);
    String strTo = earthAtToRow(intRow);
    if (strTo.isNotEmpty) bResult = isEarthConflict(fromEarth, strTo);
    //else cont.

    return bResult;
  }

  ///`四时旺相章第又十五`//////////////////////////////////////////////////////
  String _symbolSeason(String stringSymbol) {
    return branchBusiness()
        .seasonDescription(monthEarth(), symbolEarth(stringSymbol));
  }

  bool isSymbolSeasonStrong(String stringSymbol) {
    bool bResult = false;

    if (stringSymbol.isNotEmpty) {
      String stringSeason = _symbolSeason(stringSymbol);
      bResult = "旺" == stringSeason;
      bResult = bResult || "相" == stringSeason;
      bResult = bResult || "余气" == stringSeason;
    } else {
      coLog(StackTrace.current, LogTypeEnum.error, 'error');
    }
    return bResult;
  }

  ///`月将章第十六`//////////////////////////////////////////////////////
  ///参见SABEasyHealthLogicBusiness
  bool _isSymbolOnMonth(String stringSymbol) {
    return monthEarth() == symbolEarth(stringSymbol);
  }

  bool isEarthPairMonth(String basicEarth, String monthEarth) {
    bool bResult = false;

    return bResult;
  }

  bool isEarthOnMonth(String basicEarth, String monthEarth) {
    return monthEarth == basicEarth;
  }

  bool _isSymbolMonthBorn(String stringSymbol) {
    String strMonth = monthEarth();

    String strEarth = symbolEarth(stringSymbol);

    bool bBorn = commonLogicBusiness().isEarthBorn(strMonth, strEarth);

    return bBorn;
  }

  bool _isSymbolMonthRestrict(String stringSymbol) {
    String strMonth = monthEarth();

    String strEarth = symbolEarth(stringSymbol);
    bool bRestricted = isEarthRestricts(strMonth, strEarth);

    return bRestricted;
  }

  bool isConflictMonthAtRow(int intRow, EasyTypeEnum easyType) {
    String stringSymbol = wordsModel().getSymbolName(intRow, easyType);
    String basicEarth = symbolEarth(stringSymbol);
    return isEarthConflict(basicEarth, monthEarth());
  }

  bool isMovementStrongAtRow(int intRow) {
    //月建以下情况之一，不能克伤动爻；
    bool bResult = false;

    String stringSymbol = symbolAtFromRow(intRow);
    String strEarth = earthAtFromRow(intRow);

    //1 临日建，日生。
    String strDay = dayEarth();
    bool bOnDay = _isSymbolOnDay(stringSymbol);
    bool bBornByDay = commonLogicBusiness().isEarthBorn(strDay, strEarth);

    //2 动变回头生。
    bool bBornByChange = isSymbolChangeBornAtRow(intRow);

    //3 动变进。
    bool bChangeForward = isSymbolChangeForwardAtRow(intRow);

    //4 有旺动爻生。

    bool bBornByMoving = false;
    List arrayEffects = [0, 1, 2, 3, 4, 5];
    List arrayMovement =
        commonLogicBusiness().movementInArray(wordsModel(), arrayEffects);
    for (int numItem in arrayMovement) {
      String stringSymbol = symbolAtFromRow(numItem);
      String season = _symbolSeason(stringSymbol);
      if ("旺" == season) {
        String moveEarth = earthAtFromRow(numItem);
        if (commonLogicBusiness().isEarthBorn(moveEarth, strEarth)) {
          bBornByMoving = false;
          break;
        }
        //else cont.
      }
      //else cont.

    } //endf

    bResult = bOnDay ||
        bBornByDay ||
        bBornByChange ||
        bChangeForward ||
        bBornByMoving;

    return bResult;
  }

//月建亦能制服动爻
  bool isSymbolOverpoweredByMonthAtRow(int intRow, EasyTypeEnum easyType) {
    bool bResult = false;
    String stringSymbol = rowModelAtRow(intRow, easyType);

    String strEarth = symbolEarth(stringSymbol);
    String strMonth = monthEarth();
    bool bRestricted = isEarthRestricts(strMonth, strEarth);
    if (bRestricted) {
      if (easyType == EasyTypeEnum.from) {
        if (isMovementAtRow(intRow)) {
          bResult = !isMovementStrongAtRow(intRow);
        }
        //else cont.
      }
      //else cont.
    }
    //else cont.

    return bResult;
  }

  /// `日辰章第十七`/////////////////////////////////////////////
  /// ///参见"SABEasyHealthLogicBusiness"
  String dayElement() {
    return earthElement(dayEarth());
  }

  bool isEarthOnDay(String basicEarth, String dayEarth) {
    return dayEarth == basicEarth;
  }

  bool isConflictDayEarth(String basicEarth, String dayEarth) {
    bool result = false;

    result = isEarthConflict(basicEarth, dayEarth);

    return result;
  }

  bool isConflictDayAtRow(int intRow, EasyTypeEnum easyType) {
    bool bResult = false;

    if (0 <= intRow && intRow < 6) {
      String stringSymbol = rowModelAtRow(intRow, easyType);
      bResult = _isSymbolDayConflict(stringSymbol);
    } else
      coLog(StackTrace.current, LogTypeEnum.error, "error!");

    return bResult;
  }

  bool _isSymbolDayBorn(String stringSymbol) {
    String strDayEarth = dayEarth();

    String strEarth = symbolEarth(stringSymbol);

    bool bBorn = commonLogicBusiness().isEarthBorn(strDayEarth, strEarth);

    return bBorn;
  }

  bool _isSymbolDayRestrict(String stringSymbol) {
    String strDayEarth = dayEarth();

    String strEarth = symbolEarth(stringSymbol);
    bool bRestricted = isEarthRestricts(strDayEarth, strEarth);

    return bRestricted;
  }

  bool _isSymbolDayConflict(String stringSymbol) {
    String strDayEarth = dayEarth();

    String strEarth = symbolEarth(stringSymbol);

    bool bConflicted = isEarthConflict(strDayEarth, strEarth);

    return bConflicted;
  }

  bool _isSymbolOnDay(String stringSymbol) {
    return isEarthOnDay(symbolEarth(stringSymbol), dayEarth());
  }

  ///`飞伏章第二十八`//////////////////////////////////////////////////////
  /// ///参见"SABEasyHealthLogicBusiness"

  ///`六合章第十九`//////////////////////////////////////////////////////
  ///参见"SABEasyHealthLogicBusiness"

//六合卦
  bool _isEasySixPair(Map easyDictionary) {
    bool bResult = false;

    List symbolPairArray = [];

    List dataArray = easyDictionary["data"];

    for (int index = 0; index < dataArray.length; index++) {
      String basicEarth = symbolEarth(dataArray[index]);
      for (int indexOther = 0; indexOther < dataArray.length; indexOther++) {
        if (index != indexOther) {
          String otherEarth = symbolEarth(dataArray[indexOther]);
          String strPair =
              branchBusiness().sixPairDescription(basicEarth, otherEarth);
          if ("" != strPair) {
            if (-1 == symbolPairArray.indexOf(index))
              symbolPairArray.add(index);
            //else cont.

            if (-1 == symbolPairArray.indexOf(indexOther))
              symbolPairArray.add(indexOther);
            //else cont.

            break;
          }
        }
        //else cont.

      } //end for
    } //end for

    bResult = (6 == symbolPairArray.length);

    return bResult;
  }

  bool isPairrowModelAtRow(int intRow, int nOtherRow) {
    bool bResult = false;

    String strPair = branchBusiness().earthSixPair(earthAtFromRow(intRow));

    bResult = (strPair == earthAtFromRow(nOtherRow));

    return bResult;
  }

/*
 比如男人自测婚姻
 世：自己
 生世：自己父母
 克世：自己的限制条件

 用神：这家事情本身
 元神：有利条件
 忌神：限制条件

 应：对方
 生应：对方父母
 克应：对方的限制条件
 */

  ///`--爻的六合分析`//////////////////////////////////////////////////////
  bool _isSymbolDayPair(String stringSymbol) {
    String strEarth = symbolEarth(stringSymbol);

    return branchBusiness().isEarthPairDay(strEarth, dayEarth());
  }

  bool _isSymbolMonthPair(String stringSymbol) {
    String strEarth = symbolEarth(stringSymbol);

    bool bResult = isEarthPairMonth(strEarth, monthEarth());

    return bResult;
  }

  ///`六冲章第二十`//////////////////////////////////////////////////////
  bool _isEasySixConflict(Map easyDictionary) {
    bool bResult = false;

    List conflictArray = [];

    List dataArray = easyDictionary["data"];
    for (int index = 0; index < dataArray.length; index++) {
      String basicEarth = symbolEarth(dataArray[index]);
      for (int indexOther = 0; indexOther < dataArray.length; indexOther++) {
        if (index != indexOther) {
          String otherEarth = symbolEarth(dataArray[indexOther]);
          if (isEarthConflict(basicEarth, otherEarth)) {
            conflictArray.add(index);
            break;
          }
        }
        //else cont.

      } //endf
    } //endf

    bResult = (6 == conflictArray.length);

    return bResult;
  }

  ///`暗动章第二十二`//////////////////////////////////////////////////////
  ///SABEasyHealthLogicBusiness

  ///`卦变生克墓绝章第二十四`/////////////////////////////////////////////////////
  String easyParent() {
    String fromElement = getDiagramsModel().stringFromElement;
    String toElement = getDiagramsModel().stringToElement;
    String strParent =
        SABElementInfoModel.elementRelative(fromElement, toElement);
    return strParent;
  }

  ///`反伏章第二十五`//////////////////////////////////////////////////////////////
  bool isEasyRepeatedGroan() {
    //卦变者，内外动而反伏者同一卦也, 如乾卦变震卦是也。
    bool bResult = false;

    List inMovementArray = wordsModel().inGuaMovementArray();

    List outMovementArray = wordsModel().outGuaMovementArray();

    if (inMovementArray.length > 0 && outMovementArray.length > 0)
      bResult = isEasySame();
    //else cont.

    return bResult;
  }

  bool isEasyInPartRepeated() {
    //内卦伏吟
    bool bResult = false;

    List inMovementArray = wordsModel().inGuaMovementArray();

    List outMovementArray = wordsModel().outGuaMovementArray();

    if (inMovementArray.length > 0 && outMovementArray.length == 0)
      bResult = isEasySame();
    //else cont.

    return bResult;
  }

  bool isEasyOutPartRepeated() {
    //外卦伏吟
    bool bResult = false;

    List inMovementArray = wordsModel().inGuaMovementArray();

    List outMovementArray = wordsModel().outGuaMovementArray();

    if (inMovementArray.length == 0 && outMovementArray.length > 0)
      bResult = isEasySame();
    //else cont.

    return bResult;
  }

  bool isEasyRestricts() {
    //反吟
    bool bResult = false;
    //卦化对冲

    Map dictGuaConflict = {
      "乾": "巽",
      "坤": "艮",
      "坎": "离",
      "离": "坎",
      "巽": "乾",
      "震": "兑",
      "艮": "坤",
      "兑": "震",
    };

    String fromPlace = getDiagramsModel().stringFromPlace;
    String toPlace = getDiagramsModel().stringToPlace;
    String strConflictPlace = dictGuaConflict[fromPlace];
    bResult = strConflictPlace == toPlace;
    return bResult;
  }

  bool isEasyRestrictsGroan() {
    //卦变者，内外动而反伏者同一卦也, 如乾卦变震卦是也。
    bool bResult = false;

    List inMovementArray = wordsModel().inGuaMovementArray();

    List outMovementArray = wordsModel().outGuaMovementArray();

    if (inMovementArray.length > 0 && outMovementArray.length > 0)
      bResult = isEasyRestricts();
    //else cont.

    return bResult;
  }

  bool isEasyInPartRestricts() {
    //内卦伏吟
    bool bResult = false;

    List inMovementArray = wordsModel().inGuaMovementArray();

    List outMovementArray = wordsModel().outGuaMovementArray();

    if (inMovementArray.length > 0 && outMovementArray.length == 0)
      bResult = isEasyRestricts();
    //else cont.

    return bResult;
  }

  bool isEasyOutPartRestricts() {
    //外卦伏吟
    bool bResult = false;

    List inMovementArray = wordsModel().inGuaMovementArray();

    List outMovementArray = wordsModel().outGuaMovementArray();

    if (inMovementArray.length == 0 && outMovementArray.length > 0)
      bResult = isEasyRestricts();
    //else cont.

    return bResult;
  }

  bool isEasySame() {
    //卦变者，内外动而反伏者同一卦也, 如乾卦变震卦是也。
    bool bResult = true;

    for (int intIndex = 0; intIndex < 6; intIndex++) {
      if (earthAtFromRow(intIndex) != earthAtToRow(intIndex)) {
        bResult = false;
        break;
      }
      //else cont.

    } //endf

    return bResult;
  }

  /// `--爻之反吟伏吟`///////////////////////////////////////////////////////////
  bool isMovementSame(List movementArray) {
    bool bResult = true;
    for (int intIndex in movementArray) {
      if (earthAtFromRow(intIndex) != earthAtToRow(intIndex)) {
        bResult = false;
        break;
      }
      //else cont.
    } //endf

    return bResult;
  }
//
//bool  isSymbolRepeated
//{
//    //爻伏吟
//    bool bResult = false;
//
//    List inMovementArray = inGuaMovementArray();
//
//    List outMovementArray = outGuaMovementArray();
//
//    if ( inMovementArray.length > 0 && outMovementArray.length > 0)
//        bResult = [self isMovementSame:inMovementArray] && [self isMovementSame:outMovementArray];
//    //else cont.
//
//    return bResult;
//}
//
//
//bool  isSymbolWihtInRepeated
//{
//    //内卦伏吟
//    bool bResult = false;
//
//    List inMovementArray = inGuaMovementArray();
//
//    List outMovementArray = outGuaMovementArray();
//
//    if ( inMovementArray.length > 0 && outMovementArray.length == 0)
//        bResult = [self isMovementSame:inMovementArray];
//    //else cont.
//
//    return bResult;
//}
//
//bool  isSymbolOutsideRepeated
//{
//    //外卦伏吟
//    bool bResult = false;
//
//    List inMovementArray = inGuaMovementArray();
//
//    List outMovementArray = outGuaMovementArray();
//
//    if ( inMovementArray.length == 0 && outMovementArray.length > 0)
//        bResult = [self isMovementSame:outMovementArray];
//    //else cont.
//
//    return bResult;
//}
//
//bool  isMovementRestricts:(List)movementArray
//{
//    //反吟
//    bool bResult = true;
//
//    for (NSNumber* numIndex in movementArray)
//    {
//        int  intIndex  = [numIndex integerValue];
//        String fromEarth = earthAtFromRow(intIndex);
//        String toEarth = earthAtToRow(intIndex ];
//        if (![self isEarthConflict:fromEarth ,toEarth])
//        {
//            bResult = false;
//            break;
//        }
//        //else cont.
//    }//endf
//
//    return bResult;
//
//    return bResult;
//}
//

  /// `--旬空章第二十六`///////////////////////////////////////////////////////////

  EmptyEnum _symbolBasicEmptyState(String stringSymbol) {
    EmptyEnum nResult = EmptyEnum.Empty_False;
    if ("" != stringSymbol) {
      String earth = symbolEarth(stringSymbol);
      if (-1 != emptyEarth().indexOf(earth)) {
        String strDay = dayEarth();
        if (isEarthConflict(strDay, earth)) {
          //爻遇旬空，日辰冲起而为用，谓之冲空则实。
          nResult = EmptyEnum.Empty_Conflict;
        } else {
          nResult = EmptyEnum.Empty_YES;
        }
      } //else continue.
    } else {
      coLog(StackTrace.current, LogTypeEnum.error, "stringSymbol为空");
    }

    return nResult;
  }

  bool isEmptyAtRow(int intRow, EasyTypeEnum easyType) {
    String stringSymbol = rowModelAtRow(intRow, easyType);
    bool bResult = _symbolBasicEmptyState(stringSymbol) == EmptyEnum.Empty_YES;

    return bResult;
  }

  bool isHideSymbolSeasonStrong(int intRow) {
    String stringSymbol = symbolAtHideRow(intRow);
    return isSymbolSeasonStrong(stringSymbol);
  }

  String emptyEarth() {
    String strResult = "";

    String strSkyTrunk = SABEasyLogicModel.skyTrunkString();
    String strDayTrunk = daySky();
    int indexTrunk = strSkyTrunk.indexOf(strDayTrunk);

    String strEarthBranch = SABEasyLogicModel.earthBranchString();
    String strDayBranch = dayEarth();
    int indexBranch = strEarthBranch.indexOf(strDayBranch);

    int leftTrunk = strSkyTrunk.length - (indexTrunk + strDayTrunk.length);

    int leftBranch = (indexBranch + strDayBranch.length) + leftTrunk;

    int emptyLocation = leftBranch % 12;

    if (strEarthBranch.length >= 2) {
      if (strEarthBranch.length >= emptyLocation + 2) {
        strResult = strEarthBranch.substring(emptyLocation, emptyLocation + 2);
      } else {
        ///当旬空包含"子"地支时
        strEarthBranch += strEarthBranch;
        strResult = strEarthBranch.substring(emptyLocation, emptyLocation + 2);
      }
    } else
      coLog(StackTrace.current, LogTypeEnum.error, "error!");

    return strResult;
  }

  ///`生旺墓绝章第又二十六`//////////////////////////////////////////////////////
  bool isSymbolChangeMuAtRow(int intRow) {
    bool bResult = false;
    String fromEarth = earthAtFromRow(intRow);
    String strTo = earthAtToRow(intRow);
    String strTwelve = earthTwelveDeity(fromEarth, strTo);
    bResult = "墓" == strTwelve;
    return bResult;
  }

//随鬼入墓
  bool isSymbolSuiGuiRuMuAtRow(int intRow) {
    bool bResult = false;
    String strParent = wordsModel().getSymbolParent(intRow, EasyTypeEnum.from);
    bool bGui = "官鬼" == strParent;
    bool bRuMu = isSymbolChangeMuAtRow(intRow);

    bResult = bGui && bRuMu;

    return bResult;
  }

  ///`月破章第二十七`//////////////////////////////////////////////////////
  ///参见HealthLogic

  ///`飞伏章第二十八`//////////////////////////////////////////////////////
  ///参见SABEasyHealthLogicBusiness `飞伏章第二十八`

  ///`进神退神章第二十九`//////////////////////////////////////////////////////
  String symbolForwardOrBack(int nRow) {
    String result = "";
    if (wordsModel().rowModelAtRow(nRow).bMovement) {
      String fromEarth = wordsModel().getSymbolEarth(nRow, EasyTypeEnum.from);
      String toEarth = wordsModel().getSymbolEarth(nRow, EasyTypeEnum.to);
      if (branchBusiness().isEarthForward(fromEarth, toEarth)) {
        result = "化进";
      } else if (branchBusiness().isEarthBack(fromEarth, toEarth)) {
        result = "化退";
      }
      //else cont.
    } // else { static row }

    return result;
  }

  bool isSymbolChangeForwardAtRow(int intRow) {
    bool bResult = false;
    if (isMovementAtRow(intRow)) {
      String fromEarth = earthAtFromRow(intRow);
      String toEarth = earthAtToRow(intRow);
      bResult = branchBusiness().isEarthForward(fromEarth, toEarth);
    }
    //else cont.

    return bResult;
  }

  bool isSymbolChangeBackAtRow(int intRow) {
    bool bResult = false;
    if (isMovementAtRow(intRow)) {
      String fromEarth = earthAtFromRow(intRow);
      String toEarth = earthAtToRow(intRow);
      bResult = branchBusiness().isEarthBack(fromEarth, toEarth);
    }
    //else cont.

    return bResult;
  }

  ///`两现章第三十二`//////////////////////////////////////////////////////
  ///参见HealthLogic

  ///`earthBranch 桥函数`//////////////////////////////////////////////////////
  String earthSixPair(String earth) {
    return branchBusiness().earthSixPair(earth);
  }

  String getSixConflict(String basicEarth) {
    return branchBusiness().getSixConflict(basicEarth);
  }

  String earthElement(String earth) {
    return branchBusiness().earthElement(earth);
  }

  bool isEarthRestricts(String earth, String basicEarth) {
    return commonLogicBusiness().isEarthRestricts(earth, basicEarth);
  }

  String earthTwelveDeity(String itemEarth, String atEarth) {
    return branchBusiness().earthTwelveDeity(itemEarth, atEarth);
  }

  bool isEarthConflict(String basicEarth, String otherEarth) {
    return branchBusiness().isEarthConflict(basicEarth, otherEarth);
  }

  String sixPairDescription(String basicEarth, String otherEarth) {
    return branchBusiness().sixPairDescription(basicEarth, otherEarth);
  }

  String seasonDescription(String monthEarth, String _earthName) {
    return branchBusiness().seasonDescription(monthEarth, _earthName);
  }

  ///`EasyBusiness 桥函数`//////////////////////////////////////////////////////
  String symbolEarth(String stringSymbol) {
    return commonLogicBusiness().wordsBusiness().symbolEarth(stringSymbol);
  }

  Map _fromEasyDictionary() {
    return getDiagramsModel().mapFromEasy;
  }

  Map _toEasyDictionary() {
    return getDiagramsModel().mapToEasy;
  }

  String getUsefulDeity() {
    return wordsModel().inputDigitModel.strUsefulDeity;
  }

  int getLifeIndex() {
    return wordsModel().getLifeIndex();
  }

  int getGoalIndex() {
    return wordsModel().getGoalIndex();
  }

  String rowModelAtRow(int intRow, EasyTypeEnum enumEasyType) {
    return wordsModel().getSymbolName(intRow, enumEasyType);
  }

  String symbolAtFromRow(int intRow) {
    return wordsModel().getSymbolName(intRow, EasyTypeEnum.from);
  }

  ///原名symbolAtChangeRow,更改为symbolAtToRow
  String symbolAtToRow(int intRow) {
    return wordsModel().getSymbolName(intRow, EasyTypeEnum.to);
  }

  String symbolAtHideRow(int intRow) {
    return wordsModel().getSymbolName(intRow, EasyTypeEnum.hide);
  }

  String symbolNameAtMergeRow(int intRow) {
    return wordsModel().symbolNameAtMergeRow(intRow);
  }

  String monthEarth() {
    return wordsModel().monthModel.stringEarth;
  }

  String daySky() {
    return wordsModel().dayModel.stringSky;
  }

  String dayEarth() {
    return wordsModel().dayModel.stringEarth;
  }

  String earthAtFromRow(int intRow) {
    return wordsModel().getSymbolEarth(intRow, EasyTypeEnum.from);
  }

  ///原名为earthAtChangeRow,更改为earthAtToRow
  String earthAtToRow(int intRow) {
    return wordsModel().getSymbolEarth(intRow, EasyTypeEnum.to);
  }

  String earthAtHideRow(int intRow) {
    return wordsModel().getSymbolEarth(intRow, EasyTypeEnum.hide);
  }

  bool isMovementAtRow(int intRow) {
    return wordsModel().isMovementAtRow(intRow);
  }

  ///`加载函数`//////////////////////////////////////////////////////
  SABEarthBranchBusiness branchBusiness() {
    return _branchBusiness;
  }

  //SABCommonLogicBusiness
  SABCommonLogicBusiness commonLogicBusiness() {
    return _commonLogicBusiness;
  }

  SABEasyWordsModel wordsModel() {
    return wordsBusiness().outEasyWordsModel();
  }

  SABDigitDiagramsModel getDiagramsModel() {
    return wordsModel().inputDigitModel.diagramsModel;
  }

  SABEasyWordsBusiness wordsBusiness() {
    return _wordsBusiness;
  }

  SABEasyLogicModel outputLogicModel() {
    return _outLogicModel;
  }

  SABLogicSymbolModel fromSymbol(SABWordsSymbolModel wordsSymbol) {
    int intRow = wordsSymbol.intRow;
    String stringSymbol = symbolAtFromRow(intRow);
    return SABLogicSymbolModel(
      wordsSymbol: wordsSymbol,
      isOnMonth: _isSymbolOnMonth(stringSymbol),
      bMonthBorn: _isSymbolMonthBorn(stringSymbol),
      isMonthRestrict: _isSymbolMonthRestrict(stringSymbol),
      isMonthPair: _isSymbolMonthPair(stringSymbol),
      isConflictMonth: isConflictMonthAtRow(intRow, EasyTypeEnum.from),
      isOnDay: _isSymbolOnDay(stringSymbol),
      isDayPair: _isSymbolDayPair(stringSymbol),
      bDayBorn: _isSymbolDayBorn(stringSymbol),
      isDayRestrict: _isSymbolDayRestrict(stringSymbol),
      basicEmptyState: _symbolBasicEmptyState(stringSymbol),
      isConflictDay: isConflictDayAtRow(intRow, EasyTypeEnum.from),
      isSeasonStrong: isSymbolSeasonStrong(stringSymbol),
      stringSeason: _symbolSeason(stringSymbol),
      isEffectAble: isEffectAbleRow(intRow, EasyTypeEnum.from),
    );
  }

  SABLogicSymbolModel toSymbol(SABWordsSymbolModel wordsSymbol) {
    int intRow = wordsSymbol.intRow;
    String stringSymbol = symbolAtToRow(intRow);
    return SABLogicSymbolModel(
      wordsSymbol: wordsSymbol,
      isOnMonth: _isSymbolOnMonth(stringSymbol),
      bMonthBorn: _isSymbolMonthBorn(stringSymbol),
      isMonthRestrict: _isSymbolMonthRestrict(stringSymbol),
      isOnDay: _isSymbolOnDay(stringSymbol),
      isMonthPair: _isSymbolMonthPair(stringSymbol),
      isConflictMonth: isConflictMonthAtRow(intRow, EasyTypeEnum.to),
      isDayPair: _isSymbolDayPair(stringSymbol),
      bDayBorn: _isSymbolDayBorn(stringSymbol),
      isDayRestrict: _isSymbolDayRestrict(stringSymbol),
      isConflictDay: isConflictDayAtRow(intRow, EasyTypeEnum.to),
      basicEmptyState: _symbolBasicEmptyState(stringSymbol),
      isSeasonStrong: isSymbolSeasonStrong(symbolAtToRow(intRow)),
      stringSeason: _symbolSeason(stringSymbol),
      isEffectAble: isEffectAbleRow(intRow, EasyTypeEnum.to),
    );
  }

  SABLogicSymbolModel hideSymbol(SABWordsSymbolModel wordsSymbol) {
    int intRow = wordsSymbol.intRow;
    String stringSymbol = symbolAtHideRow(intRow);
    return SABLogicSymbolModel(
      wordsSymbol: wordsSymbol,
      isOnMonth: _isSymbolOnMonth(stringSymbol),
      bMonthBorn: _isSymbolMonthBorn(stringSymbol),
      isMonthRestrict: _isSymbolMonthRestrict(stringSymbol),
      isMonthPair: _isSymbolMonthPair(stringSymbol),
      isConflictMonth: isConflictMonthAtRow(intRow, EasyTypeEnum.hide),
      isOnDay: _isSymbolOnDay(stringSymbol),
      bDayBorn: _isSymbolDayBorn(stringSymbol),
      isDayRestrict: _isSymbolDayRestrict(stringSymbol),
      isDayPair: _isSymbolDayPair(stringSymbol),
      isConflictDay: isConflictDayAtRow(intRow, EasyTypeEnum.hide),
      basicEmptyState: _symbolBasicEmptyState(stringSymbol),
      isSeasonStrong: isSymbolSeasonStrong(stringSymbol),
      stringSeason: _symbolSeason(stringSymbol),
      isEffectAble: isEffectAbleRow(intRow, EasyTypeEnum.hide),
    );
  }

  SABLogicDiagramsModel _diagramsModel() {
    SABDigitDiagramsModel digitModel = _inputEasyModel.diagramsModel;
    SABLogicDiagramsModel diagramsModel = SABLogicDiagramsModel(
      digitModel: digitModel,
      bStaticEasy: isStaticEasy(),
      bFromEasySixPair: _isEasySixPair(_fromEasyDictionary()),
      bToEasySixPair: _isEasySixPair(_toEasyDictionary()),
      bHideEasySixPair: _isEasySixPair(digitModel.mapHideEasy),
      bFromEasySixConflict: _isEasySixConflict(_fromEasyDictionary()),
      bToEasySixConflict: _isEasySixConflict(_toEasyDictionary()),
      bHideEasySixConflict: _isEasySixConflict(digitModel.mapHideEasy),
      stringEmptyBranch: emptyEarth(),
      stringEasyParent: easyParent(),
      isEasyRepeatedGroan: isEasyRepeatedGroan(),
      isEasyInPartRepeated: isEasyInPartRepeated(),
      isEasyOutPartRepeated: isEasyOutPartRepeated(),
      isEasyRestrictsGroan: isEasyRestrictsGroan(),
      isEasyInPartRestricts: isEasyInPartRestricts(),
      isEasyOutPartRestricts: isEasyOutPartRestricts(),
      listStaticSeasonStrong: staticSeasonStrong(),
    );
    return diagramsModel;
  }

  SABEasyLogicModel initLogicModel() {
    var outLogicModel = SABEasyLogicModel(
      inputWordsModel: wordsModel(),
      diagramsModel: _diagramsModel(),
    );

    ///爻的基础信息
    for (int intRow = 0; intRow < 6; intRow++) {
      SABWordsRowModel rowsModel = wordsModel().rowModelAtRow(intRow);
      SABLogicRowModel logicRow = SABLogicRowModel(
        fromSymbol: fromSymbol(rowsModel.fromSymbol),
        toSymbol: toSymbol(rowsModel.toSymbol),
        hideSymbol: hideSymbol(rowsModel.hideSymbol),
        inputWordsRow: rowsModel,
        isSymbolChangeBorn: isSymbolChangeBornAtRow(intRow),
        isSymbolChangeRestrict: isSymbolChangeConflictAtRow(intRow),
        isSymbolChangeConflict: isSymbolChangeConflictAtRow(intRow),
        isSymbolChangeForward: isSymbolChangeForwardAtRow(intRow),
        isSymbolChangeBack: isSymbolChangeBackAtRow(intRow),
        stringSymbolForwardOrBack: symbolForwardOrBack(intRow),
      );
      outLogicModel.addRowModel(logicRow);
    }
    outLogicModel.check();
    return outLogicModel;
  }
}
