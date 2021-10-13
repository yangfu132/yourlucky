import 'package:yourlucky/src/3L_Business/EasyLogic/SABRowHealthLogicModel.dart';

import '../../1L_Context/SACGlobal.dart';
import '../EasyLogic/BaseLogic/SABRowLogicModel.dart';
import '../EasyLogic/Health/SABRowHealthModel.dart';
import '../EasyLogicDescription/SABRowLogicDescriptionModel.dart';
import '../EasyWords/SABRowWordsModel.dart';

class SABRowDetailModel {
  SABRowDetailModel(this.inputAnalysisRow);

  List<Map> resultList = [
    {
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
      'key': '四时',
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
  ];

  final SABRowLogicDescriptionModel inputAnalysisRow;

  late final String stringDeity =
      healthLogicModel().getDeity(EasyTypeEnum.from); //事情

  late final String stringAnimal = wordsModel().stringAnimal; //六神

  ///Hide
  late final String stringHideSymbolH = hideSymbolHealthDes();

  late final String stringHideMonthR = hideMonthRelation();

  late final String stringHideDayR = hideDayRelation();

  late final String stringConflictOrPair =
      analysisModel().getSymbolRelation(); //六爻冲合

  ///from
  late final String stringFromMonthR =
      analysisModel().getMonthRelation(EasyTypeEnum.from);

  late final String stringFromDayR =
      analysisModel().getDayRelation(EasyTypeEnum.from);

  late final String stringFromEasySymbolH = fromSymbolHealthDes();

  late final String stringGoal = wordsModel().desOfGoalOrLife; //世应

  late final String stringChange = logicModel().stringSymbolForwardOrBack; //进化

  ///to
  late final String stringToEasySymbolH = toSymbolHealthDes();
  late final String stringToMonthR = toMonthRelation();
  late final String stringToDayR = toDayRelation();

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

  SABRowLogicModel logicModel() {
    return healthModel().inputLogicRow;
  }

  SABRowWordsModel wordsModel() {
    return logicModel().inputWordsRow;
  }
}
