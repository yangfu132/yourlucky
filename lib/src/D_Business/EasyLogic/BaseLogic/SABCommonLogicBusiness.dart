import 'package:yourlucky/src/A_Context/SACGlobal.dart';
import 'package:yourlucky/src/D_Business/Base/SABBaseBusiness.dart';
import 'package:yourlucky/src/D_Business/EarthBranch/SABEarthBranchBusiness.dart';
import 'package:yourlucky/src/D_Business/EasyWords/SABCommonWordsBusiness.dart';

///公用函数类，将来需要把logic和word分开
class SABCommonLogicBusiness extends SABBaseBusiness {
  late final SABEarthBranchBusiness _branchBusiness = SABEarthBranchBusiness();
  late final SABCommonWordsBusiness _wordsBusiness = SABCommonWordsBusiness();
  bool isSymbolBorn(String stringSymbol, String otherSymbol) {
    bool bResult = false;

    if ("" != stringSymbol && "" != otherSymbol) {
      String earth = wordsBusiness().symbolEarth(stringSymbol);
      String earthOther = wordsBusiness().symbolEarth(otherSymbol);
      bResult = isEarthBorn(earthOther, earth);
    }
    //else cont.

    return bResult;
  }

  bool isSymbolConflict(String stringSymbol, String otherSymbol) {
    bool bResult = false;

    if ("" != stringSymbol && "" != otherSymbol) {
      String earth = wordsBusiness().symbolEarth(stringSymbol);
      String earthOther = wordsBusiness().symbolEarth(otherSymbol);
      bResult = branchBusiness().isEarthConflict(earthOther, earth);
    }
    //else cont.

    return bResult;
  }

  bool isSymbolRestrict(String stringSymbol, String otherSymbol) {
    bool bResult = false;

    if ("" != stringSymbol && "" != otherSymbol) {
      String stringEarth = wordsBusiness().symbolEarth(stringSymbol);
      String stringEarthOther = wordsBusiness().symbolEarth(otherSymbol);
      bResult = isEarthRestricts(stringEarthOther, stringEarth);
    }
    //else cont.
    return bResult;
  }

  bool isEarthBorn(String earth, String basicEarth) {
    return branchBusiness().isEarthBorn(earth, basicEarth);
  }

  bool isEarthRestricts(String earth, String basicEarth) {
    return branchBusiness().isEarthRestricts(earth, basicEarth);
  }

  ///`两现章第三十二`//////////////////////////////////////////////////////
  ///参见HealthLogic

  int lifeOrGoalUsefulDeity(int lifeIndex, int goalIndex,
      EasyTypeEnum easyTypeEnum, List usefulArray) {
    int result = GLOBAL_ROW_INVALID;

    //世爻位置上的用神
    for (int intItem in usefulArray) {
      if (lifeIndex == intItem) {
        result = lifeIndex;
        break;
      } //else {}
    } //end for

    if (GLOBAL_ROW_INVALID == result) {
      //应爻位置上的用神
      for (int intItem in usefulArray) {
        if (goalIndex == intItem) {
          result = goalIndex;
          break;
        } //else {}
      } //end for
    }
    //else cont.

    if (GLOBAL_ROW_INVALID == result) {
      result = unKnowUsefulDeity(easyTypeEnum, usefulArray);
    }
    //else cont.

    return result;
  }

  int unKnowUsefulDeity(EasyTypeEnum easyTypeEnum, List usefulArray) {
    int result = usefulArray[0]; //GLOBAL_ROW_INVALID;

    //TODO:yangfu132丰富用神的选取规则：按旺相休囚死的顺序排列；或者按照强弱顺序排序。
    //其实此时应该已经知道用神衰弱，事情很难成功。
    //    coLog(StackTrace.current,LogTypeEnum.error, "error!");

    return result;
  }

  ///`加载函数`//////////////////////////////////////////////////////
  SABEarthBranchBusiness branchBusiness() {
    return _branchBusiness;
  }

  SABCommonWordsBusiness wordsBusiness() {
    return _wordsBusiness;
  }
}
