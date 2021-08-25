import 'package:yourlucky/src/3L_Business/EasyDetail/SABEasyDetailModel.dart';
import 'package:yourlucky/src/3L_Business/EasyStrategy/EasyStrategy/SABEasyStrategyModel.dart';
import 'package:yourlucky/src/3L_Business/EasyStrategy/EasyStrategyResult/SABEasyAvoidBusiness.dart';
import 'package:yourlucky/src/3L_Business/StoreEasy/SABEasyDigitModel.dart';

import 'SABEasyStrategyResultModel.dart';

class SABEasyStrategyResultBusiness {
  SABEasyStrategyResultBusiness(
      {required this.inputDetail, required this.strategy});
  final String strategy;
  final SABEasyDetailModel inputDetail;
  void configResultModel(SABEasyDigitModel inputEasyModel) {}
  SABEasyStrategyResultModel resultModel() {
    SABEasyAvoidBusiness avoidBusiness = SABEasyAvoidBusiness(inputDetail);
    SABEasyStrategyResultModel modelResult;
    switch (strategy) {
      case SABEasyStrategyModel.avoid:
        modelResult = avoidBusiness.resultModel();
        break;
      default:
        modelResult = avoidBusiness.resultModel();
    }
    return modelResult;
  }
}
