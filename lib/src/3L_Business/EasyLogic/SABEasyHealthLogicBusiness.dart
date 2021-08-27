import 'package:yourlucky/src/1L_Context/SACContext.dart';
import 'package:yourlucky/src/1L_Context/SACGlobal.dart';
import 'package:yourlucky/src/3L_Business/BasicEasy/SABElementModel.dart';
import 'package:yourlucky/src/3L_Business/EarthBranch/SABEarthBranchBusiness.dart';
import 'package:yourlucky/src/3L_Business/EasyLogic/BaseLogic/SABEasyLogicBusiness.dart';
import 'package:yourlucky/src/3L_Business/EasyLogic/BaseLogic/SABEasyLogicModel.dart';
import 'package:yourlucky/src/3L_Business/EasyLogic/BaseLogic/SABRowLogicModel.dart';
import 'package:yourlucky/src/3L_Business/EasyLogic/BaseLogic/SABSymbolLogicModel.dart';
import 'package:yourlucky/src/3L_Business/EasyLogic/Health/SABEasyHealthBusiness.dart';
import 'package:yourlucky/src/3L_Business/EasyLogic/Health/SABHealthModel.dart';
import 'package:yourlucky/src/3L_Business/EasyLogic/Health/SABOutRightBusiness.dart';
import 'package:yourlucky/src/3L_Business/EasyLogic/Health/SABRowHealthModel.dart';
import 'package:yourlucky/src/3L_Business/EasyLogic/Health/SABSymbolHealthModel.dart';
import 'package:yourlucky/src/3L_Business/EasyLogic/SABEasyHealthLogicModel.dart';
import 'package:yourlucky/src/3L_Business/EasyLogic/SABRowHealthLogicModel.dart';
import 'package:yourlucky/src/3L_Business/EasyLogic/SABSymbolHealthLogicModel.dart';
import 'package:yourlucky/src/3L_Business/EasyStrategy/EasyStrategy/SABUsefulDeityModel.dart';
import 'package:yourlucky/src/3L_Business/EasyWords/SABEasyWordsModel.dart';
import 'package:yourlucky/src/3L_Business/StoreEasy/SABEasyDigitModel.dart';

class SABEasyHealthLogicBusiness {
  SABEasyHealthLogicBusiness(this._inputEasyModel);
  final SABEasyDigitModel _inputEasyModel;

  late final SABEasyHealthLogicModel _healthLogicModel = initHealthLogicModel();

  late final SABEasyLogicBusiness _logicBusiness =
      SABEasyLogicBusiness(_inputEasyModel);

  late final SABEarthBranchBusiness _branchBusiness = SABEarthBranchBusiness();

  late final SABEasyHealthBusiness _healthBusiness =
      SABEasyHealthBusiness(logicModel());

  late final SABOutRightBusiness outRightBusiness =
      SABOutRightBusiness(logicModel());

  ///`输出`
  SABEasyHealthLogicModel outputModel() {
    return _healthLogicModel;
  }

  SABSymbolHealthLogicModel fromSymbol(SABSymbolHealthModel healthSymbol) {
    int intRow = healthSymbol.logicSymbol.wordsSymbol.intRow;
    return SABSymbolHealthLogicModel(
      healthSymbol: healthSymbol,
      symbolEmptyState: symbolEmptyState(intRow, EasyTypeEnum.from),
      isSymbolDayBroken: isSymbolDayBrokenAtRow(intRow, EasyTypeEnum.from),
      conflictOnMonthState:
          symbolConflictStateOnMonth(intRow, EasyTypeEnum.from),
      conflictOnDayState: symbolDayConflictState(intRow, EasyTypeEnum.from),
      stringDeity: deityAtRow(intRow, EasyTypeEnum.from),
    );
  }

  SABSymbolHealthLogicModel toSymbol(SABSymbolHealthModel healthSymbol) {
    int intRow = healthSymbol.logicSymbol.wordsSymbol.intRow;
    return SABSymbolHealthLogicModel(
      healthSymbol: healthSymbol,
      symbolEmptyState: symbolEmptyState(intRow, EasyTypeEnum.to),
      isSymbolDayBroken: isSymbolDayBrokenAtRow(intRow, EasyTypeEnum.to),
      conflictOnMonthState: symbolConflictStateOnMonth(intRow, EasyTypeEnum.to),
      conflictOnDayState: symbolDayConflictState(intRow, EasyTypeEnum.to),
      stringDeity: deityAtRow(intRow, EasyTypeEnum.to),
    );
  }

  SABSymbolHealthLogicModel hideSymbol(SABSymbolHealthModel healthSymbol) {
    int intRow = healthSymbol.logicSymbol.wordsSymbol.intRow;
    return SABSymbolHealthLogicModel(
        healthSymbol: healthSymbol,
        symbolEmptyState: symbolEmptyState(intRow, EasyTypeEnum.hide),
        isSymbolDayBroken: isSymbolDayBrokenAtRow(intRow, EasyTypeEnum.hide),
        conflictOnMonthState:
            symbolConflictStateOnMonth(intRow, EasyTypeEnum.hide),
        conflictOnDayState: symbolDayConflictState(intRow, EasyTypeEnum.hide),
        stringDeity: deityAtRow(intRow, EasyTypeEnum.hide));
  }

  SABEasyHealthLogicModel initHealthLogicModel() {
    SABEasyHealthLogicModel logicModel = SABEasyHealthLogicModel(
      inputHealthModel: healthModel(),
      usefulDeity: usefulDeityRow(),
    );
    //此信息依赖爻的基础信息
    for (int intRow = 0; intRow < 6; intRow++) {
      SABRowHealthModel rowHealthModel = healthModel().rowModelAtRow(intRow);
      SABRowHealthLogicModel symbol = SABRowHealthLogicModel(
        healthRow: rowHealthModel,
        fromSymbol: fromSymbol(rowHealthModel.fromSymbol),
        toSymbol: toSymbol(rowHealthModel.toSymbol),
        hideSymbol: hideSymbol(rowHealthModel.hideSymbol),
        isSymbolBackMove: isSymbolBackMoveAtRow(intRow, EasyTypeEnum.from),
      );
      logicModel.addSymbol(symbol);

      logicModel.setIsSymbolChangeEmpty(intRow, isSymbolChangeEmpty(intRow));
    }
    return logicModel;
  }

  ///`加载函数`

  SABEasyHealthBusiness healthBusiness() {
    return _healthBusiness;
  }

  SABHealthModel healthModel() {
    return healthBusiness().outHealthModel1();
  }

  SABEasyWordsModel wordsModel() {
    return logicBusiness().wordsModel();
  }

  SABEasyLogicBusiness logicBusiness() {
    return _logicBusiness;
  }

  SABEasyLogicModel logicModel() {
    return _logicBusiness.outputLogicModel();
  }

  SABEarthBranchBusiness branchBusiness() {
    return _branchBusiness;
  }

  ///`SABEasyHealthDelegate`

  double symbolHealthAtRow(int nRow, EasyTypeEnum easyType) {
    return healthModel().symbolHealthAtRow(nRow, easyType);
  }

  double healthCriticalValue() {
    return healthModel().healthCritical;
  }

  List moveRightArray() {
    return healthBusiness().rowArrayAtOutRightLevel(OutRightEnum.RIGHT_MOVE);
  }

  ///`桥函数`
  String getUsefulDeity() {
    return logicModel().inputWordsModel.inputDigitModel.getUsefulDeity();
  }

  bool isEffectAbleRow(int intRow, EasyTypeEnum easyType) {
    return logicModel().symbolAtRow(intRow, easyType).isEffectAble;
  }

  String symbolAtFromRow(int intRow) {
    return wordsModel().getSymbolName(intRow, EasyTypeEnum.from);
  }

  String symbolAtToRow(int intRow) {
    return wordsModel().getSymbolName(intRow, EasyTypeEnum.to);
  }

  String symbolAtHideRow(int intRow) {
    return wordsModel().getSymbolName(intRow, EasyTypeEnum.hide);
  }

  bool isEarthRestricts(String earth, String basicEarth) {
    return branchBusiness().isEarthRestricts(earth, basicEarth);
  }

  String earthAtToRow(int intRow) {
    return wordsModel().getSymbolEarth(intRow, EasyTypeEnum.to);
  }

  bool isSymbolChangeBackAtRow(int intRow) {
    return logicModel().rowModelAtRow(intRow).isSymbolChangeBack;
  }

  bool isMovementAtRow(int intRow) {
    return logicModel().inputWordsModel.isMovementAtRow(intRow);
  }

  String earthAtFromRow(int intRow) {
    return logicModel()
        .inputWordsModel
        .getSymbolEarth(intRow, EasyTypeEnum.from);
  }

  String elementOfUsefulDeity() {
    return logicModel().inputWordsModel.elementOfUsefulDeity;
  }

  String symbolNameAtRow(int intRow, EasyTypeEnum enumEasyType) {
    return logicModel().inputWordsModel.getSymbolName(intRow, enumEasyType);
  }

  bool isEmptyAtRow(int intRow, EasyTypeEnum easyType) {
    return logicModel().symbolAtRow(intRow, easyType).isEmpty();
  }

  String monthEarth() {
    return logicModel().inputWordsModel.stringMonthEarth;
  }

  String daySky() {
    return logicModel().inputWordsModel.stringDaySky;
  }

  String dayEarth() {
    return logicModel().inputWordsModel.stringDayEarth;
  }

  String monthElement() {
    return wordsModel().stringMonthElement;
  }

  String dayElement() {
    return wordsModel().stringDayElement;
  }

  ///`六亲歌章第五`//////////////////////////////////////////////////////

  String _symbolRelative(int intRow) {
    String theEarth = wordsModel().getSymbolEarth(intRow, EasyTypeEnum.from);
    String basicEarth = wordsModel().getSymbolEarth(intRow, EasyTypeEnum.hide);

    return branchBusiness().earthRelative(theEarth, basicEarth);
  }

  ///`世应章第六 -- 世（Life） 应（Goal）`/////////////////////////////////////////

  double lifeHealth() {
    double fResult = 0;
    int lifeIndex = wordsModel().intLifeIndex;
    fResult = healthModel().symbolHealthAtRow(lifeIndex, EasyTypeEnum.from);
    return fResult;
  }

  double usefulHealth() {
    double fResult = 0;
    SABUsefulDeityModel deityModel = usefulDeityRow();
    if (EasyTypeEnum.from == deityModel.easyType ||
        EasyTypeEnum.hide == deityModel.easyType) {
      fResult = healthModel()
          .symbolHealthAtRow(deityModel.intRow, deityModel.easyType);
    } else if (EasyTypeEnum.type_null == deityModel.easyType) {
      if (ROW_MONTH == deityModel.intRow) {
        fResult = healthModel().monthHealth;
      } else if (ROW_DAY == deityModel.intRow) {
        fResult = healthModel().dayHealth;
      }
    } else if (EasyTypeEnum.to == deityModel.easyType) {
      colog("EasyTypeEnum.to do not have usefulDeity");
    } else {}

    return fResult;
  }

  double lifeHealthWithCritical() {
    return lifeHealth() - healthModel().healthCritical;
  }

  double usefulHealthWithCritical() {
    return usefulHealth() - healthModel().healthCritical;
  }

  ///`用神章第八--用神旺相`//////////////////////////////////////////////////////
  List usefulDeityRowArray(EasyTypeEnum easyType) {
    List usefulArray = [];
    String usefulParent = getUsefulDeity();

    if (usefulParent.isNotEmpty) {
      usefulArray = wordsModel().arrayRowWithParent(usefulParent, easyType);
    }
    //else cont.

    return usefulArray;
  }

  SABUsefulDeityModel usefulDeityRow() {
    return indexOfUseDeityInEasy(EasyTypeEnum.from);
  }

  bool isUsefulDeityChangeToConflict() {
    SABUsefulDeityModel deityModel = usefulDeityRow();
    if (EasyTypeEnum.from == deityModel.easyType) {
      return logicModel().getIsSymbolChangeConflict(deityModel.intRow);
    } else {
      return false;
    }
  }

  bool isUsefulDeityChangeToRestricts() {
    SABUsefulDeityModel deityModel = usefulDeityRow();
    if (EasyTypeEnum.from == deityModel.easyType) {
      return logicModel().getIsSymbolChangeRestrict(deityModel.intRow);
    } else {
      return false;
    }
  }

  bool isUsefulDeityStrong() {
    bool bResult = false;
    SABUsefulDeityModel deityModel = usefulDeityRow();
    if (EasyTypeEnum.from == deityModel.easyType) {
      bResult =
          logicModel().isSeasonStrong(deityModel.intRow, EasyTypeEnum.from);
    } else if (EasyTypeEnum.hide == deityModel.easyType) {
      bResult =
          logicModel().isSeasonStrong(deityModel.intRow, EasyTypeEnum.hide);
    } else if (EasyTypeEnum.type_null == deityModel.easyType) {
      return true;
    } else if (EasyTypeEnum.to == deityModel.easyType) {
      colog("EasyTypeEnum.to do not have usefulDeity");
    }

    return bResult;
  }

  String usefulEarth() {
    String stringEarth = "";
    SABUsefulDeityModel deityModel = usefulDeityRow();
    if (EasyTypeEnum.from == deityModel.easyType ||
        EasyTypeEnum.hide == deityModel.easyType) {
      stringEarth = logicModel().inputWordsModel.getSymbolEarth(
            deityModel.intRow,
            deityModel.easyType,
          );
    } else if (EasyTypeEnum.type_null == deityModel.easyType) {
      if (ROW_MONTH == deityModel.intRow) {
        stringEarth = logicModel().inputWordsModel.stringMonthEarth;
      } else if (ROW_DAY == deityModel.intRow) {
        stringEarth = logicModel().inputWordsModel.stringDayEarth;
      }
    } else if (EasyTypeEnum.to == deityModel.easyType) {
      colog("EasyTypeEnum.to do not have usefulDeity");
    } else {}

    return stringEarth;
  }

  ///`用神元神忌神仇神章第九`//////////////////////////////////////////////////////
  String deityAtRow(int intIndex, EasyTypeEnum enumEasyType) {
    String strResult = "";

    if (enumEasyType == EasyTypeEnum.from) {
      SABUsefulDeityModel deityModel = indexOfUseDeityInEasy(EasyTypeEnum.from);
      if (EasyTypeEnum.from == deityModel.easyType &&
          intIndex == deityModel.intRow) {
        strResult = "用神";
      } else if (EasyTypeEnum.hide == deityModel.easyType &&
          intIndex == deityModel.intRow) {
        strResult = "飞神";
      } else {
        String usefulElement = elementOfUsefulDeity();
        String currentElement =
            branchBusiness().earthElement(earthAtFromRow(intIndex));

        String parent =
            SABElementModel.elementRelative(usefulElement, currentElement);
        if ("父母" == parent) {
          strResult = "元神";
        } else if ("官鬼" == parent) {
          strResult = "忌神";
        } else if ("妻财" == parent) {
          strResult = "仇神";
        }
        //else cont.
      }
    } else if (EasyTypeEnum.to == enumEasyType)
      strResult = "变爻";
    else if (EasyTypeEnum.hide == enumEasyType) strResult = "伏神";
    //else cont.

    return strResult;
  }

  ///`元神忌神衰旺章第十`//////////////////////////////////////////////////////
  bool isDeityValid(int intIndex) {
    bool bResult = true;
    List arrayBorns = bornDeityIndexArray();
    if (-1 != arrayBorns.indexOf(intIndex)) {
      if (isBornDeityInValidAtRow(intIndex))
        bResult = false;
      else
        bResult = isBornDeityValidAtRow(intIndex);
    }
    //else cont.

    List arrayRestricts = restrictsDeityIndexArray();
    if (-1 != arrayRestricts.indexOf(intIndex)) {
      if (isRestrictDeityInvalidAtRow(intIndex))
        bResult = false;
      else
        bResult = isRestrictDeityValidAtRow(intIndex);
    }
    //else cont.

    return bResult;
  }

  List bornDeityIndexArray() {
    List arrayResult = List.empty(growable: true);
    String usefulElement = elementOfUsefulDeity();
    for (int intIndex = 0; intIndex < 6; intIndex++) {
      String currentElement =
          branchBusiness().earthElement(earthAtFromRow(intIndex));

      String parent =
          SABElementModel.elementRelative(usefulElement, currentElement);
      if ("父母" == parent) {
        arrayResult.add(intIndex);
      }
      //else cont.

    } //endf

    return arrayResult;
  }

  List restrictsDeityIndexArray() {
    List arrayResult = List.empty(growable: true);

    String usefulElement = elementOfUsefulDeity();
    for (int intIndex = 0; intIndex < 6; intIndex++) {
      String currentElement =
          branchBusiness().earthElement(earthAtFromRow(intIndex));

      String parent =
          SABElementModel.elementRelative(usefulElement, currentElement);
      if ("官鬼" == parent) {
        arrayResult.add(intIndex);
      }
      //else cont.

    } //endf

    return arrayResult;
  }

  List enemyDeityRowArray() {
    List arrayResult = List.empty(growable: true);

    String usefulElement = elementOfUsefulDeity();
    for (int intIndex = 0; intIndex < 6; intIndex++) {
      String currentElement =
          branchBusiness().earthElement(earthAtFromRow(intIndex));
      String parent =
          SABElementModel.elementRelative(usefulElement, currentElement);
      if ("妻财" == parent) {
        arrayResult.add(intIndex);
      }
      //else cont.

    } //end for

    return arrayResult;
  }

  bool isRestrictDeityValidAtRow(int intRow) {
    bool bResult = false;

    /*
     忌神动而克害用神者有五：

     忌神旺相或遇日月动爻生扶或临日月者，一也。
     忌神动化回头生化进神者，二也。
     忌神旺动临空化空，三也。
     忌神长生帝旺于日辰，四也。
     忌神与仇神同动，五也。
     以上之忌神者如斧钺之忌神也，诸占大凶。
     */

    //忌神旺相或遇日月动爻生扶或临日月者，一也。
    SABSymbolLogicModel symbolFrom =
        logicModel().symbolAtRow(intRow, EasyTypeEnum.from);
    String strSymbolBase = symbolNameAtRow(intRow, EasyTypeEnum.from);
    bool bStrong = symbolFrom.isSeasonStrong;
    bool bOnMonth = symbolFrom.isOnMonth;
    bool bOnDay = symbolFrom.isOnDay;
    bool bMonthBorn = _isSymbolMoveBorn(strSymbolBase);
    bool bDayBorn = symbolFrom.bDayBorn;
    bool bMoveBorn = isSymbolBornedByMoveAtRow(intRow, EasyTypeEnum.from);
    if (bStrong || bOnMonth || bOnDay || bMonthBorn || bDayBorn || bMoveBorn) {
      bResult = true;
    } else {
      //忌神动化回头生化进神者，二也。
      bool bToBorn = logicModel().getIsSymbolChangeBorn(intRow);
      bool bForward = logicModel().rowModelAtRow(intRow).isSymbolChangeForward;
      if (bToBorn || bForward) {
        bResult = true;
      } else {
        //忌神旺动临空化空，三也。
        bool bEmpty = isEmptyAtRow(intRow, EasyTypeEnum.from);
        bool bToEmpty = isSymbolChangeEmpty(intRow);
        bool bMoving = isMovementAtRow(intRow);
        if (bStrong && bMoving && bEmpty && bToEmpty) {
          bResult = true;
        } else {
          //忌神长生帝旺于日辰，四也。
          String stringEarthBase = symbolFrom.wordsSymbol.stringEarth;
          String stringTwelveDeity =
              branchBusiness().earthTwelveDeity(stringEarthBase, dayEarth());
          if ("长生" == stringTwelveDeity || "帝旺" == stringTwelveDeity)
            bResult = true;
          else {
            //忌神与仇神同动，五也。
            bool bMoving = isMovementAtRow(intRow);
            bool bEnemyMoving = false;
            List listEnemyDeityRow = enemyDeityRowArray();
            for (int intIndex in listEnemyDeityRow) {
              bEnemyMoving = isMovementAtRow(intIndex);
              if (bEnemyMoving) break;
              //else cont.
            } //end for

            bResult = bMoving && bEnemyMoving;
          } //end if
        } //end if
      } //end if
    } //end if
    return bResult;
  }

  bool isBornDeityValidAtRow(int intIndex) {
    /*
     元神能生用神者有五：元神旺相或临日月或动爻生扶者，一也。
     元神动化回头生及化进神者，二也。
     元神长生帝旺于日辰，三也。
     元神与忌神同动，四也。
     元神旺动临空化空，五也。
     */
    bool bResult = false;
    SABSymbolLogicModel symbolFrom =
        logicModel().symbolAtRow(intIndex, EasyTypeEnum.from);
    //元神旺相或临日月或动爻生扶者，一也。
    bool bStrong = logicModel().isSeasonStrong(intIndex, EasyTypeEnum.from);
    bool bOnMonth = symbolFrom.isOnMonth;
    bool bOnDay = symbolFrom.isOnDay;
    bool bMoveBorn = isSymbolBornedByMoveAtRow(intIndex, EasyTypeEnum.from);
    if (bStrong || bOnMonth || bOnDay || bMoveBorn) {
      bResult = true;
    } else {
      //元神动化回头生及化进神者，二也。
      bool bToBorn = logicModel().getIsSymbolChangeBorn(intIndex);
      bool bForward =
          logicModel().rowModelAtRow(intIndex).isSymbolChangeForward;
      if (bToBorn || bForward) {
        bResult = true;
      } else {
        //元神长生帝旺于日辰，三也。
        String stringEarthBase = symbolFrom.wordsSymbol.stringEarth;
        String stringTwelveDeity =
            branchBusiness().earthTwelveDeity(stringEarthBase, dayEarth());
        if ("长生" == stringTwelveDeity || "帝旺" == stringTwelveDeity)
          bResult = true;
        else {
          //元神与忌神同动，四也。
          bool bMoving = isMovementAtRow(intIndex);
          bool bRestrictMoving = false;
          List listRestrictsDeityIndex = restrictsDeityIndexArray();
          for (int numIndex in listRestrictsDeityIndex) {
            bRestrictMoving = isMovementAtRow(numIndex);
            if (bRestrictMoving) break;
            //else cont.
          } //endf

          if (bMoving && bRestrictMoving) {
            bResult = true;
          } else {
            //元神旺动临空化空，五也。
            bool bEmpty = isEmptyAtRow(intIndex, EasyTypeEnum.from);
            bool bToEmpty = isSymbolChangeEmpty(intIndex);
            if (bStrong && bMoving && bEmpty && bToEmpty) {
              bResult = true;
            }
            //else cont.
          } //end if
        } //end if
      } //end if
    } //end if

    return bResult;
  }

  bool isBasicInvalidAtRow(int intRow) {
    bool bResult = false;

    //休囚不动，动而休囚被日月动爻克者，一也。
    bool bSeasonStrong = logicModel().isSeasonStrong(intRow, EasyTypeEnum.from);
    if (!isMovementAtRow(intRow)) {
      bResult = bSeasonStrong;
    } else {
      String stringBasicElement =
          branchBusiness().earthElement(earthAtFromRow(intRow));
      //判断月建是否克此爻

      String strMonthParent =
          SABElementModel.elementRelative(stringBasicElement, monthElement());
      bool bMonthRestricts = "官鬼" == strMonthParent;

      //判断日建是否克此爻
      String strDayParent =
          SABElementModel.elementRelative(stringBasicElement, dayElement());
      bool bDayRestricts = "官鬼" == strDayParent;

      bool bMoveRestricts =
          isSymbolRestrictedByMoveAtIndex(intRow, EasyTypeEnum.from);

      bResult =
          !bSeasonStrong && bMonthRestricts && bDayRestricts && bMoveRestricts;
    } //end if

    return bResult;
  }

  bool isRestrictDeityInvalidAtRow(int intRow) {
    bool bResult = false;

    EasyTypeEnum enumEasyType = EasyTypeEnum.from;

    /*
     忌神虽动又有不能克用神者有七：
     忌神休囚不动，动而休囚被日月动爻克者，一也。
     忌神静临空破，二也。
     忌神入三墓，三也。
     忌神衰动化退神，四也。
     忌神衰而又绝，五也。
     忌神动化绝化克化破化散，六也。
     忌神与元神同动，七也。
     此忌神者乃无力之忌神也，诸占化凶为吉。
     */

    //忌神休囚不动，动而休囚被日月动爻克者，一也。
    if (isBasicInvalidAtRow(intRow)) {
      bResult = true;
    } else {
      //忌神静临空破，二也。
      bool bEmpty = isEmptyAtRow(intRow, EasyTypeEnum.from);
      bool bBroken = MonthConflictEnum.Conflict_Broken ==
          symbolConflictStateOnMonth(intRow, EasyTypeEnum.from);
      bool bMoving = isMovementAtRow(intRow);
      if ((!bMoving && bEmpty && bBroken))
        bResult = true;
      else {
        //忌神入三墓，三也。
        if (isSymbolMuAtRow(intRow, enumEasyType))
          bResult = true;
        else {
          //忌神衰动化退神，四也。
          bool bShuai = isSymbolShuaiAtRow(intRow, enumEasyType);
          bool bFrowardBack = isSymbolChangeBackAtRow(intRow);

          if (bShuai && bFrowardBack) {
            bResult = true;
          } else {
            //忌神衰而又绝，五也。
            bool bJue = isSymbolJueAtRow(intRow, enumEasyType);
            if (bShuai && bJue)
              bResult = true;
            else {
              //忌神动化绝化克化破化散，六也。
              bool bRestrict = false;
              String fromEarth = earthAtFromRow(intRow);
              String toEarth = earthAtToRow(intRow);

              //化克
              if ("" != toEarth)
                bRestrict = isEarthRestricts(toEarth, fromEarth);
              //else cont.

              //化破
              bool bToDayBroken = false;
              bool bToMonthBroken = false;
              bToDayBroken = isSymbolDayBrokenAtRow(intRow, enumEasyType);
              bToMonthBroken = (MonthConflictEnum.Conflict_Broken ==
                  symbolConflictStateOnMonth(intRow, EasyTypeEnum.to));

              if (bRestrict || bToDayBroken || bToMonthBroken) {
                bResult = true;
              } else {
                //忌神与元神同动，七也。
                bool bBornMoving = false;
                List listBornDeityIndex = bornDeityIndexArray();
                for (int numIndex in listBornDeityIndex) {
                  bBornMoving = isMovementAtRow(numIndex);
                  if (bBornMoving) break;
                  //else cont.
                } //endf

                if (bMoving && bBornMoving) {
                  bResult = true;
                }
              } //endi
            } //endi
          } //endi
        } //endi
      } //endi
    } //endi

    return bResult;
  }

  bool isBornDeityInValidAtRow(int intRow) {
    bool bResult = true;
    EasyTypeEnum easyType = EasyTypeEnum.from;
    /*
     元神虽现又有不能生用神者用六：
     以上见生不生，为无用之元神也，虽有如无。
     */
    //元神休囚不动，或动而休囚又被伤克者，一也。
    if (isBasicInvalidAtRow(intRow)) {
      bResult = true;
    } else {
      //元神休囚又逢旬空月破，二也。
      bool bStrong = logicModel().isSeasonStrong(intRow, EasyTypeEnum.from);
      bool bEmpty = isEmptyAtRow(intRow, EasyTypeEnum.from);
      bool bBroken = MonthConflictEnum.Conflict_Broken ==
          symbolConflictStateOnMonth(intRow, EasyTypeEnum.from);
      if ((!bStrong && bEmpty) || (!bStrong && bBroken))
        bResult = true;
      else {
        //元神休囚动化退神，三也。
        bool bFrowardBack = isSymbolChangeBackAtRow(intRow);
        if (!bStrong && bFrowardBack) {
          bResult = true;
        } else {
          //元神衰而又绝，四也。
          bool bShuai = isSymbolShuaiAtRow(intRow, easyType);
          bool bJue = isSymbolJueAtRow(intRow, easyType);
          if (bShuai && bJue)
            bResult = true;
          else {
            //元神入三墓，五也。
            if (isSymbolMuAtRow(intRow, easyType))
              bResult = true;
            else {
              //元神休囚动而化绝化克化破化散，六也。
              bool bRestrict = false;
              String fromEarth = earthAtFromRow(intRow);
              String toEarth = earthAtToRow(intRow);
              if ("" != toEarth)
                bRestrict = isEarthRestricts(toEarth, fromEarth);
              //else cont.

              //化破
              bool bToDayBroken = false;
              bool bToMonthBroken = false;
              bToDayBroken = isSymbolDayBrokenAtRow(intRow, easyType);
              bToMonthBroken = (MonthConflictEnum.Conflict_Broken ==
                  symbolConflictStateOnMonth(intRow, EasyTypeEnum.to));

              if (!bStrong) {
                if (bJue || bRestrict || bToMonthBroken || bToDayBroken)
                  bResult = true;
                //else cont.
              }
              //else cont.

            } //endi
          } //endi
        } //endi

      } //endi

    } //endi
    return bResult;
  }

  ///墓
  bool isSymbolMuAtRow(int intRow, EasyTypeEnum easyType) {
    bool bResult = false;
    //个人猜测应该是日月动三者合力的结果
    //墓与生相对，看此爻在三者上差额
    if (easyType == EasyTypeEnum.from) {
      String fromEarth = earthAtFromRow(intRow);
      String toEarth = earthAtToRow(intRow);

      String monthTwelve =
          branchBusiness().earthTwelveDeity(fromEarth, monthEarth());
      String dayTwelve =
          branchBusiness().earthTwelveDeity(fromEarth, dayEarth());

      String toTwelve = branchBusiness().earthTwelveDeity(fromEarth, toEarth);

      int nValue = 0;

      if ("长生" == monthTwelve) nValue++;
      //else cont.

      if ("长生" == dayTwelve) nValue++;
      //else cont.

      if ("长生" == toTwelve) nValue++;
      //else cont.

      if ("墓" == monthTwelve) nValue--;
      //else cont.

      if ("墓" == dayTwelve) nValue--;
      //else cont.

      if ("墓" == toTwelve) nValue--;
      //else cont.

      bResult = nValue < 0;
    } else
      colog("error!");

    return bResult;
  }

//衰
  bool isSymbolShuaiAtRow(int intRow, EasyTypeEnum easyType) {
    //无动爻生，日月上不敌，即是衰。
    bool bResult = false;
    if (EasyTypeEnum.from != easyType) {
      return bResult;
    }
    SABRowLogicModel rowModel = logicModel().rowModelAtRow(intRow);
    bool bBorn = rowModel.isSymbolChangeBorn;

    //月克日生或月生日克，是相敌。月破日生或月生日破是不敌等等。
    //还有月合日克或日合月克是可敌。

    bool bBalance = false;
    SABSymbolLogicModel symbolFrom =
        logicModel().symbolAtRow(intRow, EasyTypeEnum.from);
    bool bOnDay = symbolFrom.isOnDay;
    bool bOnMonth = symbolFrom.isOnMonth;

    if (bOnDay || bOnMonth)
      bBalance = true;
    else {
      //生克
      bool bMonthBorn = symbolFrom.bMonthBorn;
      bool bDayBorn = symbolFrom.bDayBorn;
      bool bMonthRestrict = symbolFrom.isMonthRestrict;
      bool bDayRestrict = symbolFrom.isDayRestrict;

      //冲合
      bool bDayConflict = symbolFrom.isConflictDay;
      bool bDayPair = symbolFrom.isDayPair;
      bool bMonthConflict = symbolFrom.isConflictMonth;
      bool bMonthPair = symbolFrom.isMonthPair;

      if (bMonthRestrict) {
        bBalance = bDayBorn;
      } else if (bDayRestrict) {
        bBalance = bMonthBorn;
      } else if (bMonthConflict) {
        bBalance = bDayPair;
      } else if (bDayConflict) {
        bBalance = bMonthPair;
      } else
        bBalance = true;
    } //endi

    bResult = !bBorn && !bBalance;

    return bResult;
  }

//绝
  bool isSymbolJueAtRow(int intRow, EasyTypeEnum easyType) {
    bool bResult = false;
    //个人猜测应该是日月动三者合力的结果
    //绝与帝旺相对，看此爻在三者上的绝与帝旺的差额：如果绝大于帝旺的个数
    if (easyType == EasyTypeEnum.from) {
      String fromEarth = earthAtFromRow(intRow);
      String toEarth = earthAtToRow(intRow);

      String monthTwelve =
          branchBusiness().earthTwelveDeity(fromEarth, monthEarth());
      String dayTwelve =
          branchBusiness().earthTwelveDeity(fromEarth, dayEarth());

      String toTwelve = branchBusiness().earthTwelveDeity(fromEarth, toEarth);

      int nValue = 0;

      if ("帝旺" == monthTwelve) nValue++;
      //else cont.

      if ("帝旺" == dayTwelve) nValue++;
      //else cont.

      if ("帝旺" == toTwelve) nValue++;
      //else cont.

      if ("绝" == monthTwelve) nValue--;
      //else cont.

      if ("绝" == dayTwelve) nValue--;
      //else cont.

      if ("绝" == toTwelve) nValue--;
      //else cont.

      bResult = nValue < 0;
    } else
      colog("error!");

    return bResult;
  }

  ///`动静生克章第十四`//////////////////////////////////////////////////////

  ///被动爻生
  bool isSymbolBornedByMoveAtRow(int intIndex, EasyTypeEnum easyType) {
    bool bResult = false;

    if (isEffectAbleRow(intIndex, easyType)) {
      String stringSymbol = "";

      if (easyType == EasyTypeEnum.from)
        stringSymbol = symbolAtFromRow(intIndex);
      else if (easyType == EasyTypeEnum.hide)
        stringSymbol = symbolAtHideRow(intIndex);
      //else cont.

      bResult = _isSymbolMoveBorn(stringSymbol);
    }
    //else cont.

    return bResult;
  }

  ///被动爻生
  bool _isSymbolMoveBorn(String stringSymbol) {
    bool bResult = false;
    List arrayEffects = moveRightArray();
    for (int numItem in arrayEffects) {
      String stringSymbolItem = symbolAtFromRow(numItem);
      if (logicBusiness().isSymbolBorn(stringSymbol, stringSymbolItem)) {
        bResult = true;
        break;
      }
      //else cont.

    } //endf
    return bResult;
  }

  ///被动爻克
  bool isSymbolRestrictedByMoveAtIndex(int intIndex, EasyTypeEnum easyType) {
    bool bResult = false;
    List arrayEffects = moveRightArray();

    String stringSymbol = "";

    if (easyType == EasyTypeEnum.from)
      stringSymbol = symbolAtFromRow(intIndex);
    else if (easyType == EasyTypeEnum.hide)
      stringSymbol = symbolAtHideRow(intIndex);
    else
      colog("error!");

    for (int numItem in arrayEffects) {
      String stringSymbolItem = symbolAtFromRow(numItem);
      if (isEffectAbleRow(numItem, EasyTypeEnum.from)) {
        if (logicBusiness().isSymbolRestrict(stringSymbol, stringSymbolItem)) {
          bResult = true;
          break;
        }
        //else cont.
      }
      //else cont.
    } //endf
    return bResult;
  }

  bool isSymbolHealthStrong(int intRow, EasyTypeEnum easyType) {
    bool bResult = false;
    final health = healthModel().symbolHealthAtRow(intRow, easyType);
    bResult = health > healthModel().healthCritical;
    return bResult;
  }

  ///`月将章第十六`//////////////////////////////////////////////////////

  ///`六合章第十九`//////////////////////////////////////////////////////
  ///`--爻的三合`//////////////////////////////////////////////////////

  List virtualEarthThreePair(List arrayPair, List arrayRow) {
    List arrayResult = [];

    List arrayEarth = wordsModel().earthAtMergeRowArray(arrayRow);

    List arrayRowPaired = [];
    for (String item in arrayPair) {
      if (-1 != arrayEarth.indexOf(item)) {
        arrayRowPaired.add(arrayEarth.indexOf(item));
      }
      //else cont.
    } //endf

    if (arrayRowPaired.length == 3) {
      List movementArray = moveRightArray();

      for (String item in arrayRowPaired) {
        if (-1 == movementArray.indexOf(item)) arrayResult.add(item);
        //else cont.
      } //endf
    }
    //else cont.

    return arrayResult;
  }

  ///`暗动章第二十二`//////////////////////////////////////////////////////

  ///暗动
  bool isSymbolBackMoveAtRow(int intRow, EasyTypeEnum easyType) {
    bool result = false;
    if (!isMovementAtRow(intRow)) {
      if (logicModel().symbolAtRow(intRow, easyType).isConflictDay) {
        result = isSymbolHealthStrong(intRow, easyType);
      }
      //else cont.
    }
    //else cont.

    return result;
  }

  /// `--旬空章第二十六`///////////////////////////////////////////////////////////

  EmptyEnum symbolEmptyState(int intRow, EasyTypeEnum easyType) {
    EmptyEnum nResult = EmptyEnum.Empty_False;

    String stringSymbol = symbolNameAtRow(intRow, easyType);
    SABSymbolLogicModel symbolModel =
        logicModel().symbolAtRow(intRow, easyType);
    if ("" != stringSymbol) {
      String earth = symbolModel.wordsSymbol.stringEarth;
      if (-1 != logicModel().stringEmptyBranch.indexOf(earth)) {
        String strDay = dayEarth();
        if (logicBusiness().isEarthConflict(strDay, earth)) {
          //爻遇旬空，日辰冲起而为用，谓之冲空则实。
          nResult = EmptyEnum.Empty_Conflict;
        } else if (isFalseEmptyAtRow(intRow, easyType)) {
          nResult = EmptyEnum.Empty_False;
        } else if (isRealEmpty(intRow, easyType)) {
          nResult = EmptyEnum.Empty_Real;
        } else {
          nResult = EmptyEnum.Empty_YES;
        }
      } //else cont.
    } else {
      colog("error!");
    }

    return nResult;
  }

  bool isFalseEmptyAtRow(int intRow, EasyTypeEnum easyType) {
    /*
     旺不为空；
     动不为空；
     有日建动爻生扶者，亦不为空；
     动而化空，
     伏而旺相皆不为空。
     */
    bool bResult = false;

    String stringSymbol = symbolNameAtRow(intRow, easyType);
    final symbolModel = logicModel().symbolAtRow(intRow, easyType);
    String strSeason = symbolModel.stringSeason;

    //旺不为空；
    bResult = bResult || "旺" == strSeason;

    if (easyType == EasyTypeEnum.from) {
      bool bMove = wordsModel().isMovementAtRow(intRow);

      //动不为空；
      bResult = bResult || bMove;
    }
    //else cont.

    //有日建生扶者，亦不为空；
    bool bDayBorn = symbolModel.bDayBorn;
    bResult = bResult || bDayBorn;

    if (easyType == EasyTypeEnum.from || easyType == EasyTypeEnum.hide) {
      //有动爻生扶者，亦不为空；
      bool bMoveBorn = _isSymbolMoveBorn(stringSymbol);
      bResult = bResult || bMoveBorn;
    }
    //else cont.

    if (easyType == EasyTypeEnum.from) {
      //动而化空
      bool bChangeEmpty = isSymbolChangeEmpty(intRow);
      bResult = bResult || bChangeEmpty;
    }
    //else cont.

    if (easyType == EasyTypeEnum.hide) {
      //伏而旺相皆不为空
      bool bHideStrong = symbolModel.isSeasonStrong;
      bResult = bResult || bHideStrong;
    }
    //else cont.

    return bResult;
  }

  bool isRealEmpty(int intRow, EasyTypeEnum easyType) {
    bool bResult = false;
    /*
     月破为空，
     有气不动亦为空，
     伏而被克亦为空，
     真空为空，真空者，春土夏金秋是木，三冬逢火是真空。
     */
    String stringSymbol = symbolNameAtRow(intRow, easyType);

    //月破为空
    MonthConflictEnum stateEmpty = symbolConflictStateOnMonth(intRow, easyType);

    if (MonthConflictEnum.Conflict_NO == stateEmpty ||
        MonthConflictEnum.Conflict_Move == stateEmpty ||
        MonthConflictEnum.Conflict_MoveBorn == stateEmpty) {
    } else
      bResult = true;

    //有气不动亦为空
    final symbolModel = logicModel().symbolAtRow(intRow, easyType);
    String stringSymbolSeason = symbolModel.stringSeason;

    bool bWang = ("旺" == stringSymbolSeason) || ("相" == stringSymbolSeason);

    bool bMove = wordsModel().isMovementAtRow(intRow);
    if (!bMove && !bWang) bResult = true;
    //else cont.

    //伏而被克亦为空
    if (easyType == EasyTypeEnum.hide) {
      String fromSymbol = symbolAtFromRow(intRow);
      logicBusiness().isSymbolRestrict(stringSymbol, fromSymbol);
    }
    //else cont.

    //真空为空，真空者，春土夏金秋是木，三冬逢火是真空。
    bool bRealEmpty = "死" == stringSymbolSeason;
    if (bRealEmpty) bResult = true;
    return bResult;
  }

  bool isSymbolChangeEmpty(int intRow) {
    bool bResult = false;
    if (isMovementAtRow(intRow)) {
      bResult = isEmptyAtRow(intRow, EasyTypeEnum.to);
    }
    //else cont.

    return bResult;
  }

  ///`月破章第二十七`//////////////////////////////////////////////////////
  MonthConflictEnum symbolConflictStateOnMonth(
      int intRow, EasyTypeEnum easyType) {
    MonthConflictEnum nResult = MonthConflictEnum.Conflict_NO;
    final symbolModel = logicModel().symbolAtRow(intRow, easyType);
    bool conflictMonth = symbolModel.isConflictMonth;
    if (conflictMonth) {
      String stringSymbol = wordsModel().getSymbolName(intRow, easyType);
      String basicEarth = symbolModel.wordsSymbol.stringEarth;
      nResult = MonthConflictEnum.Conflict_Broken;

      String strDayEarth = dayEarth();
      if (strDayEarth == basicEarth)
        nResult = MonthConflictEnum.Conflict_OnDay;
      else if (isMovementAtRow(intRow)) {
        nResult = MonthConflictEnum.Conflict_Move;
      } else {
        //唯静而不动，又无日辰动爻生助，实则到底而破矣。
        if (branchBusiness().isEarthBorn(dayEarth(), basicEarth)) {
          nResult = MonthConflictEnum.Conflict_DayBorn;
        } else if (_isSymbolMoveBorn(stringSymbol)) {
          nResult = MonthConflictEnum.Conflict_MoveBorn;
        }
        //else cont.
      } //end if
    }
    //else cont.

    return nResult;
  }

//冲衰弱之静爻则为日破
  bool isSymbolDayBrokenAtRow(int intRow, EasyTypeEnum easyType) {
    bool result = false;
    if (!isSymbolHealthStrong(intRow, easyType)) {
      if (!wordsModel().isMovementAtRow(intRow)) {
        result = logicModel().symbolAtRow(intRow, easyType).isConflictDay;
      }
      //else cont.
    }
    //else cont.

    return result;
  }

  ///`飞伏章第二十八`//////////////////////////////////////////////////////

  ///冲衰弱之静爻则为日破
  DayConflictEnum symbolDayConflictState(int intRow, EasyTypeEnum easyType) {
    DayConflictEnum nResult = DayConflictEnum.Conflict_NO;
    final symbolModel = logicModel().symbolAtRow(intRow, easyType);
    bool bConflict = branchBusiness().isEarthConflict(
        dayEarth(), wordsModel().getSymbolEarth(intRow, easyType));
    if (bConflict) {
      nResult = DayConflictEnum.Conflict_YES;

      if (wordsModel().isMovementAtRow(intRow)) {
        if (symbolModel.isSeasonStrong)
          nResult = DayConflictEnum.Conflict_SAN;
        else
          nResult = DayConflictEnum.Conflict_SAN;
      } else {
        if (symbolModel.isSeasonStrong)
          nResult = DayConflictEnum.Conflict_BackMove;
        else
          nResult = DayConflictEnum.Conflict_BROKEN;
      } //endi
    }
    //else cont.

    return nResult;
  }

  bool isHideDeityInvalidAtRow(int intRow) {
    bool bResult = false;
    /*
     又伏神终不得出者有五。
     伏神休囚无气者，一也。
     伏神被日月冲克者，二也。
     伏神被旺相之飞神克害者，三也。
     伏神墓绝于日月飞爻者，四也。
     伏神休囚值旬空月破者，五也。
     此五者乃无用之伏神也，虽有如无，终不能出。

     */

    String basicSymbol = symbolAtHideRow(intRow);
    final symbolModel = logicModel().symbolAtRow(intRow, EasyTypeEnum.hide);
    if (basicSymbol.isNotEmpty) {
      //伏神休囚无气者，一也。
      bool bStrong = isSymbolHealthStrong(intRow, EasyTypeEnum.hide);
      if (!bStrong) {
        bResult = true;
      } else {
        //伏神被日月冲克者，二也。
        bool bFromDayConflict = DayConflictEnum.Conflict_NO !=
            symbolDayConflictState(intRow, EasyTypeEnum.hide);
        bool bFromMonthConflict = MonthConflictEnum.Conflict_NO !=
            symbolConflictStateOnMonth(intRow, EasyTypeEnum.hide);
        bool bFromMonthRestrict = symbolModel.isMonthRestrict;
        bool bFromDayRestrict = symbolModel.isDayRestrict;

        if (bFromDayConflict ||
            bFromMonthConflict ||
            bFromMonthRestrict ||
            bFromDayRestrict) {
          bResult = true;
        } else {
          //伏神被旺相之飞神克害者，三也。
          String strRelative = _symbolRelative(intRow);
          bool bFromStrong =
              logicModel().isSeasonStrong(intRow, EasyTypeEnum.hide);
          if ("官鬼" == strRelative && bFromStrong) {
            bResult = true;
          } else {
            //伏神墓绝于日月飞爻者，四也。
            String basicEarth = symbolModel.wordsSymbol.stringEarth;
            String fromEarth =
                wordsModel().getSymbolEarth(intRow, EasyTypeEnum.from);

            String monthTwelve =
                branchBusiness().earthTwelveDeity(basicEarth, monthEarth());
            String dayTwelve =
                branchBusiness().earthTwelveDeity(basicEarth, dayEarth());
            String fromTwelve =
                branchBusiness().earthTwelveDeity(basicEarth, fromEarth);
            if (monthTwelve.isNotEmpty ||
                dayTwelve.isNotEmpty ||
                fromTwelve.isNotEmpty) {
              bResult = true;
            } else {
              //伏神休囚值旬空月破者，五也。

              bool bEmpty = isEmptyAtRow(intRow, EasyTypeEnum.hide);
              bool bMonthBroken = MonthConflictEnum.Conflict_Broken ==
                  symbolConflictStateOnMonth(intRow, EasyTypeEnum.from);
              if (bEmpty || bMonthBroken || !bStrong) {
                bResult = true;
              }
              //else cont.
            }
          } //endi
        } //endi
      } //endi
    }
    //else cont.

    return bResult;
  }

  bool isHideDeityValidAtRow(int intRow) {
    bool bResult = false;
    /*
     伏神有用者有六；
     伏神得日月者，一也。
     伏神旺相者，二也。
     伏神得飞神生者，三也。
     伏神得动爻生者，四也。
     伏神得遇日月动爻冲克飞神者，五也。
     伏神得遇飞神空破休囚墓绝者，六也。
     */

    //伏神得日月者，一也。
    String basicSymbol = symbolAtHideRow(intRow);
    final symbolHide = logicModel().symbolAtRow(intRow, EasyTypeEnum.hide);
    final symbolFrom = logicModel().symbolAtRow(intRow, EasyTypeEnum.from);
    if (basicSymbol.isNotEmpty) {
      bool bOnDay = symbolHide.isOnDay;
      bool bOnMonth = symbolHide.isOnMonth;
      if (bOnDay || bOnMonth) {
        bResult = true;
      } else {
        //伏神旺相者，二也。
        if (isSymbolHealthStrong(intRow, EasyTypeEnum.hide)) {
          bResult = true;
        } else {
          //伏神得飞神生者，三也。
          String fromSymbol = symbolAtFromRow(intRow);
          String strRelative = _symbolRelative(intRow);
          if ("父母" == strRelative) {
            bResult = true;
          } else {
            //伏神得动爻生者，四也。
            if (_isSymbolMoveBorn(basicSymbol)) {
              bResult = true;
            } else {
              //伏神得遇日月动爻冲克飞神者，五也。
              bool bFromDayConflict = DayConflictEnum.Conflict_NO !=
                  symbolDayConflictState(intRow, EasyTypeEnum.from);
              bool bFromMonthConflict = MonthConflictEnum.Conflict_NO !=
                  symbolConflictStateOnMonth(intRow, EasyTypeEnum.from);
              bool bFromMoveConflict = _isSymbolMoveConflict(fromSymbol);
              bool bFromMonthRestrict = symbolFrom.isMonthRestrict;
              bool bFromDayRestrict = symbolFrom.isDayRestrict;
              bool bFromMoveRestrict =
                  isSymbolRestrictedByMoveAtIndex(intRow, EasyTypeEnum.from);

              if (bFromDayConflict ||
                  bFromMonthConflict ||
                  bFromMoveConflict ||
                  bFromMonthRestrict ||
                  bFromDayRestrict ||
                  bFromMoveRestrict) {
                bResult = true;
              } else {
                //伏神得遇飞神空破休囚墓绝者，六也。
                bool bFromEmpty = isEmptyAtRow(intRow, EasyTypeEnum.hide);
                bool bFromMonthBroken = MonthConflictEnum.Conflict_Broken ==
                    symbolConflictStateOnMonth(intRow, EasyTypeEnum.from);
                bool bFromDayBroken = DayConflictEnum.Conflict_BROKEN ==
                    symbolDayConflictState(intRow, EasyTypeEnum.from);
                bool bFromStrong =
                    logicModel().isSeasonStrong(intRow, EasyTypeEnum.from);

                bool bFromMu = isSymbolMuAtRow(intRow, EasyTypeEnum.from);
                bool bFromJue = isSymbolJueAtRow(intRow, EasyTypeEnum.from);
                if (bFromEmpty ||
                    bFromMonthBroken ||
                    bFromDayBroken ||
                    !bFromStrong ||
                    bFromMu ||
                    bFromJue) {
                  bResult = true;
                }
                //else cont.

              } //endi
            } //endi
          } //endi
        } //endi
      } //endi
    }
    //else cont.

    return bResult;
  }

  bool _isSymbolMoveConflict(String stringSymbol) {
    bool bResult = false;

    List arrayEffects = moveRightArray();

    for (int numItem in arrayEffects) {
      String stringSymbolItem = symbolAtFromRow(numItem);
      if (isEffectAbleRow(numItem, EasyTypeEnum.from)) {
        if (logicBusiness().isEarthConflict(
            logicBusiness().symbolEarth(stringSymbol),
            logicBusiness().symbolEarth(stringSymbolItem))) {
          bResult = true;
          break;
        }
        //else cont.
      }
      //else cont.
    } //endf
    return bResult;
  }

  List usefulDeityHideRowArray() {
    List usefulArray = [];
    String usefulParent = getUsefulDeity();

    if (usefulParent.isNotEmpty) {
      usefulArray =
          wordsModel().arrayRowWithParent(usefulParent, EasyTypeEnum.hide);
    }
    //else cont.

    return usefulArray;
  }

  ///`两现章第三十二`//////////////////////////////////////////////////////

  SABUsefulDeityModel noUsefulDeity() {
    SABUsefulDeityModel resultModel;
    String usefulParent = getUsefulDeity();
    String fromEasyElement = wordsModel().stringFromElement;
    String monthParent =
        SABElementModel.elementRelative(fromEasyElement, monthElement());
    if (monthParent == usefulParent) {
      resultModel = SABUsefulDeityModel(
        intRow: ROW_MONTH,
        easyType: EasyTypeEnum.type_null,
      );
    } else {
      String dayParent =
          SABElementModel.elementRelative(fromEasyElement, dayElement());
      if (dayParent == usefulParent) {
        resultModel = SABUsefulDeityModel(
          intRow: ROW_DAY,
          easyType: EasyTypeEnum.type_null,
        );
      } else {
        resultModel = indexOfUseDeityInEasy(EasyTypeEnum.hide);
      } //endi
    } //endi

    return resultModel;
  }

  SABUsefulDeityModel indexOfUseDeityInEasy(EasyTypeEnum easyTypeEnum) {
    SABUsefulDeityModel resultModel;
    List usefulArray =
        wordsModel().arrayRowWithParent(getUsefulDeity(), easyTypeEnum);

    if (usefulArray.length == 1) {
      resultModel = SABUsefulDeityModel(
        intRow: usefulArray[0],
        easyType: easyTypeEnum,
      );
    } else if (usefulArray.length > 1) {
      resultModel = SABUsefulDeityModel(
        intRow: multiUsefulDeity(easyTypeEnum, usefulArray),
        easyType: easyTypeEnum,
      );
    } else {
      resultModel = noUsefulDeity();
    }

    return resultModel;
  }

  List strongUsefulArray(EasyTypeEnum easyTypeEnum, List usefulArray) {
    //舍其休囚而用旺相；
    List strongArray = List.empty(growable: true);

    double maxValue = -10000;

    for (int intItem in usefulArray) {
      double strongValue = symbolHealthAtRow(intItem, easyTypeEnum);
      if (maxValue < strongValue) {
        maxValue = strongValue;
      }
      //else cont.
    } //endf

    for (int intItem in usefulArray) {
      double strongValue = symbolHealthAtRow(intItem, easyTypeEnum);
      if (strongValue == maxValue) {
        strongArray.add(intItem);
      }
      //else cont.

    } //endi

    return strongArray;
  }

  int strongUsefulDeity(EasyTypeEnum easyTypeEnum, List usefulArray) {
    int result = GLOBAL_ROW_INVALID;

    //旺、相、余气, 依次选用,有旺用旺，如果有多个旺，通过动静区分；

    List strongArray = strongUsefulArray(easyTypeEnum, usefulArray);

    if (0 == strongArray.length) {
      result = logicBusiness().lifeOrGoalUsefulDeity(easyTypeEnum, usefulArray);
    } else if (1 == strongArray.length) {
      result = strongArray[0];
    } else if (strongArray.length > 1) {
      result = logicBusiness().lifeOrGoalUsefulDeity(easyTypeEnum, strongArray);
    }

    return result;
  }

  int emptyUsefulDeity(EasyTypeEnum easyTypeEnum, List usefulArray) {
    int result = GLOBAL_ROW_INVALID;

    List listEmpty = logicBusiness().emptyArray(easyTypeEnum, usefulArray);

    if (0 == listEmpty.length) {
      result = movementUsefulDeity(easyTypeEnum, usefulArray);
    } else if (1 == listEmpty.length) {
      result = listEmpty[0];
    } else if (listEmpty.length > 1) {
      result = movementUsefulDeity(easyTypeEnum, listEmpty);
    }

    return result;
  }

  int movementUsefulDeity(EasyTypeEnum easyTypeEnum, List usefulArray) {
    int result = GLOBAL_ROW_INVALID;

    List movementArray = logicBusiness().movementArrayInArray(usefulArray);
    if (0 == movementArray.length) {
      result = strongUsefulDeity(easyTypeEnum, usefulArray);
    } else if (1 == movementArray.length) {
      result = movementArray[0];
    } else if (movementArray.length > 1) {
      result = strongUsefulDeity(easyTypeEnum, movementArray);
    }
    return result;
  }

  ///****************************************************************
  ///  古法：舍其月破而用不破；     野鹤：舍其不破而用月破(采用)；
  ///  舍其旬空而用不空；          野鹤：舍其不空而用旬空；
  /// 舍其静爻而用动爻；
  ///  舍其休囚而用旺相；
  /// 舍其被伤而用不伤。
  ///  ****************************************************************/

  int multiUsefulDeity(EasyTypeEnum easyTypeEnum, List usefulArray) {
    int result = GLOBAL_ROW_INVALID;

    List listMonthBroken = monthBrokenArray(easyTypeEnum, usefulArray);
    if (0 == listMonthBroken.length) {
      result = emptyUsefulDeity(easyTypeEnum, usefulArray);
    } else if (1 == listMonthBroken.length) {
      result = listMonthBroken[0];
    } else if (listMonthBroken.length > 1) {
      result = emptyUsefulDeity(easyTypeEnum, listMonthBroken);
    }
    return result;
  }

  List monthBrokenArray(EasyTypeEnum easyTypeEnum, List usefulArray) {
    //古法：舍其月破而用不破；     野鹤：舍其不破而用月破(采用)；
    List listMonthBroken = List.empty(growable: true);
    for (int intRow in usefulArray) {
      if (MonthConflictEnum.Conflict_NO !=
          symbolConflictStateOnMonth(intRow, easyTypeEnum))
        listMonthBroken.add(intRow);
      //else cont.

    } //endf

    return listMonthBroken;
  }
}
