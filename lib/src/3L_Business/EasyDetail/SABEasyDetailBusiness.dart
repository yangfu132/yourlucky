import 'package:yourlucky/src/1L_Context/SACGlobal.dart';
import 'package:yourlucky/src/3L_Business/BasicEasy/SABAnimalModel.dart';
import 'package:yourlucky/src/3L_Business/EasyDetail/SABDiagramsDetailBusiness.dart';
import 'package:yourlucky/src/3L_Business/EasyDetail/SABDiagramsDetailModel.dart';
import 'package:yourlucky/src/3L_Business/EasyLogic/BaseLogic/SABEasyLogicModel.dart';
import 'package:yourlucky/src/3L_Business/EasyLogic/SABEasyHealthLogicBusiness.dart';
import 'package:yourlucky/src/3L_Business/EasyLogic/SABEasyHealthLogicModel.dart';
import 'package:yourlucky/src/3L_Business/EasyLogicDescription/SABEasyLogicDescriptionModel.dart';
import 'package:yourlucky/src/3L_Business/EasyWords/SABEasyWordsModel.dart';
import 'package:yourlucky/src/4L_Service/SASStringService.dart';

import '../EasyDetail/SABEasyDetailModel.dart';
import '../EasyLogicDescription/SABEasyLogicDescriptionBusiness.dart';
import '../StoreEasy/SABEasyDigitModel.dart';

class SABEasyDetailBusiness {
  final SABEasyDigitModel _inputEasyModel;
  SABEasyDetailBusiness(this._inputEasyModel);

  late final SABEasyDetailModel _outputDetailModel = initOutputDetailModel();

  late final SABEasyHealthLogicBusiness _healthLogicBusiness =
      SABEasyHealthLogicBusiness(_inputEasyModel);

  late final SABEasyLogicDescriptionBusiness _analysisBusiness =
      SABEasyLogicDescriptionBusiness(_healthLogicBusiness.outputModel());

  SABEasyLogicDescriptionBusiness analysisBusiness() {
    return _analysisBusiness;
  }

  ///`symbol result`
  String symbolBasic(int intRow, EasyTypeEnum easyType) {
    String result = "";
    //用神
    String symbolGod = healthLogicModel().getDeity(intRow, easyType);
    if (symbolGod.isNotEmpty) {
      result = result + symbolGod + ' ';
    }

    //动静
    String symbolMovement = analysisBusiness().movementDescriptionAtRow(intRow);
    result = result + symbolMovement + ' ';

    //世应
    String symbolRole = analysisBusiness().roleDescriptionAtRow(intRow);
    if (symbolRole.isNotEmpty) {
      result = result + symbolRole + ' ';
    }

    //health
    String symbolStrong =
        analysisBusiness().healthDescriptionAtRow(intRow, easyType);
    if (symbolStrong.isNotEmpty) {
      result = result + symbolStrong + ' ';
    }

    //change
    String symbolChange = analysisBusiness().changeAnalysisAtRow(intRow);
    if (symbolChange.isNotEmpty) {
      result = result + symbolChange + ' ';
    }
    return result;
  }

  String symbolEarthLike(int intRow, EasyTypeEnum easyType) {
    String earthName = wordsModel().getSymbolEarth(intRow, easyType);
    return logicModel().earthBranchModel().likeDescription(earthName);
  }

  String symbolSixPair(int intRow, EasyTypeEnum easyType) {
    String strResult = "";

    String resultMonth =
        analysisBusiness().resultMonthPairAtRow(intRow, easyType);
    if (resultMonth.isNotEmpty) {
      strResult = SASStringService.appendToString(strResult, resultMonth);
    } //else nothing

    String resultDay = analysisBusiness().resultDayPairAtRow(intRow, easyType);
    if (resultDay.isNotEmpty)
      strResult = SASStringService.appendToString(strResult, resultDay);
    //else cont.

    String resultMove =
        analysisBusiness().resultMovePairAtRow(intRow, easyType);
    if (resultMove.isNotEmpty)
      strResult = SASStringService.appendToString(strResult, resultMove);
    //else cont.

    String resultChange =
        analysisBusiness().resultChangePairAtRow(intRow, easyType);
    if (resultChange.isNotEmpty)
      strResult = SASStringService.appendToString(strResult, resultChange);
    //else cont.

    return strResult;
  }

  String symbolTitle(int intRow, EasyTypeEnum easyType) {
    String strPosition = analysisBusiness().positionAtRow(intRow, easyType);

    String symbolName = wordsModel().getSymbolName(intRow, easyType);

    return strPosition + ' ' + symbolName;
  }

  String symbolAnimalLike(int intRow) {
    String animal = wordsModel().getAnimal(intRow);
    SABAnimalModel animalModel = SABAnimalModel();
    return animalModel.likeOfAnimal(animal);
  }

  String symbolEarthDirection(int intRow, EasyTypeEnum easyType) {
    String earth = wordsModel().getSymbolEarth(intRow, easyType);
    String result =
        earth + ' ' + logicModel().earthBranchModel().earthDirection()[earth];
    return result;
  }

  String eightDiagramsPlace(int intRow) {
    String strGua = wordsModel().rowModelAtRow(intRow).stringDiagrams;
    String result = strGua + ':';
    result = '先天八卦位于' + wordsModel().eightDiagrams.earlyPlace()[strGua] + ',';
    result += '后天八卦位于' + wordsModel().eightDiagrams.latePlace()[strGua];
    return result;
  }

  ///`加载函数`

  SABEasyDetailModel outputDetailModel() {
    return _outputDetailModel;
  }

  SABEasyDetailModel initOutputDetailModel() {
    //TODO:yangfu132细化detailmodel
    var outputDetailModel = SABEasyDetailModel(
      analysisModel(),
      easyName(),
      diagramsDetailModel(),
    );
    outputDetailModel.detailList();

    for (int intRow = 0; intRow < 6; intRow++) {
      List<Map> resultList = outputDetailModel.rowModelAtRow(intRow).resultList;
      resultList[0]['value'] = symbolBasic(intRow, EasyTypeEnum.from);
      resultList[1]['value'] = symbolAnimalLike(intRow);
      resultList[2]['value'] = symbolEarthLike(intRow, EasyTypeEnum.from);
      resultList[3]['value'] = symbolSixPair(intRow, EasyTypeEnum.from);
      resultList[4]['value'] =
          analysisModel().getMonthRelation(intRow, EasyTypeEnum.from);
      resultList[5]['value'] =
          analysisModel().getDayRelation(intRow, EasyTypeEnum.from);
      resultList[6]['value'] = symbolEarthDirection(intRow, EasyTypeEnum.from);
      resultList[7]['value'] = eightDiagramsPlace(intRow);
    }
    return outputDetailModel;
  }

  SABDiagramsDetailModel diagramsDetailModel() {
    SABDiagramsDetailBusiness _diagramsDetailBusiness =
        SABDiagramsDetailBusiness(analysisModel());
    SABDiagramsDetailModel diagramsDetailModel = SABDiagramsDetailModel();
    _diagramsDetailBusiness.configResultModel(diagramsDetailModel);
    return diagramsDetailModel;
  }

  String easyName() {
    String stringResult = '';
    String formatTime = wordsModel().stringFormatTime;
    String formatDate = formatTime.split(' ')[0];
    stringResult += '$formatDate ${_inputEasyModel.getUsefulDeity()} 补充';
    return stringResult;
  }

  SABEasyWordsModel wordsModel() {
    return logicModel().inputWordsModel;
  }

  SABEasyLogicModel logicModel() {
    return _healthLogicBusiness.logicModel();
  }

  SABEasyLogicDescriptionModel analysisModel() {
    return analysisBusiness().outAnalysisModel();
  }

  SABEasyHealthLogicModel healthLogicModel() {
    return analysisModel().inputHealthLogicModel;
  }
}
