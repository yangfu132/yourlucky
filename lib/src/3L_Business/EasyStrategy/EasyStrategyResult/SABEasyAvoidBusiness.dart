import 'package:yourlucky/src/1L_Context/SACGlobal.dart';
import 'package:yourlucky/src/3L_Business/EasyDetail/SABEasyDetailModel.dart';
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
        enemyState: '',
        relationAboutEnemy: '',
        relationAboutParentOrSon: '');
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

  String enemyDescription() {
    String stringResult = "";
    String lifeParent = inputDetail.wordsModel().getLifeParent();
    if ('官鬼' == lifeParent) {
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
    } else {
      List avoidRowArray =
          inputDetail.wordsModel().arrayRowWithParent('官鬼', EasyTypeEnum.from);

      if (avoidRowArray.length != 0) {
        for (int intRow in avoidRowArray) {
          String description =
              enemyDescriptionOfSymbol(intRow, EasyTypeEnum.from);
          if ('' != stringResult) {
            SASStringService.appendToString(stringResult, description);
          } else {
            stringResult = description;
          }
        } //end for
      } else {
        avoidRowArray = inputDetail
            .wordsModel()
            .arrayRowWithParent('官鬼', EasyTypeEnum.hide);
        stringResult = "克害没有上挂，以下为伏神信息：";
        for (int intRow in avoidRowArray) {
          String description =
              enemyDescriptionOfSymbol(intRow, EasyTypeEnum.hide);
          SASStringService.appendToString(stringResult, description);
        } //end for
      }
    } //end if
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


  String sonState()
  {
    String stringResult = '';
    EasyTypeEnum easyType = EasyTypeEnum.from;
    List usefulArray = wordsModel().arrayRowWithParent('子孙', easyType);


  if ( usefulArray.length == 0 )
  {
    easyType = EasyTypeEnum.hide;
    usefulArray = wordsModel().arrayRowWithParent('子孙', easyType);
    stringResult = "子孙没有上挂，以下为伏神信息：";
  }
  //else cont.

    if ( usefulArray.length > 0 )
  {
    bool aaa = false;
    for (int intRow in usefulArray) {
      String symbol = wordsModel().getSymbolName(intRow, easyType);
      if ('' != stringResult) {
        SASStringService.appendToString(stringResult, symbol);
      } else {
        stringResult = symbol;
      }
  }//end for

  NSMutableArray* movementArray = [easyData movementArrayInArray:usefulArray];
  if ( [movementArray count] > 0 )
  {
  strResult = [TLStringService appendToString:strResult byContent:@"福神动于卦中。古法曰：但得子孙乘旺动，飞殃横祸化为尘。"];
  }
  else
  {
  strResult = [strResult stringByAppendingString:@"； 福神安静。"];
  strResult = [TLStringService appendToString:strResult byContent:@"福神安静。"];
  }
  }
  else
  CO_LOG(@"error!");

  return stringResult;
}

  SABEasyWordsModel wordsModel() {
    return inputDetail.wordsModel();
  }
}
