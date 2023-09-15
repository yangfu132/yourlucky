import 'package:yourlucky/src/A_Context/SACContext.dart';
import 'package:yourlucky/src/D_Business/Base/SABBaseModel.dart';
import 'package:yourlucky/src/D_Business/EasyLogic/BaseLogic/SABLogicRowModel.dart';
import 'package:yourlucky/src/D_Business/EasyLogic/Health/SABHealthRowModel.dart';
import 'package:yourlucky/src/D_Business/EasyLogic/SABHealthLogicRowModel.dart';
import 'package:yourlucky/src/D_Business/EasyWords/SABWordsRowModel.dart';

import '../../A_Context/SACGlobal.dart';
import '../EasyAnalysis/SABEasyAnalysisRowModel.dart';
import 'SABSymbolDetailModel.dart';

class SABRowDetailModel extends SABBaseModel {
  SABRowDetailModel({
    required this.inputAnalysisRow,
    required this.fromSymbol,
    required this.toSymbol,
    required this.hideSymbol,
  }) {
    // fromSymbol = SABSymbolDetailModel(
    //   baseInfo: ,
    //   symbolHealthDes: fromSymbolHealthDes(),
    //   monthRelation: analysisModel().getMonthRelation(EasyTypeEnum.from),
    //   dayRelation: analysisModel().getDayRelation(EasyTypeEnum.from),
    // );
    // toSymbol = SABSymbolDetailModel(
    //   symbolHealthDes: toSymbolHealthDes(),
    //   monthRelation: toMonthRelation(),
    //   dayRelation: toDayRelation(),
    // );
    // hideSymbol = SABSymbolDetailModel(
    //   symbolHealthDes: hideSymbolHealthDes(),
    //   monthRelation: hideMonthRelation(),
    //   dayRelation: hideDayRelation(),
    // );
  }
  final SABEasyAnalysisRowModel inputAnalysisRow;

  late final String stringDeity =
      healthLogicModel().getDeity(EasyTypeEnum.from); //事情

  late final String stringAnimal = wordsModel().stringAnimal; //六神

  late final String stringGoal = wordsModel().desOfGoalOrLife; //世应

  late final String stringChange = logicModel().stringSymbolForwardOrBack; //进化

  late final String stringConflictOrPair =
      analysisModel().getSymbolRelation(); //六爻冲合

  late final SABSymbolDetailModel fromSymbol;
  late final SABSymbolDetailModel toSymbol;
  late final SABSymbolDetailModel hideSymbol;

  void check() {
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
    EasyTypeEnum resultType = EasyTypeEnum.type_null;
    switch(currentType) {
      case EasyTypeEnum.from:
        resultType = EasyTypeEnum.to;
        break;
      case EasyTypeEnum.to:
        resultType = EasyTypeEnum.hide;
        break;
      case EasyTypeEnum.hide:
        resultType = EasyTypeEnum.from;
        break;
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
    if ('用神' == this.stringDeity) {
      final stringHideHealth = healthModel().hideSymbol.healthDescription();
      stringResult = wordsModel().getSymbolName(EasyTypeEnum.hide) +
          '[' +
          stringHideHealth +
          ']';
    } else {}
    return stringResult;
  }


  String toSymbolHealthDes() {
    String stringResult = "";
    if (wordsModel().bMovement) {
      final stringToHealth = healthModel().toSymbol.healthDescription();
      stringResult = wordsModel().getSymbolName(EasyTypeEnum.to) +
          '[' +
          stringToHealth +
          ']';
    } else {}
    return stringResult;
  }

  String hideDayRelation() {
    String stringResult = "";
    if ('用神' == this.stringDeity) {
      stringResult = analysisModel().getDayRelation(EasyTypeEnum.hide);
    } else {
      stringResult = '';
    }
    return stringResult;
  }

  String hideMonthRelation() {
    String stringResult = "";
    if ('用神' == this.stringDeity) {
      stringResult = analysisModel().getMonthRelation(EasyTypeEnum.hide);
    } else {}
    return stringResult;
  }

  String toMonthRelation() {
    String stringResult = "";
    if (wordsModel().bMovement) {
      stringResult = analysisModel().getMonthRelation(EasyTypeEnum.to);
    } else {}
    return stringResult;
  }

  String toDayRelation() {
    String stringResult = "";
    if (wordsModel().bMovement) {
      stringResult = analysisModel().getDayRelation(EasyTypeEnum.to);
    } else {}
    return stringResult;
  }

  /// `加载函数`/////////////////////////////////////////////////////////////////

  SABEasyAnalysisRowModel analysisModel() {
    return this.inputAnalysisRow;
  }

  SABHealthLogicRowModel healthLogicModel() {
    return this.inputAnalysisRow.healthLogicRow;
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
