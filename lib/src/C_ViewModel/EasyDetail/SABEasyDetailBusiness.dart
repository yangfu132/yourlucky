import 'package:yourlucky/src/A_Context/SACGlobal.dart';
import 'package:yourlucky/src/C_ViewModel/EasyAnalysis/SABEasyAnalysisModel.dart';
import 'package:yourlucky/src/C_ViewModel/EasyAnalysis/SABEasyAnalysisRowModel.dart';
import 'package:yourlucky/src/C_ViewModel/EasyAnalysis/SABEasyAnalysisSymbolModel.dart';
import 'package:yourlucky/src/C_ViewModel/EasyDetail/SABRowDetailModel.dart';
import 'package:yourlucky/src/D_Business/Base/SABBaseBusiness.dart';
import 'package:yourlucky/src/D_Business/BasicEasy/SABAnimalInfoModel.dart';
import 'package:yourlucky/src/D_Business/DigitModel/SABEasyDigitModel.dart';
import 'package:yourlucky/src/D_Business/EasyLogic/BaseLogic/SABEasyLogicModel.dart';
import 'package:yourlucky/src/D_Business/EasyLogic/SABEasyHealthLogicBusiness.dart';
import 'package:yourlucky/src/D_Business/EasyLogic/SABEasyHealthLogicModel.dart';
import 'package:yourlucky/src/D_Business/EasyWords/SABEasyWordsModel.dart';
import 'package:yourlucky/src/E_Service/SASStringService.dart';

import '../EasyAnalysis/SABEasyAnalysisBusiness.dart';
import '../EasyDetail/SABEasyDetailModel.dart';
import 'SABDiagramsDetailBusiness.dart';
import 'SABDiagramsDetailModel.dart';
import 'SABSymbolDetailModel.dart';

class SABEasyDetailBusiness extends SABBaseBusiness {
  final SABEasyDigitModel _inputEasyModel;
  SABEasyDetailBusiness(this._inputEasyModel);

  late final SABEasyDetailModel _outputDetailModel = initOutputDetailModel();

  late final SABEasyHealthLogicBusiness _healthLogicBusiness =
      SABEasyHealthLogicBusiness(_inputEasyModel);

  late final SABEasyAnalysisBusiness _analysisBusiness =
      SABEasyAnalysisBusiness(_healthLogicBusiness.outputModel());

  SABEasyAnalysisBusiness analysisBusiness() {
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
        healthLogicModel().rowModelAtRow(intRow).getStringHealth(easyType) ??
            '??';
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
    SABAnimalInfoModel animalModel = SABAnimalInfoModel();
    return animalModel.likeOfAnimal(animal);
  }

  String symbolEarthDirection(int intRow, EasyTypeEnum easyType) {
    String earth = wordsModel().getSymbolEarth(intRow, easyType);
    String result =
        earth + ' ' + logicModel().earthBranchModel().earthDirection()[earth];
    return result;
  }

  String eightDiagramsPlace(int intRow, EasyTypeEnum easyTypeEnum) {
    String strGua = wordsModel().rowModelAtRow(intRow).stringDiagrams;
    String result = strGua + ':';
    result = '先天八卦位于' + wordsModel().getEarlyPlace(intRow, easyTypeEnum);
    result += '后天八卦位于' + wordsModel().getLatePlace(intRow, easyTypeEnum);
    return result;
  }

  ///`加载函数`

  SABEasyDetailModel outputDetailModel() {
    return _outputDetailModel;
  }

  SABSymbolDetailModel createSymbolModel(
      SABEasyAnalysisSymbolModel analysisSymbol,
      int intRow,
      EasyTypeEnum type){

     SABSymbolDetailModel fromSymbol = SABSymbolDetailModel(
        inputAnalysisSymbol:analysisSymbol,
        baseInfo:symbolBasic(intRow, type),
        animalDes:symbolAnimalLike(intRow),
        earthDes:symbolEarthLike(intRow, type),
        sixPairDes:symbolSixPair(intRow, type),
        monthRelation:analysisModel().getMonthRelation(intRow, type),
        dayRelation:analysisModel().getDayRelation(intRow, type),
        earthDirection:symbolEarthDirection(intRow, type),
        diagramsPlace:eightDiagramsPlace(intRow, type),
        debugInfo: '未填写debugInfo'
    );
     return fromSymbol;
  }

  SABEasyDetailModel initOutputDetailModel() {
    var outputDetailModel = SABEasyDetailModel(
      analysisModel(),
      easyName(),
      diagramsDetailModel(),
    );
    outputDetailModel.detailList();

    for (int intRow = 0; intRow < 6; intRow++) {
      SABEasyAnalysisRowModel analysisRow = analysisModel().rowModelAtRow(intRow);
      SABSymbolDetailModel fromSymbol = createSymbolModel(analysisRow.fromSymbol,intRow, EasyTypeEnum.from);
      SABSymbolDetailModel toSymbol = createSymbolModel(analysisRow.toSymbol,intRow, EasyTypeEnum.to);
      SABSymbolDetailModel hideSymbol = createSymbolModel(analysisRow.hideSymbol,intRow, EasyTypeEnum.hide);
      SABRowDetailModel rowDetailModel = SABRowDetailModel(
          inputAnalysisRow:analysisRow,
          fromSymbol: fromSymbol,
          toSymbol: toSymbol,
          hideSymbol: hideSymbol);
      outputDetailModel.addRow(rowDetailModel);
    }
    outputDetailModel.check();
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
    String formatTime = wordsModel().inputDigitModel.stringTime;
    String formatDate = formatTime.split(' ')[0];
    stringResult += '$formatDate ${_inputEasyModel.strUsefulDeity} 补充';
    return stringResult;
  }

  SABEasyWordsModel wordsModel() {
    return logicModel().inputWordsModel;
  }

  SABEasyLogicModel logicModel() {
    return _healthLogicBusiness.logicModel();
  }

  SABEasyAnalysisModel analysisModel() {
    return analysisBusiness().outAnalysisModel();
  }

  SABEasyHealthLogicModel healthLogicModel() {
    return analysisModel().inputHealthLogicModel;
  }
}
