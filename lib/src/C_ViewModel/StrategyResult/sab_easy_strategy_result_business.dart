import 'package:your_lucky/src/C_ViewModel/EasyDetail/sab_easy_detail_model.dart';
import 'package:your_lucky/src/D_Business/Base/SABBaseBusiness.dart';
import 'package:your_lucky/src/D_Business/DigitModel/SABEasyDigitModel.dart';
import 'package:your_lucky/src/D_Business/Strategy/SABEasyStrategyInfoModel.dart';

import '../../D_Business/Strategy/SABAvoidStrategyBusiness.dart';
import 'sab_easy_strategy_result_model.dart';

class SABEasyStrategyResultBusiness extends SABBaseBusiness {
  SABEasyStrategyResultBusiness(
      {required this.inputDetail, required this.strategy});
  final String strategy;
  final SABEasyDetailModel inputDetail;
  void configResultModel(SABEasyDigitModel inputEasyModel) {}
  SABEasyStrategyResultModel resultModel() {
    SABEasyStrategyResultModel modelResult;
    switch (strategy) {
      case SABEasyStrategyInfoModel.avoid:
        SABAvoidStrategyBusiness avoidBusiness =
            SABAvoidStrategyBusiness(inputDetail);
        modelResult = avoidBusiness.resultModel();
        break;
      default:
        modelResult = SABEasyStrategyResultModel.empty();
    }
    return modelResult;
  }
}
