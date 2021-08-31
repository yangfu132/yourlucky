import 'package:yourlucky/src/1L_Context/SACContext.dart';
import 'package:yourlucky/src/1L_Context/SACGlobal.dart';
import 'package:yourlucky/src/3L_Business/BasicEasy/SABElementModel.dart';
import 'package:yourlucky/src/3L_Business/EasyDetail/SABEasyDetailModel.dart';
import 'package:yourlucky/src/3L_Business/EasyLogic/Health/SABHealthModel.dart';
import 'package:yourlucky/src/3L_Business/EasyStrategy/EasyStrategyResult/SABEasyStrategyResultModel.dart';
import 'package:yourlucky/src/3L_Business/EasyWords/SABEasyWordsModel.dart';
import 'package:yourlucky/src/4L_Service/SASStringService.dart';

class SABEasyAvoidBusiness {
  final SABEasyDetailModel inputDetail;
  SABEasyAvoidBusiness(this.inputDetail);
  SABEasyStrategyResultModel resultModel() {
    SABEasyStrategyResultModel modelResult = SABEasyStrategyResultModel(
        lifeKey: lifeKey(),
        lifeDescription: lifeDescription(),
        enemyDescription: enemyDescription(),
        sonState: sonState(),
        enemyState: enemyState(),
        relationAboutEnemy: relationAboutEnemy(),
        relationAboutParentOrSon: relationAboutParentOrSon());
    return modelResult;
  }

  String lifeKey() {
    return wordsModel().getLifeName() + "  持世";
  }

  String lifeDescription() {
    String stringResult;
    String lifeParent = wordsModel().getLifeParent();
    if ('官鬼' == lifeParent) {
      stringResult = "最忌官鬼持世；";
      stringResult = inputDetail.wordsModel().getLifeName();
      String animalElement =
          ghostForElement(inputDetail.wordsModel().getLifeElement());
      stringResult =
          SASStringService.appendToString(stringResult, animalElement);

      String animalDes =
          ghostForAnimal(inputDetail.wordsModel().getLifeAnimal());
      stringResult = SASStringService.appendToString(stringResult, animalDes);

      String guaDes = ghostForGua(inputDetail.wordsModel().getLifeDiagrams());
      stringResult = SASStringService.appendToString(stringResult, guaDes);
    } else if ('' == lifeParent) {
      stringResult =
          "占趋避独宜福德随身子孙持世\r\n占梦兆、占漂洋过江、占逾险偷关、占防瘟疫、占防病、占误食毒物、占远邻火起、占防伊害、占避难、占贼盗生发、占孤身夜行、占宿店朝、占入山 、占仇人讹诈、占已定大罪、占入不毛。\r\n\大凡一切忧疑惊恐，防灾、防患者，皆宜子孙持世，或福神动于卦中。古法曰：但得子孙乘旺动，飞殃横祸化为尘。";
    } else {
      stringResult = "平平常常，没有特别明显的驱避。";
    }
    return stringResult;
  }

  String ghostForElement(String element) {
    Map ghostDictionary = {
      "火": "火鬼须防火灾。",
      "木": "木鬼须防木害。",
      "水": "水鬼克世，沉溺之忧。",
      "土": "土鬼伤身，岩墙之厄。",
      "金": "金鬼剑刀斧钺戾充盗贼兵戈。"
    };

    return ghostDictionary[element];
  }

  String ghostForAnimal(String animal) {
    Map ghostDictionary = {
      "螣蛇": "螣蛇，官非兼防火厄。",
      "朱雀": "朱雀，官非兼防火厄。",
      "白虎": "白虎，盗贼兵戈。",
      "玄武": "玄武，盗贼兵戈。",
      "勾陈": "玄武，田土又系牢狱。",
      "青龙": "青龙，或因酒色亡身，间有喜中起祸。",
    };

    return ghostDictionary[animal];
  }

  String ghostForGua(String gua) {
    //乾坎艮震巽离坤兑
    Map ghostDictionary = {
      "乾": "乾，乾兑为寺庙又属金形。",
      "兑": "兑，乾兑为寺庙又属金形；坎兑以水为灾，勿执弓弩。",
      "坎": "坎，坎兑以水为灾，勿执弓弩。",
      "离": "离，离以火灾，又为蟹鳖。",
      "震": "震，震有舟车之寇。",
      "巽": "巽，巽防妇女之奸。",
      "坤": "坤，坤艮郊野山林，又为老妇妖童之惑。",
      "艮": "艮，坤艮郊野山林，又为老妇妖童之惑。"
    };

    return ghostDictionary[gua];
  }

  List avoidGodRowArray(EasyTypeEnum easyTypeEnum) {
    String lifeElement = wordsModel().getLifeElement();
    String emptyElement = SABElementModel.elementByRelative(lifeElement, '官鬼');
    return wordsModel().arrayRowWithElement(emptyElement, easyTypeEnum);
  }

  String enemyDescription() {
    String stringResult = "";
    EasyTypeEnum easyTypeEnum = EasyTypeEnum.from;
    List avoidRowArray = avoidGodRowArray(easyTypeEnum);
    if (avoidRowArray.length == 0) {
      easyTypeEnum = EasyTypeEnum.hide;
      avoidRowArray = avoidGodRowArray(easyTypeEnum);
      stringResult = "克害没有上挂，以下为伏神信息：";
    } // else is EasyTypeEnum.from;

    for (int intRow in avoidRowArray) {
      String description = enemyDescriptionOfSymbol(intRow, easyTypeEnum);
      if ('' != stringResult) {
        stringResult =
            SASStringService.appendToString(stringResult, description);
      } else {
        stringResult = description;
      }
    } //end for

    stringResult = SASStringService.appendToString(stringResult, '诸类多门，在人通变。');
    return stringResult;
  }

  String enemyDescriptionOfSymbol(int intRow, EasyTypeEnum easyType) {
    String stringResult = '';
    stringResult = wordsModel().getSymbolName(intRow, easyType);
    String animalElement =
        ghostForElement(wordsModel().getSymbolElement(intRow, easyType));
    stringResult = SASStringService.appendToString(stringResult, animalElement);

    String animalDes = ghostForAnimal(wordsModel().getAnimal(intRow));
    stringResult = SASStringService.appendToString(stringResult, animalDes);

    String guaDes = ghostForGua(inputDetail.wordsModel().getDiagrams(intRow));
    stringResult = SASStringService.appendToString(stringResult, guaDes);
    return stringResult;
  }

  String sonState() {
    String stringResult = '';
    EasyTypeEnum easyType = EasyTypeEnum.from;
    List usefulArray = wordsModel().arrayRowWithParent('子孙', easyType);

    if (usefulArray.length == 0) {
      easyType = EasyTypeEnum.hide;
      usefulArray = wordsModel().arrayRowWithParent('子孙', easyType);
      stringResult = "子孙没有上挂，以下为伏神信息：";
    }
    //else cont.

    if (usefulArray.length > 0) {
      bool hasOutright = false;
      for (int intRow in usefulArray) {
        String symbol = wordsModel().getSymbolName(intRow, easyType);
        if ('' != stringResult) {
          stringResult = SASStringService.appendToString(stringResult, symbol);
        } else {
          stringResult = symbol;
        }
        if (!hasOutright) {
          hasOutright = OutRightEnum.RIGHT_MOVE ==
              healthModel().symbolOutRightAtRow(intRow, easyType);
          hasOutright = true;
        }
      } //end for

      if (hasOutright) {
        stringResult = SASStringService.appendToString(
            stringResult, "福神动于卦中。古法曰：但得子孙乘旺动，飞殃横祸化为尘。");
      } else {
        stringResult = SASStringService.appendToString(stringResult, "福神安静。");
      }
    } else
      colog("error");
    return stringResult;
  }

  String enemyState() {
    String stringResult = "";
    EasyTypeEnum easyType = EasyTypeEnum.from;
    List avoidRowArray = avoidGodRowArray(easyType);
    //克在内世在外，宜于外避。克神若在内卦动而克世，宜出外避之。克神若在外卦动而克世，宜在家避之。

    if (avoidRowArray.length > 0) {
      List moveArray = healthModel().moveRightInArray(avoidRowArray, easyType);
      if (moveArray.length > 0) {
        for (int intRow in moveArray) {
          if (wordsModel().inputDigitModel.isInGua(intRow)) {
            stringResult = SASStringService.appendToString(
                stringResult, "克神若在内卦动而克世，宜出外避之。");
          } else if (wordsModel().inputDigitModel.isOutGua(intRow)) {
            stringResult = SASStringService.appendToString(
                stringResult, "克神若在外卦动而克世，宜在家避之。");
          } else {
            colog('error');
          }
        } //end for
      } else {
        stringResult = SASStringService.appendToString(stringResult, "克神安静。");
      }
    } else {
      stringResult =
          SASStringService.appendToString(stringResult, "克神没有上卦，以下为伏神信息：");
      List avoidRowArray = avoidGodRowArray(easyType);
      String stringSymbol =
          wordsModel().stringFromSymbolArray(avoidRowArray, easyType);
      stringResult =
          SASStringService.appendToString(stringResult, stringSymbol);
    } //end if

    return stringResult;
  }

  String relationAboutEnemy() {
    String stringResult = "";

    //克在内世在外，宜于外避。克神若在内卦动而克世，宜出外避之。克神若在外卦动而克世，宜在家避之。
    List arrayEnemy = avoidGodRowArray(EasyTypeEnum.from);
    int lifeRow = wordsModel().intLifeIndex;

    if (arrayEnemy.length > 0) {
      if (wordsModel().inputDigitModel.isInGua(lifeRow)) {
        for (int intRow in arrayEnemy) {
          if (OutRightEnum.RIGHT_MOVE ==
              healthModel().symbolOutRightAtRow(intRow, EasyTypeEnum.from)) {
            if (wordsModel().inputDigitModel.isInGua(intRow)) {
              stringResult = SASStringService.appendToString(
                  stringResult, "世与忌神在内卦者，不可家居，宜于外避。");
            }
          }
        }
      } else if (wordsModel().inputDigitModel.isOutGua(lifeRow)) {
        for (int intRow in arrayEnemy) {
          if (OutRightEnum.RIGHT_MOVE ==
              healthModel().symbolOutRightAtRow(intRow, EasyTypeEnum.from)) {
            if (wordsModel().inputDigitModel.isOutGua(intRow)) {
              stringResult = SASStringService.appendToString(
                  stringResult, "世爻与忌神皆在外卦者，不可出行，家居可避。");
            } //else cont.
          } // else cont.
        } // end for
      } else {
        colog('error');
      }
    }
    return stringResult;
  }

  String directionAtRow(int intRow) {
    String stringResult = "";
    String earth = wordsModel().getSymbolEarth(intRow, EasyTypeEnum.from);
    if (null != earth && earth.length > 0) {
      String direction = healthModel()
          .inputLogicModel
          .earthBranchModel()
          .earthDirection()[earth];

      stringResult = SASStringService.appendToString(stringResult, direction);
    }
    return stringResult;
  }

  List bornGodRowArray(EasyTypeEnum easyTypeEnum) {
    String lifeElement = wordsModel().getLifeElement();
    String emptyElement = SABElementModel.elementByRelative(lifeElement, '父母');
    return wordsModel().arrayRowWithElement(emptyElement, easyTypeEnum);
  }

  String relationAboutParentOrSon() {
    String stringResult = "避患于生世之方:";
    List arrayBorn = bornGodRowArray(EasyTypeEnum.from);
    for (int intRow in arrayBorn) {
      stringResult =
          SASStringService.appendToString(stringResult, directionAtRow(intRow));
    }
    stringResult = SASStringService.appendToString(stringResult, " 趋吉于福神之地:");

    List usefulArray = wordsModel().arrayUsefulRow(EasyTypeEnum.from);
    for (int intRow in usefulArray) {
      stringResult =
          SASStringService.appendToString(stringResult, directionAtRow(intRow));
    }

    return stringResult;
  }

  SABEasyWordsModel wordsModel() {
    return inputDetail.wordsModel();
  }

  SABHealthModel healthModel() {
    return inputDetail.healthLogicModel().inputHealthModel;
  }
}
