import 'package:yourlucky/src/3L_Business/EasyLogic/SABEasyHealthLogicBusiness.dart';

import '../EasyAnalysis/SABEasyAnalysisBusiness.dart';
import '../EasyDetail/SABEasyDetailModel.dart';
import '../StoreEasy/SABEasyDigitModel.dart';

class SABEasyDetailBusiness {
  final SABEasyDigitModel _inputEasyModel;
  SABEasyDetailBusiness(this._inputEasyModel) {
    _outputDetailModel = initOutputDetailModel();
  }

  late final SABEasyDetailModel _outputDetailModel;

  late final SABEasyHealthLogicBusiness _healthLogicBusiness =
      SABEasyHealthLogicBusiness(_inputEasyModel);

  late final SABEasyAnalysisBusiness _analysisBusiness =
      SABEasyAnalysisBusiness(_healthLogicBusiness.outputModel());

  SABEasyAnalysisBusiness analysisBusiness() {
    return _analysisBusiness;
  }

  ///`加载函数`

  SABEasyDetailModel outputDetailModel() {
    return _outputDetailModel;
  }

  SABEasyDetailModel initOutputDetailModel() {
    //TODO:yangfu132细化detailmodel
    var outputDetailModel = SABEasyDetailModel(
      analysisBusiness().outAnalysisModel(),
      easyName(),
    );
    outputDetailModel.detailList();
    return outputDetailModel;
  }

  String easyName() {
    String stringResult = '';
    String formatTime =
        _healthLogicBusiness.logicModel().inputWordsModel.stringFormatTime;
    String formatDate = formatTime.split(' ')[0];
    stringResult += '$formatDate ${_inputEasyModel.getUsefulDeity()} 补充';
    return stringResult;
  }
}
