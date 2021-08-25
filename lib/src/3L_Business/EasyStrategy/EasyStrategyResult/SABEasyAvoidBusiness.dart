import 'package:yourlucky/src/3L_Business/EasyDetail/SABEasyDetailModel.dart';
import 'package:yourlucky/src/3L_Business/EasyStrategy/EasyStrategyResult/SABEasyStrategyResultModel.dart';

class SABEasyAvoidBusiness {
  final SABEasyDetailModel inputDetail;
  SABEasyAvoidBusiness(this.inputDetail);
  SABEasyStrategyResultModel resultModel() {
    SABEasyStrategyResultModel modelResult = SABEasyStrategyResultModel(
        lifeDescription: lifeDescription(),
        ghostDescription: '',
        sonDescription: '',
        enemyDescription: '',
        relationAboutEnemy: '',
        relationAboutParentOrSon: '');
    return modelResult;
  }

  String lifeDescription() {
    String stringResult;
    String lifeParent = inputDetail.wordsModel().getLifeParent();
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
}
