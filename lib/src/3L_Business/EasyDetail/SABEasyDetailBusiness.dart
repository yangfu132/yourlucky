﻿import 'package:yourlucky/src/1L_Context/SACGlobal.dart';
import 'package:yourlucky/src/3L_Business/EasyDetail/SABDiagramsDetailBusiness.dart';
import 'package:yourlucky/src/3L_Business/EasyDetail/SABDiagramsDetailModel.dart';
import 'package:yourlucky/src/3L_Business/EasyLogic/BaseLogic/SABEasyLogicModel.dart';
import 'package:yourlucky/src/3L_Business/EasyLogic/SABEasyHealthLogicBusiness.dart';
import 'package:yourlucky/src/3L_Business/EasyWords/SABEasyWordsModel.dart';
import 'package:yourlucky/src/4L_Service/SASStringService.dart';

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

  ///`symbol result`
  String symbolBasic(int intRow, EasyTypeEnum easyType) {
    String result = "";
    //用神
    String symbolGod =
        _outputDetailModel.healthLogicModel().getDeity(intRow, easyType);
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
    String strResult = '';
    String earthName = wordsModel().getSymbolEarth(intRow, easyType);
    return logicModel().earthBranchModel().likeDescription(earthName);
  }

  String symbolSixPairResultAtRow(int intRow, EasyTypeEnum easyType) {
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

  String symbolSixPair(int intRow, EasyTypeEnum easyType) {
    return symbolSixPairResultAtRow(intRow, easyType);
  }

  String symbolTitle(int intRow, EasyTypeEnum easyType) {
    String strPosition = analysisBusiness().positionAtRow(intRow, easyType);

    String symbolName = wordsModel().getSymbolName(intRow, easyType);

    return strPosition + ' ' + symbolName;
  }

// - (NSString*) symbolAnimalLike
// {
// NSString* result = [[self animalLike] objectForKey:[self.easyData animalAtRow:self.symbolRow]];
//
// return result;
// }
//
// - (NSString*) symbolEarthDirection
// {
// NSString* earth = [self symbolEarth];
//
// NSString* result = [earth stringByAppendingFormat:@"：%@",
// [[[self earthBranch] earthDirection] objectForKey:earth]];
//
// return result;
// }
//
// - (NSString*) symbolGuaPlace
// {
// NSString* result = @"";
//
// //    result = [result stringByAppendingFormat:@"卦：先天八卦位于%@，",
// //              [[COMEightGua earlyPlace] objectForKey:self.symbolEasy]];
//
// NSString* strGua = [self.easyData eightGuaAtFromRow:self.symbolRow];
// result = [result stringByAppendingFormat:@"后天八卦位于%@ ",
// [[COMEightDiagrams latePlace] objectForKey:strGua]];
// return result;
// }
  ///`加载函数`

  SABEasyDetailModel outputDetailModel() {
    return _outputDetailModel;
  }

  SABEasyDetailModel initOutputDetailModel() {
    //TODO:yangfu132细化detailmodel
    var outputDetailModel = SABEasyDetailModel(
      analysisBusiness().outAnalysisModel(),
      easyName(),
      diagramsDetailModel(),
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
}
