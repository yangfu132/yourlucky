import 'package:your_lucky/src/A_Context/sac_context.dart';
import 'package:your_lucky/src/D_Business/Base/sab_base_model.dart';
import 'package:your_lucky/src/D_Business/EasyLogic/BaseLogic/sab_logic_row_model.dart';
import 'package:your_lucky/src/D_Business/EasyLogic/Health/sab_health_row_model.dart';
import 'package:your_lucky/src/D_Business/EasyLogic/sab_health_logic_row_model.dart';
import 'package:your_lucky/src/D_Business/EasyWords/sab_words_row_model.dart';

import '../../A_Context/sac_global.dart';
import '../EasyAnalysis/sab_easy_analysis_row_model.dart';
import 'sab_symbol_detail_model.dart';

class SABRowDetailModel extends SABBaseModel {
  SABRowDetailModel({
    required this.inputAnalysisRow,
    required this.fromSymbol,
    required this.toSymbol,
    required this.hideSymbol,
    required this.bStaticEasy,
  }) ;
  final SABEasyAnalysisRowModel inputAnalysisRow;

  late final String stringDeity =
      healthLogicModel().getDeity(EasyTypeEnum.from); //事情

  late final String stringAnimal = wordsModel().getAnimal(); //六神

  late final String stringGoal = wordsModel().getDesOfGoalOrLife(); //世应

  late final String stringChange = logicModel().stringSymbolForwardOrBack; //进化

  late final String stringConflictOrPair =
      analysisModel().getSymbolRelation(); //六爻冲合

  late final SABSymbolDetailModel fromSymbol;
  late final SABSymbolDetailModel toSymbol;
  late final SABSymbolDetailModel hideSymbol;

  final bool bStaticEasy;

  @override void check() {
    inputAnalysisRow.check();
    fromSymbol.check();
    toSymbol.check();
    hideSymbol.check();
    if (stringDeity.isEmpty) {
      coLog(StackTrace.current, LogTypeEnum.check, "stringDeity.isEmpty");
    }
    if (stringAnimal.isEmpty) {
      coLog(StackTrace.current, LogTypeEnum.check, "stringAnimal.isEmpty");
    }
    if (stringGoal.isEmpty) {
      coLog(StackTrace.current, LogTypeEnum.check, "stringGoal.isEmpty");
    }
    if (stringChange.isEmpty) {
      coLog(StackTrace.current, LogTypeEnum.check, "stringChange.isEmpty");
    }
    if (stringConflictOrPair.isEmpty) {
      coLog(StackTrace.current, LogTypeEnum.check,
          "stringConflictOrPair.isEmpty");
    }
    super.check();
  }

  List<Map> resultList(EasyTypeEnum easyType) {
    List<Map> result ;
    switch(easyType) {
      case EasyTypeEnum.from:
        result = fromSymbol.resultList();
        break;
      case EasyTypeEnum.to:
        result = toSymbol.resultList();
        break;
      case EasyTypeEnum.hide:
        result = hideSymbol.resultList();
        break;
      default:
        result = List<Map>.empty(growable: false);
        break;
    }
    return result;
  }

  EasyTypeEnum getNextEasyType(EasyTypeEnum currentType) {
    EasyTypeEnum resultType = EasyTypeEnum.typeNull;
    switch(currentType) {
      case EasyTypeEnum.from:
        if (bStaticEasy) {
          resultType = EasyTypeEnum.hide;
        }else {
          resultType = EasyTypeEnum.to;
        }
        break;
      case EasyTypeEnum.to:
        resultType = EasyTypeEnum.hide;
        break;
      case EasyTypeEnum.hide:
        resultType = EasyTypeEnum.from;
        break;
      default:
        error();
    }
    return resultType;
  }

  String getSymbolName(EasyTypeEnum easyTypeEnum) {
    String strResult = 'SABRowDetailModel.getSymbolName';
    if (easyTypeEnum == EasyTypeEnum.from) {
      strResult = fromSymbol.getSymbolName();
    } else if (easyTypeEnum == EasyTypeEnum.to) {
      strResult = toSymbol.getSymbolName();
    } else if (easyTypeEnum == EasyTypeEnum.hide) {
      strResult = hideSymbol.getSymbolName();
    } else {
      coLog(StackTrace.current,LogTypeEnum.error,'easyTypeEnum:$easyTypeEnum');
    }
    return strResult;
  }

  String hideSymbolHealthDes() {
    String stringResult = "";
    if ('用神' == stringDeity) {
      final stringHideHealth = healthModel().hideSymbol.healthDescription();
      stringResult = '${wordsModel().getSymbolName(EasyTypeEnum.hide)}[$stringHideHealth]';
    } else {}
    return stringResult;
  }


  String toSymbolHealthDes() {
    String stringResult = "";
    if (wordsModel().isMovement()) {
      final stringToHealth = healthModel().toSymbol.healthDescription();
      stringResult = '${wordsModel().getSymbolName(EasyTypeEnum.to)}[$stringToHealth]';
    } else {}
    return stringResult;
  }

  String hideDayRelation() {
    String stringResult = "";
    if ('用神' == stringDeity) {
      stringResult = analysisModel().getDayRelation(EasyTypeEnum.hide);
    } else {
      stringResult = '';
    }
    return stringResult;
  }

  String hideMonthRelation() {
    String stringResult = "";
    if ('用神' == stringDeity) {
      stringResult = analysisModel().getMonthRelation(EasyTypeEnum.hide);
    } else {}
    return stringResult;
  }

  String toMonthRelation() {
    String stringResult = "";
    if (wordsModel().isMovement()) {
      stringResult = analysisModel().getMonthRelation(EasyTypeEnum.to);
    } else {}
    return stringResult;
  }

  String toDayRelation() {
    String stringResult = "";
    if (wordsModel().isMovement()) {
      stringResult = analysisModel().getDayRelation(EasyTypeEnum.to);
    } else {}
    return stringResult;
  }

  /// `加载函数`/////////////////////////////////////////////////////////////////

  SABEasyAnalysisRowModel analysisModel() {
    return inputAnalysisRow;
  }

  SABHealthLogicRowModel healthLogicModel() {
    return inputAnalysisRow.healthLogicRow;
  }

  SABHealthRowModel healthModel() {
    return analysisModel().healthLogicRow.healthRow;
  }

  SABLogicRowModel logicModel() {
    return healthModel().inputLogicRow;
  }

  SABWordsRowModel wordsModel() {
    return logicModel().inputWordsRow;
  }
}
