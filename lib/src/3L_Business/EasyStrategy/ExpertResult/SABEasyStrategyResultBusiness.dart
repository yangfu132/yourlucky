import '../../StoreEasy/SABEasyDigitModel.dart';
import 'SABEasyStrategyResultModel.dart';

class SABEasyStrategyResultBusiness {
  late final SABEasyStrategyResultModel _expertModel =
      SABEasyStrategyResultModel();

  void configResultModel(SABEasyDigitModel inputEasyModel) {}
  SABEasyStrategyResultModel expertModel() {
    return _expertModel;
  }
}
