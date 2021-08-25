import 'package:yourlucky/src/3L_Business/EasyStrategy/EasyStrategy/SABEasyStrategyModel.dart';
import 'package:yourlucky/src/3L_Business/StoreEasy/SABEasyDigitModel.dart';

import 'SABEasyStrategyResultModel.dart';

class SABEasyStrategyResultBusiness {
  SABEasyStrategyResultBusiness({required this.strategy});
  final String strategy;
  void configResultModel(SABEasyDigitModel inputEasyModel) {}
  SABEasyStrategyResultModel expertModel() {
    SABEasyStrategyResultModel modelResult = SABEasyStrategyResultModel();
    switch (strategy) {
      case SABEasyStrategyModel.avoid:
        break;
    }
    return modelResult;
  }
}
