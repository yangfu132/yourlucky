﻿import 'package:yourlucky/src/1L_Context/SACContext.dart';

import '../BasicEasy/SABElementModel.dart';
import 'SABEarthBranchModel.dart';

class SABEarthBranchBusiness {
  final SABEarthBranchModel _branchModel = SABEarthBranchModel();

  String sixPairDescription(String basicEarth, String otherEarth) {
    String? result;

    String strKey = basicEarth + otherEarth;
    result = _branchModel.getSixPairDescription()[strKey];
    return result ?? "";
  }

  bool isEarthConflict(String basicEarth, String otherEarth) {
    bool result = false;

    String? timeEarth = _branchModel.getSixConflict()[basicEarth];
    if (null != timeEarth) {
    } else {
      result = false;
      colog("卦中用神未现!");
    }
    return result;
  }

  String getSixConflict(String basicEarth) {
    return _branchModel.getSixConflict()[basicEarth];
  }

  bool isEarthEqual(String itemEarth, String atEarth) {
    return itemEarth == atEarth;
  }

  bool isEarthPair(String itemEarth, String atEarth) {
    return earthSixPair(itemEarth) == atEarth;
  }

  String earthTwelveDeity(String itemEarth, String atEarth) {
    String strResult = "";

    Map? oneData = _branchModel.twelveGold()[itemEarth];
    //长生
    if (null != oneData) {
      strResult = oneData[atEarth];
    } else {
      colog("earthTwelveDeity error");
    }

    return strResult;
  }

  String earthSixPair(String earth) {
    return _branchModel.earthSixPair()[earth];
  }

  String earthRelative(String theEarth, String basicEarth) {
    return SABElementModel.elementRelative(
        earthElement(basicEarth), earthElement(theEarth));
  }

  String earthEffect(String earth, String basicEarth) {
    String result = "";
    String parent = earthRelative(earth, basicEarth);
    if ("父母" == parent) {
      result = "生";
    } else if ("官鬼" == parent) {
      result = "克";
    } else if ("兄弟" == parent) {
      //拱扶:与月日建五行相同又不是值或临的爻,称为拱或扶.
      //爻在月日建前称扶,爻在月日建后称拱.如亥日子爻,称日扶;子日亥爻,则称日拱.
      //拱扶可以看作是生的一种,但要比生的力量还要大.
      if (isEarthForward(earth, basicEarth)) {
        result = "拱";
      } else if (isEarthForward(earth, basicEarth)) {
        result = "扶";
      }
      //else cont.
    } else if ("妻财" == parent) {
      result = "耗";
    } else if ("子孙" == parent) {
      result = "泻";
    }
    //else cont.

    return result;
  }

  bool isEarthForward(String fromEarth, String toEarth) {
    String strItem = fromEarth + toEarth;
    List jinArray = ["亥子", "寅卯", "巳午", "申酉", "丑辰", "辰未", "未戌"];
    return -1 != jinArray.indexOf(strItem);
  }

  bool isEarthBack(String fromEarth, String toEarth) {
    String strItem = fromEarth + toEarth;
    List tuiArray = ["子亥", "卯寅", "午巳", "酉申", "辰丑", "未辰", "戌未"];

    return -1 != tuiArray.indexOf(strItem);
  }

  bool isEarthBorn(String earth, String basicEarth) {
    String parent = earthRelative(earth, basicEarth);
    return "父母" == parent;
  }

  bool isEarthRestricts(String earth, String basicEarth) {
    String parent = earthRelative(earth, basicEarth);
    return "官鬼" == parent;
  }

  String earthElement(String earth) {
    return _branchModel.earthElement()[earth];
  }

  String seasonDescription(String monthEarth, String _earthName) {
    return _branchModel.getSeasonStrong()[_earthName][monthEarth];
  }

  bool isEarthPairDay(String basicEarth, String dayEarth) {
    bool bResult = false;

    String strPair = earthSixPair(basicEarth);

    bResult = strPair == dayEarth;

    return bResult;
  }

  List earthThreePairInArray(List arrayEarth) {
    List arrayResult = [];

    if (-1 != arrayEarth.indexOf("子")) {
      if (-1 != arrayEarth.indexOf("申") && -1 != arrayEarth.indexOf("辰")) {
        arrayResult.add("申子辰合成水局");
      }
      //else cont.
    }

    if (-1 != arrayEarth.indexOf("酉")) {
      if (-1 != arrayEarth.indexOf("巳") && -1 != arrayEarth.indexOf("丑")) {
        arrayResult.add("巳酉丑合成金局");
      }
      //else cont.
    }

    if (-1 != arrayEarth.indexOf("午")) {
      if (-1 != arrayEarth.indexOf("寅") && -1 != arrayEarth.indexOf("戌")) {
        arrayResult.add("寅午戌合成火局");
      }
      //else cont.
    }

    if (-1 != arrayEarth.indexOf("卯")) {
      if (-1 != arrayEarth.indexOf("亥") && -1 != arrayEarth.indexOf("未")) {
        arrayResult.add("亥卯未合成木局");
      }
      //else cont.
    }
    //else cont.

    return arrayResult;
  }
}
