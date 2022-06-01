class SABEasyStrategyModel {
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
      SABEasyStrategyModel.avoid,
      SABEasyStrategyModel.department,
      SABEasyStrategyModel.marriage,
      SABEasyStrategyModel.money1,
      SABEasyStrategyModel.money2,
      SABEasyStrategyModel.money3,
      SABEasyStrategyModel.shop,
    ];
  }
}
