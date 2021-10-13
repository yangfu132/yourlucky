import 'package:yourlucky/src/3L_Business/EasyDetail/SABDiagramsDetailBusiness.dart';
import 'package:yourlucky/src/3L_Business/EasyDetail/SABDiagramsDetailModel.dart';
import 'package:yourlucky/src/3L_Business/EasyLogic/SABEasyHealthLogicBusiness.dart';

import '../EasyDetail/SABEasyDetailModel.dart';
import '../EasyLogicDescription/SABEasyLogicDescriptionBusiness.dart';
import '../StoreEasy/SABEasyDigitModel.dart';

class SABEasyDetailBusiness {
  final SABEasyDigitModel _inputEasyModel;
  SABEasyDetailBusiness(this._inputEasyModel) {
    _outputDetailModel = initOutputDetailModel();
  }

  late final SABEasyDetailModel _outputDetailModel;

  late final SABEasyHealthLogicBusiness _healthLogicBusiness =
      SABEasyHealthLogicBusiness(_inputEasyModel);

  late final SABEasyLogicDescriptionBusiness _analysisBusiness =
      SABEasyLogicDescriptionBusiness(_healthLogicBusiness.outputModel());

  SABEasyLogicDescriptionBusiness analysisBusiness() {
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

  SABDiagramsDetailModel diagramsDetailModel() {
    SABDiagramsDetailBusiness _diagramsDetailBusiness =
        SABDiagramsDetailBusiness(analysisBusiness().outAnalysisModel());
    SABDiagramsDetailModel diagramsDetailModel = SABDiagramsDetailModel();
    _diagramsDetailBusiness.configResultModel(diagramsDetailModel);
    return diagramsDetailModel;
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
