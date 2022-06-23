import 'package:yourlucky/src/A_Context/SACGlobal.dart';
import 'package:yourlucky/src/C_ViewModel/EasyAnalysis/SABEasyAnalysisModel.dart';
import 'package:yourlucky/src/D_Business/Base/SABBaseBusiness.dart';
import 'package:yourlucky/src/D_Business/DigitModel/SABDigitDiagramsModel.dart';
import 'package:yourlucky/src/D_Business/DigitModel/SABEasyDigitModel.dart';
import 'package:yourlucky/src/D_Business/EarthBranch/SABEarthBranchBusiness.dart';
import 'package:yourlucky/src/D_Business/EasyLogic/BaseLogic/SABEasyLogicModel.dart';
import 'package:yourlucky/src/D_Business/EasyLogic/Health/SABHealthModel.dart';
import 'package:yourlucky/src/D_Business/EasyLogic/SABEasyHealthLogicModel.dart';
import 'package:yourlucky/src/D_Business/EasyWords/SABEasyWordsModel.dart';
import 'package:yourlucky/src/D_Business/Strategy/SABParentInfoModel.dart';

import '../../A_Context/SACContext.dart';
import '../../E_Service/SASStringService.dart';
import 'SABDiagramsDetailModel.dart';

class SABDiagramsDetailBusiness extends SABBaseBusiness {
  SABDiagramsDetailBusiness(this._inputLogicDesModel);
  final SABEasyAnalysisModel _inputLogicDesModel;

  late final SABEarthBranchBusiness _branchBusiness = SABEarthBranchBusiness();

  void configResultModel(SABDiagramsDetailModel outputResultModel) {
    SABHealthModel theHealthModel = healthModel();
    List resultList = outputResultModel.resultList;
    if (theHealthModel.diagramsModel.bValidEasy()) {
      resultList[0]['value'] = digitModel().strEasyGoal;
      resultList[1]['value'] = this.resultUsefulDeity();
      resultList[2]['value'] = this.resultEasy();
      resultList[3]['value'] = this.resultRepeatedOrConflict();
      resultList[4]['value'] = this.resultSixPairOrConflict();
      resultList[5]['value'] = this.resultThreePair();
      resultList[6]['value'] = this.resultSymbol(theHealthModel);
      resultList[7]['value'] = this.resultHappenTime();
    } else {
      coLog(StackTrace.current,LogTypeEnum.error, '无效的数据');
    }
  }

  ///`用神`//////////////////////////////////////////////////////
  String resultUsefulDeity() {
    return "${digitModel().strUsefulDeity}，类像参见用神爻。";
  }

  ///`卦体`//////////////////////////////////////////////////////
  String resultEasy() {
    String strResult = "";
    String fromName = wordsModel().getFromEasyName();

    String toName = wordsModel().getToEasyName();

    //卦变生克
    String easyParent = resultEasyParent();

    strResult = "$fromName 之 $toName";

    if ("" != easyParent) {
      strResult = strResult + "\r\n" + easyParent;
    }
    //else cont.

    return strResult;
  }

  String resultEasyParent() {
    String result = "";

    //因为增删卜易中只出现六纯卦，所以也要求是六纯卦；

    if (getDiagramsModel().bFromPureEasy && getDiagramsModel().bToPureEasy) {
      //本卦与变卦之间的生克关系
      String strParent = logicModel().diagramsModel.stringEasyParent;

      if ('父母' == strParent) {
        //卦变回头生，以吉论
        result = result + '，卦变回头生，以吉论；事物的发展对你有利。';
      } else if ('官鬼' == strParent) {
        //卦变回头克，以凶论
        result = result + '，卦变回头克，以凶论；事物的发展对你不利。';
      }
      //else cont.
    }
    //else cont.

    return result;
  }

  ///`反伏`//////////////////////////////////////////////////////

  ///反伏或者回头冲
  String resultRepeatedOrConflict() {
    String result = "";

    //卦反伏
    String easyRI = resultEasyRepeatedOrRestricts();

    //显示结果
    if ('' != easyRI) {
      result = result + easyRI;
    } else {
      result = result + "非反吟卦，非伏吟卦";
    }
    return result;
  }

  String resultEasyRepeatedOrRestricts() {
    String result = "";

    String strAgainst =
        '''主成而败，败而成，有而即无，无而即有，得而失，失而得，来而去，去而来，聚而散，散而聚，动而思静，静而思动。\r\n \
    占功名者，用神旺相迁而又迁，升往他乡仍复来。用神失陷，有或降或升或得或失。\r\n\
    占财物，聚散不常，卖买经营兴废往来不定。\r\n\
    占坟茔，宅舍欲迁不迁，或迁之而再迁，或目下就有迁移之事。\r\n\
    占已经久远之事者，目前就有变动。\r\n\
    占天时晴而即雨，雨而又晴。\r\n\
    占婚姻反复难成。\r\n\
    占疾病愈而又病。\r\n\
    占盗贼官非见而又见。\r\n\
    占出行则行至中途亦反，即使到彼一事无成。\r\n\
    占行人外卦反伏者，用神旺相必归，不然亦移他处。在外之人而占家宅者，内卦反伏，家庭人口不安。\r\n\
    占彼此之形势者，内卦反伏，我乱他定，外卦反伏他乱我定。\r\n\
    反吟有冲有克，用神受克得祸不轻。以生用神旺相不变冲克者虽则反伏，事之必成。第恐用神而化回头之冲克者，即是卦变大凶之象。''';

    String repeatedResult =
        '''内外伏吟者，内外忧虑呻吟之象。亦有内卦动变伏吟内则呻吟，外卦动变伏吟外则不宁，诸占皆不如意，动如不动，焦恼呻吟。\r\n\
    占名者久困官途淹留仕路。\r\n\
    占利者财源耗散，水利消之。\r\n\
    占坟宅舍欲迁而不能，守之而不利。\r\n\
    占婚姻忧而不乐。\r\n\
    占疾病久疾呻吟。\r\n\
    占口舌官非事之难结。\r\n\
    占出行难于移动，\r\n\
    占行人在外忧郁。\r\n\
    占彼此之形势者，内卦为我，外卦为他。内伏吟我心不遂，外伏吟他意不安。''';

    if (logicModel().diagramsModel.isEasyRepeatedGroan) {
      String repeated = "卦伏吟：内外伏吟者，内外不安之象也。";
      result = result + "\r\n    $repeated\r\n    $repeatedResult ";
      result = result + "    应期：${repeatedEasyResult()}\r\n";
    } else if (logicModel().diagramsModel.isEasyInPartRepeated) {
      String repeated = "卦伏吟：内卦伏吟内则不安。";
      result = result + "\r\n    $repeated\r\n    $repeatedResult ";
      result = result + "    应期：${repeatedEasyResult()}\r\n";
    } else if (logicModel().diagramsModel.isEasyOutPartRepeated) {
      String repeated = "卦伏吟：外卦伏吟外不宁。";
      result = result + "\r\n    $repeated\r\n    $repeatedResult ";
      result = result + "    应期：${repeatedEasyResult()}\r\n";
    } else if (logicModel().diagramsModel.isEasyRestrictsGroan) {
      String repeated = "卦反吟：内外反吟者，内外不安之象也。";
      result = result + "\r\n    $repeated\r\n    $strAgainst ";
      result = result + "    应期：${restrictsEasyResult()}\r\n";
    } else if (logicModel().diagramsModel.isEasyInPartRestricts) {
      String repeated = "卦反吟：内卦反吟内则不安。";
      result = result + "\r\n    $repeated\r\n    $strAgainst ";
      result = result + "    应期：${restrictsEasyResult()}\r\n";
    } else if (logicModel().diagramsModel.isEasyOutPartRestricts) {
      String repeated = "卦反吟：外卦反吟外不宁。";
      result = result + "\r\n    $repeated\r\n    $strAgainst ";
      result = result + "    应期：${restrictsEasyResult()}\r\n";
    }
    //else cont.

    return result;
  }

  ///`六合卦或者六冲卦`//////////////////////////////////////////////////////
  String resultSixPairOrConflict() {
/*
     日月合爻者，一也;
     爻与爻合者，二也;
     爻动化合者，三也;
     卦逢六合，四也;
     六冲变六合，五也；
     六合卦变六合，六也。
     */

    String strResult = "";

    bool bFromSixPair = logicModel().isEasySixPair(EasyTypeEnum.from);

    bool bToSixPair = false;

    if (!logicModel().diagramsModel.bStaticEasy)
      bToSixPair = logicModel().isEasySixPair(EasyTypeEnum.to);
    //else cont. 是静卦

    bool bFromConflict = logicModel().isEasySixConflict(EasyTypeEnum.from);

    bool bToConflict = false;
    if (!logicModel().diagramsModel.bStaticEasy)
      bToConflict = logicModel().isEasySixConflict(EasyTypeEnum.to);
    //else cont. 是静卦

    if (bFromSixPair && !bToConflict && !bToSixPair) {
      //卦逢六合，四也;
      strResult = SASStringService.appendToString(strResult, "卦逢六合");
      strResult = SASStringService.appendToString(strResult,
          "    凡得诸合，诸占皆以为吉。占名名成，占利利就，占婚必成，占身发迹，占宅兴旺，占风水聚气藏风，占求谋遂心合意。\r\n    然必用神有气相宜，用若失陷无益。但是六冲卦变六合者，不看用神，竟以吉断。\r\n    卜书曰：万事若得三六合，诸事必得久远，有始有终。但宜吉事逢之，事之必就，不宜凶事逢之，事之难结。");
    } else if (bFromSixPair && bToSixPair) {
      //六合卦变六合，六也。
      strResult = SASStringService.appendToString(strResult, "六合卦变六合");
      strResult = SASStringService.appendToString(strResult,
          "爻逢六合已为吉兆，动而又变六合，谓始终而作合也。占风土百代簪缨，占宅舍千秋基业，占婚姻白头相守，占伙计管鲍雷陈，占功名仕路亨通，占财帛聚相如山。占兄弟累世同居。宜合吉不宜合凶。诸占用神临日月者，吉之而又吉也。\r\n    唯占讼狱不利，冤仇难解。及占忧疑怪事终不闻心。占孕胎安，占产难生。再若用神受克更为凶兆。");
    } else if (bFromConflict && bToSixPair) {
      //六冲变六合，五也；
      strResult = SASStringService.appendToString(strResult, "六冲变六合");
      strResult = SASStringService.appendToString(strResult,
          "诸合皆以用神旺者为吉，独此六冲卦变六合者，不看用神，竟以吉断。占婚姻先吴越而后朱陈。占夫妻先参商后必合好。占功名始则艰难，终须荣显。占身命先困后宁。占风水巧处奇逢。占家宅先颓后盛。\r\n");
    }

    /*
     日月冲爻者，一也。
     卦逢六冲，二也。
     六合卦变六冲，三也。
     六冲变六冲，四也。
     动爻变冲，五也。
     爻与爻冲，六也。
     */
    else if (bFromConflict && !bToConflict && !bToSixPair) {
      //卦逢六冲，二也。
      strResult = SASStringService.appendToString(strResult, "卦逢六冲");
      strResult = SASStringService.appendToString(
          strResult, "冲者，散也。凡占凶事宜于冲散，占吉事而不宜。亦必兼看用神而言，用神旺，虽冲不碍，用神失陷，凶而又凶。");
    } else if (bFromSixPair && bToConflict) {
      //六合卦变六冲，三也。
      strResult = SASStringService.appendToString(strResult, "六合卦变六冲");
      strResult = SASStringService.appendToString(strResult,
          "冲者，散也。凡占凶事宜于冲散，占吉事而不宜。\r\n    亦必兼看用神而言，用神旺，虽冲不碍，用神失陷，凶而又凶。\r\n    六合卦变六冲者，用神若旺，始吉终凶，图事虽成，有始而无终也。\r\n    凡得六合变六冲者，诸占先合后离，先亲后疏，先浓后淡，始荣终悴，初好后迟，先亨后否，得而复失，成而后败，事就而又变也。唯占官非盗贼结绝事者宜之。");
    } else if (bFromConflict && bToConflict) {
      //六冲变六冲，四也。
      strResult = SASStringService.appendToString(strResult, "六冲变六冲");
      strResult = SASStringService.appendToString(
          strResult, "冲者，散也。凡占凶事宜于冲散，占吉事而不宜。亦必兼看用神而言，用神旺，虽冲不碍，用神失陷，凶而又凶。");
    }
    //else cont.

    return strResult;
  }

  ///`三合`//////////////////////////////////////////////////////
  String resultThreePair() {
    return '';
  }

  ///`基于世爻与用神的判定结果`//////////////////////////////////////////////////////
  String resultSymbol(SABHealthModel theHealthModel) {
    String strResult = '卦体为主，世用为辅，如果是平常卦就以世用为主。';
    if (theHealthModel.diagramsModel.bValidEasy()) {
      strResult =
          SASStringService.appendToString(strResult, subresultSymbolStandard());
    } else
      strResult = SASStringService.appendToString(strResult, '六爻乱动，必须重新占卜！');
    return strResult;
  }

  ///`应期`//////////////////////////////////////////////////////
  String resultHappenTime() {
    String strResult = "";
    strResult = SASStringService.appendToString(strResult, timeResult());
    return strResult;
  }

  String monthBrokenResult() {
    String result = "";

    //既动则有祸福之基。目下虽破，出月则不破，今日虽破，实破之日则不破，逢合之日则不破。近应日时，远应年月。

    //今日虽破，实破之日则不破
    final usefulDeity = healthLogicModel().usefulDeity;

    String usefulEarth = "";

    if (EasyTypeEnum.from == usefulDeity.easyType ||
        EasyTypeEnum.hide == usefulDeity.easyType) {
      usefulEarth =
          logicModel().getSymbolEarth(usefulDeity.intRow, usefulDeity.easyType);
      String onResult = "用神月破：实破之 $usefulEarth (日、月、年)则不破";
      result = SASStringService.appendToString(result, onResult);

      String strEarthPair = _branchBusiness.earthSixPair(usefulEarth);
      String strEarthPairResult = "用神月破：应期为逢合之 $strEarthPair (日、月、年)则不破";

      result = SASStringService.appendToString(result, strEarthPairResult);

      result = SASStringService.appendToString(result, "用神月破：目下虽破，出月则不破");
    }
    if (EasyTypeEnum.type_null == usefulDeity.easyType) {
    } else {
      coLog(StackTrace.current,LogTypeEnum.error,"EasyType do not has usefulDeity.");
    }

    return result;
  }

  String timeResult() {
    String strResult = "";

    final usefulDeity = healthLogicModel().usefulDeity;

    EmptyEnum emptyState = EmptyEnum.Empty_Null;
    String strUseful = "";
    if (EasyTypeEnum.from == usefulDeity.easyType ||
        EasyTypeEnum.hide == usefulDeity.easyType) {
      strUseful = _inputLogicDesModel.getEmptyDescription(
          usefulDeity.intRow, usefulDeity.easyType);
      emptyState = logicModel()
          .getBasicEmptyState(usefulDeity.intRow, usefulDeity.easyType);
    } else if (EasyTypeEnum.type_null == usefulDeity.easyType) {
      if (ROW_MONTH == usefulDeity.intRow) {
        strUseful = "月为用神";
      } else if (ROW_DAY == usefulDeity.intRow) {
        strUseful = "日为用神";
      }
    } else {
      coLog(StackTrace.current,LogTypeEnum.error,"EasyType do not has usefulDeity.");
    } //end {}

    if (EmptyEnum.Empty_NoUseful == emptyState) {
      //用神没有出现
      strUseful = strUseful + "卦中用神未现";
      strResult = SASStringService.appendToString(strResult, strUseful);
    } else if (EmptyEnum.Empty_Conflict == emptyState) {
      //用神冲空 出空
      strUseful = strUseful + "现在有效";
      strResult = SASStringService.appendToString(strResult, strUseful);
    } else if (EmptyEnum.Empty_NO != emptyState) {
      //用神旬空
      strUseful = strUseful + outEmptyDate();
      strResult = SASStringService.appendToString(strResult, strUseful);
    }
    if (EasyTypeEnum.from == usefulDeity.easyType) {
      if (healthLogicModel().getIsSymbolChangeEmpty(usefulDeity.intRow)!) {
        //化空
        String str = "变爻";
        str = str + outEmptyDate();
        strResult = SASStringService.appendToString(strResult, str);
      }
      //else cont.
    } else {}

    //月破
    if (EasyTypeEnum.from == usefulDeity.easyType) {
      MonthConflictEnum monthBrokenState = healthLogicModel()
          .getConflictOnMonthState(usefulDeity.intRow, usefulDeity.easyType);

      if (MonthConflictEnum.Conflict_OnDay == monthBrokenState ||
          MonthConflictEnum.Conflict_Move == monthBrokenState ||
          MonthConflictEnum.Conflict_DayBorn == monthBrokenState) {
        strResult =
            SASStringService.appendToString(strResult, monthBrokenResult());
      }
      //else cont.
    }
    return strResult;
  }

  String subresultSymbolStandard() {
    //General principles 普通原则：世用两旺

    String strResult = "";
    //生克
    double lifeHealth = healthLogicModel().lifeHealthWithCritical;

    double usefulHealth = healthLogicModel().usefulHealthWithCritical;

    if (lifeHealth > 0 && usefulHealth > 0) {
      strResult =
          "世爻(${lifeHealth.toStringAsFixed(4)})、用神(${usefulHealth.toStringAsFixed(4)})两旺，事情可成";
    } else if (lifeHealth > 0 && usefulHealth <= 0) {
      strResult =
          "世爻旺(${lifeHealth.toStringAsFixed(4)})，用神衰(${usefulHealth.toStringAsFixed(4)})，用神失陷，事情难成";
    } else if (lifeHealth == 0 && usefulHealth > 0) {
      strResult =
          "世爻平(${lifeHealth.toStringAsFixed(4)})，用神旺(${usefulHealth.toStringAsFixed(4)})，世爻未知";
    } else if (lifeHealth == 0 && usefulHealth == 0) {
      strResult =
          "世爻平(${lifeHealth.toStringAsFixed(4)})，用神平(${usefulHealth.toStringAsFixed(4)})，世爻用神皆未知";
    } else if (lifeHealth == 0 && usefulHealth < 0) {
      strResult =
          "世爻平(${lifeHealth.toStringAsFixed(4)})，用神衰(${usefulHealth.toStringAsFixed(4)})，用神失陷，事情难成。";
    } else if (lifeHealth < 0 && usefulHealth >= 0) {
      strResult =
          "世爻衰(${lifeHealth.toStringAsFixed(4)})，用神旺(${usefulHealth.toStringAsFixed(4)})，世爻失陷，恐有不测。";
    } else if (lifeHealth < 0 && usefulHealth < 0) {
      strResult =
          "世爻(${lifeHealth.toStringAsFixed(4)})、用神(${usefulHealth.toStringAsFixed(4)})两衰，世爻失陷，十分不利";
    } else
      coLog(StackTrace.current,LogTypeEnum.error, "error!");

    return strResult;
  }

  ///`动静生克章第十四`//////////////////////////////////////////////////////

  ///`动静生克冲合章第十五`//////////////////////////////////////////////////////

  ///`月将章第十六`//////////////////////////////////////////////////////

  ///`日辰章第十七`//////////////////////////////////////////////////////

  ///`六合章第十九`//////////////////////////////////////////////////////

  String easySixPairResult() {
    /*
     日月合爻者，一也;
     爻与爻合者，二也;
     爻动化合者，三也;
     卦逢六合，四也;
     六冲变六合，五也；
     六合卦变六合，六也。
     */

    String strResult = "";

    bool bFromSixPair = logicModel().isEasySixPair(EasyTypeEnum.from);

    bool bToSixPair = false;
    if (!logicModel().diagramsModel.bStaticEasy)
      bToSixPair = logicModel().isEasySixPair(EasyTypeEnum.to);
    //else cont. 是静卦

    bool bFromConflict = logicModel().isEasySixConflict(EasyTypeEnum.from);

    bool bToConflict = false;
    if (!logicModel().diagramsModel.bStaticEasy)
      bToConflict = logicModel().isEasySixConflict(EasyTypeEnum.to);
    //else cont. 是静卦

    if (bFromSixPair && !bToConflict && !bToSixPair) {
      //卦逢六合，四也;
      strResult = SASStringService.appendToString(strResult, "卦逢六合");
      strResult = SASStringService.appendToString(strResult,
          "    凡得诸合，诸占皆以为吉。占名名成，占利利就，占婚必成，占身发迹，占宅兴旺，占风水聚气藏风，占求谋遂心合意。\r\n    然必用神有气相宜，用若失陷无益。但是六冲卦变六合者，不看用神，竟以吉断。\r\n    卜书曰：万事若得三六合，诸事必得久远，有始有终。但宜吉事逢之，事之必就，不宜凶事逢之，事之难结。");
    } else if (bFromSixPair && bToSixPair) {
      //六合卦变六合，六也。
      strResult = SASStringService.appendToString(strResult, "六合卦变六合");
      strResult = SASStringService.appendToString(strResult,
          "爻逢六合已为吉兆，动而又变六合，谓始终而作合也。占风土百代簪缨，占宅舍千秋基业，占婚姻白头相守，占伙计管鲍雷陈，占功名仕路亨通，占财帛聚相如山。占兄弟累世同居。宜合吉不宜合凶。诸占用神临日月者，吉之而又吉也。\r\n    唯占讼狱不利，冤仇难解。及占忧疑怪事终不闻心。占孕胎安，占产难生。再若用神受克更为凶兆。");
    } else if (bFromConflict && bToSixPair) {
      //六冲变六合，五也；
      strResult = SASStringService.appendToString(strResult, "六冲变六合");
      strResult = SASStringService.appendToString(strResult,
          "诸合皆以用神旺者为吉，独此六冲卦变六合者，不看用神，竟以吉断。占婚姻先吴越而后朱陈。占夫妻先参商后必合好。占功名始则艰难，终须荣显。占身命先困后宁。占风水巧处奇逢。占家宅先颓后盛。\r\n");
    }

    return strResult;
  }

  String easySixAgainstResult() {
/*
     日月合爻者，一也;
     爻与爻合者，二也;
     爻动化合者，三也;
     卦逢六合，四也;
     六冲变六合，五也；
     六合卦变六合，六也。
     */

    String strResult = "";

    bool bFromSixPair = logicModel().isEasySixPair(EasyTypeEnum.from);

    bool bToSixPair = false;
    if (!logicModel().diagramsModel.bStaticEasy)
      bToSixPair = logicModel().isEasySixPair(EasyTypeEnum.to);
    //else cont. 是静卦

    bool bFromConflict = logicModel().isEasySixConflict(EasyTypeEnum.from);

    bool bToConflict = false;
    if (!logicModel().diagramsModel.bStaticEasy)
      bToConflict = logicModel().isEasySixConflict(EasyTypeEnum.to);
    //else cont. 是静卦

    if (bFromConflict && !bToConflict && !bToSixPair) {
      //卦逢六冲，二也。
      strResult = SASStringService.appendToString(strResult, "卦逢六冲");
      strResult = SASStringService.appendToString(
          strResult, "冲者，散也。凡占凶事宜于冲散，占吉事而不宜。亦必兼看用神而言，用神旺，虽冲不碍，用神失陷，凶而又凶。");
    } else if (bFromSixPair && bToConflict) {
      //六合卦变六冲，三也。
      strResult = SASStringService.appendToString(strResult, "六合卦变六冲");
      strResult = SASStringService.appendToString(strResult,
          "冲者，散也。凡占凶事宜于冲散，占吉事而不宜。\r\n    亦必兼看用神而言，用神旺，虽冲不碍，用神失陷，凶而又凶。\r\n    六合卦变六冲者，用神若旺，始吉终凶，图事虽成，有始而无终也。\r\n    凡得六合变六冲者，诸占先合后离，先亲后疏，先浓后淡，始荣终悴，初好后迟，先亨后否，得而复失，成而后败，事就而又变也。唯占官非盗贼结绝事者宜之。");
    } else if (bFromConflict && bToConflict) {
      //六冲变六冲，四也。
      strResult = SASStringService.appendToString(strResult, "六冲变六冲");
      strResult = SASStringService.appendToString(
          strResult, "冲者，散也。凡占凶事宜于冲散，占吉事而不宜。亦必兼看用神而言，用神旺，虽冲不碍，用神失陷，凶而又凶。");
    }
    //else cont.

    return strResult;
  }

  String resultSixPairOrConflictTitle() {
/*
     日月合爻者，一也;
     爻与爻合者，二也;
     爻动化合者，三也;
     卦逢六合，四也;
     六冲变六合，五也；
     六合卦变六合，六也。
     */

    String strResult = "";

    bool bFromSixPair = logicModel().isEasySixPair(EasyTypeEnum.from);

    bool bToSixPair = false;
    if (!logicModel().diagramsModel.bStaticEasy)
      bToSixPair = logicModel().isEasySixPair(EasyTypeEnum.to);
    //else cont. 是静卦

    bool bFromConflict = logicModel().isEasySixConflict(EasyTypeEnum.from);

    bool bToConflict = false;
    if (!logicModel().diagramsModel.bStaticEasy)
      bToConflict = logicModel().isEasySixConflict(EasyTypeEnum.to);
    //else cont. 是静卦

    if (bFromSixPair && !bToConflict && !bToSixPair) {
      //卦逢六合，四也;
      strResult = SASStringService.appendToString(strResult, "卦逢六合");
    } else if (bFromSixPair && bToSixPair) {
      //六合卦变六合，六也。
      strResult = SASStringService.appendToString(strResult, "六合卦变六合");
    } else if (bFromConflict && bToSixPair) {
      //六冲变六合，五也；
      strResult = SASStringService.appendToString(strResult, "六冲变六合");
    }

    /*
     日月冲爻者，一也。
     卦逢六冲，二也。
     六合卦变六冲，三也。
     六冲变六冲，四也。
     动爻变冲，五也。
     爻与爻冲，六也。
     */
    else if (bFromConflict && !bToConflict && !bToSixPair) {
      //卦逢六冲，二也。
      strResult = SASStringService.appendToString(strResult, "卦逢六冲");
    } else if (bFromSixPair && bToConflict) {
      //六合卦变六冲，三也。
      strResult = SASStringService.appendToString(strResult, "六合卦变六冲");
    } else if (bFromConflict && bToConflict) {
      //六冲变六冲，四也。
      strResult = SASStringService.appendToString(strResult, "六冲变六冲");
    }
    //else cont.

    return strResult;
  }

  ///`反伏章第二十五`//////////////////////////////////////////////////////

  String resultEasyRepeated() {
    String result = "";

    String repeatedResult =
        '''内外伏吟者，内外忧虑呻吟之象。亦有内卦动变伏吟内则呻吟，外卦动变伏吟外则不宁，诸占皆不如意，动如不动，焦恼呻吟。\r\n
    占名者久困官途淹留仕路。\r\n
    占利者财源耗散，水利消之。\r\n
    占坟宅舍欲迁而不能，守之而不利。\r\n
    占婚姻忧而不乐。\r\n
    占疾病久疾呻吟。\r\n
    占口舌官非事之难结。\r\n
    占出行难于移动，\r\n
    占行人在外忧郁。\r\n
    占彼此之形势者，内卦为我，外卦为他。内伏吟我心不遂，外伏吟他意不安。''';

    if (logicModel().diagramsModel.isEasyRepeatedGroan) {
      String repeated = "卦伏吟：内外伏吟者，内外不安之象也。";
      result = "\r\n    $repeated\r\n    $repeatedResult ";
      result = result + "    应期：${repeatedEasyResult()}r\n";
    } else if (logicModel().diagramsModel.isEasyInPartRepeated) {
      String repeated = "卦伏吟：内卦伏吟内则不安。";
      result = "\r\n    $repeated\r\n    $repeatedResult ";
      result = result + "    应期：${repeatedEasyResult()}r\n";
    } else if (logicModel().diagramsModel.isEasyOutPartRepeated) {
      String repeated = "卦伏吟：外卦伏吟外不宁。";
      result = "\r\n    $repeated\r\n    $repeatedResult ";
      result = result + "    应期：${repeatedEasyResult()}r\n";
    }
    //else cont.

    return result;
  }

  String resultEasyConflict() {
    String result = "";

    String strAgainst =
        '''主成而败，败而成，有而即无，无而即有，得而失，失而得，来而去，去而来，聚而散，散而聚，动而思静，静而思动。\r\n 
    占功名者，用神旺相迁而又迁，升往他乡仍复来。用神失陷，有或降或升或得或失。\r\n
    占财物，聚散不常，卖买经营兴废往来不定。\r\n
    占坟茔，宅舍欲迁不迁，或迁之而再迁，或目下就有迁移之事。\r\n
    占已经久远之事者，目前就有变动。\r\n
    占天时晴而即雨，雨而又晴。\r\n
    占婚姻反复难成。\r\n
    占疾病愈而又病。\r\n\
    占盗贼官非见而又见。\r\n
    占出行则行至中途亦反，即使到彼一事无成。\r\n
    占行人外卦反伏者，用神旺相必归，不然亦移他处。在外之人而占家宅者，内卦反伏，家庭人口不安。\r\n
    占彼此之形势者，内卦反伏，我乱他定，外卦反伏他乱我定。\r\n
    反吟有冲有克，用神受克得祸不轻。以生用神旺相不变冲克者虽则反伏，事之必成。第恐用神而化回头之冲克者，即是卦变大凶之象。''';

    if (logicModel().diagramsModel.isEasyRestrictsGroan) {
      String repeated = "卦反吟：内外反吟者，内外不安之象也。";
      result = "\r\n    $repeated\r\n    $strAgainst ";
      result = result + "    应期：${restrictsEasyResult()}\r\n";
    } else if (logicModel().diagramsModel.isEasyInPartRestricts) {
      String repeated = "卦反吟：内卦反吟内则不安。";
      result = "\r\n    $repeated\r\n    $strAgainst ";
      result = result + "    应期：${restrictsEasyResult()}\r\n";
    } else if (logicModel().diagramsModel.isEasyOutPartRestricts) {
      String repeated = "卦反吟：外卦反吟外不宁。";
      result = "\r\n    $repeated\r\n    $strAgainst ";
      result = result + "    应期：${restrictsEasyResult()}\r\n";
    }
    //else cont.

    return result;
  }

  ///伏吟之卦，用神旺相冲开之年月其志则神，用神休囚，冲开之年月忧郁而已。
  String repeatedEasyResult() {
    String result = "";
    SABParentInfoModel usefulDeity = healthLogicModel().usefulDeity;
    if (EasyTypeEnum.from == usefulDeity.easyType) {
      if (logicModel().isMovementAtRow(usefulDeity.intRow)) {
        if (healthLogicModel().isUsefulDeityStrong) {
          String fromEarth = wordsModel()
              .getSymbolEarth(usefulDeity.intRow, usefulDeity.easyType);
          String timeEarth = _branchBusiness.getSixConflict(fromEarth);

          result =
              result + "伏吟之卦，用神旺相冲开之年月其志则神，预计 $timeEarth 年或者 $timeEarth 月冲开。";
        } else if (healthLogicModel().isUsefulDeityChangeToRestricts ||
            healthLogicModel().isUsefulDeityChangeToConflict) {
          String fromEarth = wordsModel()
              .getSymbolEarth(usefulDeity.intRow, usefulDeity.easyType);
          String timeEarth = _branchBusiness.getSixConflict(fromEarth);
          result = result + "用神休囚，冲开之年月忧郁而已,预计 $timeEarth 年或者 $timeEarth 月冲开。";
        }
        //else cont.
      }
    } else {
      result = "------应期需要进一步研究--------";
    }

    return result;
  }

  String restrictsEasyResult() {
    String result = "";

    if (healthLogicModel().isUsefulDeityStrong &&
        !healthLogicModel().isUsefulDeityChangeToRestricts &&
        !healthLogicModel().isUsefulDeityChangeToConflict) {
      result = "用神旺相不变冲克者虽则反吟，事之必成。";
    } else if (healthLogicModel().isUsefulDeityChangeToRestricts ||
        healthLogicModel().isUsefulDeityChangeToConflict) {
      result = "用神化回头冲克，卦变大凶之象。";
    }

    return result;
  }

  ///`旬空章第二十六`//////////////////////////////////////////////////////

  String outEmptyDate() {
    String strResult = "";
    String strDayTrunk = logicModel().inputWordsModel.dayModel.stringSky;
    String strSkyTrunk = SABEasyLogicModel.skyTrunkString();
    int rangeTrunk = strSkyTrunk.indexOf(strDayTrunk);

    String emptyEarth = logicModel().diagramsModel.stringEmptyBranch;
    if (emptyEarth.isNotEmpty) {
      int length = strSkyTrunk.length - rangeTrunk;
      String subString = emptyEarth.substring(0, 1);
      strResult = "旬空：$length 日后甲$subString 日出空";
    } else
      coLog(StackTrace.current,LogTypeEnum.error, "error!");
    return strResult;
  }

  ///`加载函数`//////////////////////////////////////////////////////

  SABEasyDigitModel digitModel() {
    return wordsModel().inputDigitModel;
  }

  SABEasyWordsModel wordsModel() {
    return _inputLogicDesModel
        .inputHealthLogicModel.inputHealthModel.inputLogicModel.inputWordsModel;
  }

  SABEasyLogicModel logicModel() {
    return _inputLogicDesModel
        .inputHealthLogicModel.inputHealthModel.inputLogicModel;
  }

  SABHealthModel healthModel() {
    return _inputLogicDesModel.inputHealthLogicModel.inputHealthModel;
  }

  SABEasyHealthLogicModel healthLogicModel() {
    return _inputLogicDesModel.inputHealthLogicModel;
  }

  SABDigitDiagramsModel getDiagramsModel() {
    return wordsModel().inputDigitModel.diagramsModel;
  }
}
