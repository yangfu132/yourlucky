import '../../EasyBasic/SABEasyDigitModel.dart';
import 'SABEasyExpertResultModel.dart';

class SABEasyExpertResultBusiness {
  late final SABEasyExpertResultModel _expertModel = SABEasyExpertResultModel();

  void configResultModel(SABEasyDigitModel inputEasyModel) {}
  SABEasyExpertResultModel expertModel() {
    return _expertModel;
  }
}
