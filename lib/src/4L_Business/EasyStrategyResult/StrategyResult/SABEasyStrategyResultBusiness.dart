﻿import 'package:yourlucky/src/4L_Business/Base/SABBaseBusiness.dart';
import 'package:yourlucky/src/4L_Business/DigitModel/SABEasyDigitModel.dart';
import 'package:yourlucky/src/4L_Business/EasyDetail/SABEasyDetailModel.dart';

import '../Strategy/SABEasyStrategyInfoModel.dart';
import 'SABEasyAvoidBusiness.dart';
import 'SABEasyStrategyResultModel.dart';

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
        SABEasyAvoidBusiness avoidBusiness = SABEasyAvoidBusiness(inputDetail);
        modelResult = avoidBusiness.resultModel();
        break;
      default:
        modelResult = SABEasyStrategyResultModel.empty();
    }
    return modelResult;
  }
}