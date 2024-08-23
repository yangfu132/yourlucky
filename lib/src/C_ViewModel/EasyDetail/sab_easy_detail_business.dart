import 'package:your_lucky/src/A_Context/sac_global.dart';
import 'package:your_lucky/src/C_ViewModel/EasyAnalysis/sab_easy_analysis_model.dart';
import 'package:your_lucky/src/C_ViewModel/EasyAnalysis/sab_easy_analysis_row_model.dart';
import 'package:your_lucky/src/C_ViewModel/EasyAnalysis/sab_easy_analysis_symbol_model.dart';
import 'package:your_lucky/src/C_ViewModel/EasyDetail/sab_row_detail_model.dart';
import 'package:your_lucky/src/D_Business/Base/sab_base_business.dart';
import 'package:your_lucky/src/D_Business/BasicEasy/sab_animal_info_model.dart';
import 'package:your_lucky/src/D_Business/BasicEasy/sab_easy_info_model.dart';
import 'package:your_lucky/src/D_Business/DigitModel/sab_easy_digit_model.dart';
import 'package:your_lucky/src/D_Business/EasyLogic/BaseLogic/sab_easy_logic_model.dart';
import 'package:your_lucky/src/D_Business/EasyLogic/sab_easy_health_logic_business.dart';
import 'package:your_lucky/src/D_Business/EasyLogic/sab_easy_health_logic_model.dart';
import 'package:your_lucky/src/D_Business/EasyWords/sab_easy_words_model.dart';
import 'package:your_lucky/src/E_Service/sas_string_service.dart';

import '../../D_Business/EasyWords/sab_day_model.dart';
import '../../D_Business/EasyWords/sab_month_model.dart';
import '../EasyAnalysis/sab_easy_analysis_business.dart';
import '../EasyDetail/sab_easy_detail_model.dart';
import 'sab_diagrams_detail_business.dart';
import 'sab_diagrams_detail_model.dart';
import 'sab_symbol_detail_model.dart';

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
      result = '$result$symbolGod ';
    }

    //动静
    String symbolMovement = analysisBusiness().movementDescriptionAtRow(intRow);
    result = '$result$symbolMovement ';

    //世应
    String symbolRole = analysisBusiness().roleDescriptionAtRow(intRow);
    if (symbolRole.isNotEmpty) {
      result = '$result$symbolRole ';
    }

    //health
    String symbolStrong =
        healthLogicModel().rowModelAtRow(intRow).getStringHealth(easyType) ??
            '??';
    if (symbolStrong.isNotEmpty) {
      result = '$result$symbolStrong ';
    }

    //change
    String symbolChange = analysisBusiness().changeAnalysisAtRow(intRow);
    if (symbolChange.isNotEmpty) {
      result = '$result$symbolChange ';
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
    if (resultDay.isNotEmpty) {
      strResult = SASStringService.appendToString(strResult, resultDay);
    } //else cont.

    String resultMove =
        analysisBusiness().resultMovePairAtRow(intRow, easyType);
    if (resultMove.isNotEmpty) {
      strResult = SASStringService.appendToString(strResult, resultMove);
    } //else cont.

    String resultChange =
        analysisBusiness().resultChangePairAtRow(intRow, easyType);
    if (resultChange.isNotEmpty) {
      strResult = SASStringService.appendToString(strResult, resultChange);
    } //else cont.

    return strResult;
  }

  String symbolTitle(int intRow, EasyTypeEnum easyType) {
    String strPosition = analysisBusiness().positionAtRow(intRow, easyType);

    String symbolName = wordsModel().getSymbolName(intRow, easyType);

    return '$strPosition $symbolName';
  }

  String symbolAnimalLike(int intRow) {
    String animal = wordsModel().getAnimal(intRow);
    SABAnimalInfoModel animalModel = SABAnimalInfoModel();
    return animalModel.likeOfAnimal(animal);
  }

  String symbolEarthDirection(int intRow, EasyTypeEnum easyType) {
    String earth = wordsModel().getSymbolEarth(intRow, easyType);
    String result =
        '$earth ${logicModel().earthBranchModel().earthDirection()[earth]}';
    return result;
  }

  String eightDiagramsPlace(int intRow, EasyTypeEnum easyTypeEnum) {
    String strGua = wordsModel().getDiagrams(intRow);
    String result = '$strGua:';
    result = '先天八卦位于${wordsModel().getEarlyPlace(intRow, easyTypeEnum)}，';
    result += '后天八卦位于${wordsModel().getLatePlace(intRow, easyTypeEnum)}';
    return result;
  }

  ///`加载函数`

  SABEasyDetailModel outputDetailModel() {
    return _outputDetailModel;
  }

  SABSymbolDetailModel createSymbolModel(
      SABEasyAnalysisSymbolModel analysisSymbol,
      int intRow,
      EasyTypeEnum easyType) {
    String strSymbolName = wordsModel().getSymbolName(intRow, easyType);
    String stringHealth = healthLogicModel().getHealthDescription(intRow,easyType);
    late final String easyKey = wordsModel().inputDigitModel.diagramsModel.getEasyKey(easyType);
    SABSymbolDetailModel detailSymbol = SABSymbolDetailModel(
        strSymbolName: strSymbolName,
        baseInfo: symbolBasic(intRow, easyType),
        animalDes: symbolAnimalLike(intRow),
        earthDes: symbolEarthLike(intRow, easyType),
        sixPairDes: symbolSixPair(intRow, easyType),
        monthRelation: analysisModel().getMonthRelation(intRow, easyType),
        dayRelation: analysisModel().getDayRelation(intRow, easyType),
        earthDirection: symbolEarthDirection(intRow, easyType),
        diagramsPlace: eightDiagramsPlace(intRow, easyType),
        debugInfo: '未填写debugInfo',
        stringHealth: stringHealth,
      easyKey: easyKey,
    );
    return detailSymbol;
  }

  SABSymbolDetailModel createMonthModel(SABMonthModel inputModel) {
    String strSymbolName = inputModel.skyEarth();
    String stringHealth = inputModel.healthDes();
    String earth = inputModel.stringEarth;
    String easyKey = wordsModel().inputDigitModel.diagramsModel.getEasyKey(EasyTypeEnum.from);
    SABSymbolDetailModel detailSymbol = SABSymbolDetailModel(
        strSymbolName: strSymbolName,
        baseInfo: strSymbolName,
        animalDes: strSymbolName,
        earthDes: logicModel().earthBranchModel().likeDescription(earth),
        sixPairDes: 'symbolSixPair(intRow, type)',
        monthRelation: strSymbolName,
        dayRelation: 'analysisModel().getDayRelation(intRow, type)',
        earthDirection: '$earth ${logicModel().earthBranchModel().earthDirection()[earth]}',
        diagramsPlace: '无',
        debugInfo: '未填写debugInfo',
        stringHealth: stringHealth,
      easyKey: easyKey,
    );
    return detailSymbol;
  }

  SABSymbolDetailModel createDayModel(SABDayModel inputModel) {
    String strSymbolName = inputModel.skyEarth();
    String stringHealth = inputModel.healthDes();
    String earth = inputModel.stringEarth;
    String easyKey = wordsModel().inputDigitModel.diagramsModel.getEasyKey(EasyTypeEnum.from);
    SABSymbolDetailModel detailSymbol = SABSymbolDetailModel(
        strSymbolName: strSymbolName,
        baseInfo: strSymbolName,
        animalDes: strSymbolName,
        earthDes: logicModel().earthBranchModel().likeDescription(earth),
        sixPairDes: 'symbolSixPair(intRow, type)',
        monthRelation: 'analysisModel().getMonthRelation(intRow, type)',
        dayRelation: strSymbolName,
        earthDirection: '$earth ${logicModel().earthBranchModel().earthDirection()[earth]}',
        diagramsPlace: '无',
        debugInfo: '未填写debugInfo',
        stringHealth: stringHealth,
      easyKey: easyKey,
    );
    return detailSymbol;
  }

  SABEasyDetailModel initOutputDetailModel() {
    var outputDetailModel = SABEasyDetailModel(
      analysisModel(),
      easyName(),
      diagramsDetailModel(),
      createDayModel(wordsModel().dayModel),
      createMonthModel(wordsModel().monthModel),
    );
    outputDetailModel.detailList();
    bool bStaticEasy = healthLogicModel()
        .inputHealthModel
        .inputLogicModel
        .diagramsModel
        .bStaticEasy;

    for (int intRow = 0; intRow < 6; intRow++) {
      SABEasyAnalysisRowModel analysisRow =
          analysisModel().rowModelAtRow(intRow);
      SABSymbolDetailModel fromSymbol =
          createSymbolModel(analysisRow.fromSymbol, intRow, EasyTypeEnum.from);
      SABSymbolDetailModel toSymbol =
          createSymbolModel(analysisRow.toSymbol, intRow, EasyTypeEnum.to);
      SABSymbolDetailModel hideSymbol =
          createSymbolModel(analysisRow.hideSymbol, intRow, EasyTypeEnum.hide);
      SABRowDetailModel rowDetailModel = SABRowDetailModel(
          inputAnalysisRow: analysisRow,
          fromSymbol: fromSymbol,
          toSymbol: toSymbol,
          hideSymbol: hideSymbol,
          bStaticEasy: bStaticEasy,
      );
      outputDetailModel.addRow(rowDetailModel);
    }
    outputDetailModel.check();
    return outputDetailModel;
  }

  SABDiagramsDetailModel diagramsDetailModel() {
    SABDiagramsDetailBusiness diagramsDetailBusiness =
        SABDiagramsDetailBusiness(analysisModel());
    SABDiagramsDetailModel diagramsDetailModel = SABDiagramsDetailModel();
    diagramsDetailBusiness.configResultModel(diagramsDetailModel);
    return diagramsDetailModel;
  }

  String easyName() {
    String stringResult = '';
    String formatTime = wordsModel().inputDigitModel.stringTime;
    String formatDate = formatTime.split(' ')[0];
    stringResult += '$formatDate ${_inputEasyModel.strUsefulDeity}';
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
