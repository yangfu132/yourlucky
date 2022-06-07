import 'package:yourlucky/src/4L_Business/Base/SABBaseModel.dart';

class SABEasyStrategyInfoModel extends SABBaseModel {
  static const String avoid = "趋避";
  static const String department = "署印谋差";
  static const String marriage = "婚姻";
  static const String money1 = "求财";
  static const String money2 = "谒贵求财";
  static const String money3 = "为贵人奔走效力求财";
  static const String shop = "开行开店及各色铺面";
  static List categoryArray() {
    // return ["趋避", "署印谋差", "婚姻", "求财", "谒贵求财", "为贵人奔走效力求财", "开行开店及各色铺面"];
    return [
      SABEasyStrategyInfoModel.avoid,
      SABEasyStrategyInfoModel.department,
      SABEasyStrategyInfoModel.marriage,
      SABEasyStrategyInfoModel.money1,
      SABEasyStrategyInfoModel.money2,
      SABEasyStrategyInfoModel.money3,
      SABEasyStrategyInfoModel.shop,
    ];
  }
}
