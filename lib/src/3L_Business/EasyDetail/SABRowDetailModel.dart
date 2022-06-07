import 'package:yourlucky/src/3L_Business/Base/SABBaseModel.dart';
import 'package:yourlucky/src/3L_Business/EasyDetail/SABSymbolDetailModel.dart';
import 'package:yourlucky/src/3L_Business/EasyLogic/SABRowHealthLogicModel.dart';

import '../../1L_Context/SACGlobal.dart';
import '../EasyLogic/BaseLogic/SABLogicRowModel.dart';
import '../EasyLogic/Health/SABRowHealthModel.dart';
import '../EasyLogicDescription/SABRowLogicDescriptionModel.dart';
import '../EasyWords/SABWordsRowModel.dart';

class SABRowDetailModel extends SABBaseModel {
  SABRowDetailModel(this.inputAnalysisRow);
  final SABRowLogicDescriptionModel inputAnalysisRow;

  late final String stringDeity =
      healthLogicModel().getDeity(EasyTypeEnum.from); //事情

  late final String stringAnimal = wordsModel().stringAnimal; //六神

  late final String stringGoal = wordsModel().desOfGoalOrLife; //世应

  late final String stringChange = logicModel().stringSymbolForwardOrBack; //进化

  late final String stringConflictOrPair =
      analysisModel().getSymbolRelation(); //六爻冲合

  late final SABSymbolDetailModel fromSymbol = SABSymbolDetailModel(
    symbolHealthDes: fromSymbolHealthDes(),
    monthRelation: analysisModel().getMonthRelation(EasyTypeEnum.from),
    dayRelation: analysisModel().getDayRelation(EasyTypeEnum.from),
  );
  late final SABSymbolDetailModel toSymbol = SABSymbolDetailModel(
    symbolHealthDes: toSymbolHealthDes(),
    monthRelation: toMonthRelation(),
    dayRelation: toDayRelation(),
  );
  late final SABSymbolDetailModel hideSymbol = SABSymbolDetailModel(
    symbolHealthDes: hideSymbolHealthDes(),
    monthRelation: hideMonthRelation(),
    dayRelation: hideDayRelation(),
  );

  String hideSymbolHealthDes() {
    String stringResult = "";
    if ('用神' == this.stringDeity) {
      final stringHideHealth = healthModel().hideSymbol.stringHealth ?? '??';
      stringResult = wordsModel().getSymbolName(EasyTypeEnum.hide) +
          '[' +
          stringHideHealth +
          ']';
    } else {}
    return stringResult;
  }

  String fromSymbolHealthDes() {
    String stringResult = "";
    final stringFromHealth = healthModel().fromSymbol.stringHealth ??= '??';
    stringResult = wordsModel().getSymbolName(EasyTypeEnum.from) +
        '[' +
        stringFromHealth +
        ']';
    return stringResult;
  }

  String toSymbolHealthDes() {
    String stringResult = "";
    if (wordsModel().bMovement) {
      final stringToHealth = healthModel().toSymbol.stringHealth ?? '??';
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

  SABRowLogicDescriptionModel analysisModel() {
    return this.inputAnalysisRow;
  }

  SABRowHealthLogicModel healthLogicModel() {
    return this.inputAnalysisRow.healthLogicRow;
  }

  SABRowHealthModel healthModel() {
    return analysisModel().healthLogicRow.healthRow;
  }

  SABLogicRowModel logicModel() {
    return healthModel().inputLogicRow;
  }

  SABWordsRowModel wordsModel() {
    return logicModel().inputWordsRow;
  }

  List<Map> resultList = [
    {
      ///强弱、动静、四时
      'key': '基本信息',
      'value': '',
    },
    {
      'key': '六神类象',
      'value': '',
    },
    {
      'key': '地支类象',
      'value': '',
    },
    {
      'key': '六合',
      'value': '',
    },
    {
      'key': '月将',
      'value': '',
    },
    {
      'key': '日将',
      'value': '',
    },
    {
      'key': '地支方位',
      'value': '',
    },
    {
      'key': '所属八卦',
      'value': '',
    },
    {
      'key': '调试信息',
      'value': '日志',
    },
  ];
}
