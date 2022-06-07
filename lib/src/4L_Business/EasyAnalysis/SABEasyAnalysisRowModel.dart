import 'package:yourlucky/src/4L_Business/Base/SABBaseModel.dart';
import 'package:yourlucky/src/4L_Business/EasyAnalysis/SABEasyAnalysisSymbolModel.dart';
import 'package:yourlucky/src/4L_Business/EasyLogic/SABHealthLogicRowModel.dart';

import '../../1L_Context/SACContext.dart';
import '../../1L_Context/SACGlobal.dart';
import '../EasyLogic/BaseLogic/SABLogicRowModel.dart';
import '../EasyWords/SABWordsRowModel.dart';

class SABEasyAnalysisRowModel extends SABBaseModel {
  SABEasyAnalysisRowModel(
    this.healthLogicRow,
  );
  final SABHealthLogicRowModel healthLogicRow;

  late final SABEasyAnalysisSymbolModel fromSymbol = SABEasyAnalysisSymbolModel(
      inputHealthLogic: this.healthLogicRow.fromSymbol);
  late final SABEasyAnalysisSymbolModel toSymbol = SABEasyAnalysisSymbolModel(
      inputHealthLogic: this.healthLogicRow.toSymbol);
  late final SABEasyAnalysisSymbolModel hideSymbol = SABEasyAnalysisSymbolModel(
      inputHealthLogic: this.healthLogicRow.hideSymbol);

  String _symbolRelation = '';

  late String movementDescription;

  String getDayRelation(EasyTypeEnum easyTypeEnum) {
    if (easyTypeEnum == EasyTypeEnum.from) {
      return fromSymbol.dayRelation;
    } else if (easyTypeEnum == EasyTypeEnum.to) {
      return toSymbol.dayRelation;
    } else if (easyTypeEnum == EasyTypeEnum.hide) {
      return hideSymbol.dayRelation;
    } else {
      coLog('easyTypeEnum:$easyTypeEnum');
      return 'easyTypeEnum:$easyTypeEnum';
    }
  }

  void setDayRelation(EasyTypeEnum easyTypeEnum, String stringDayRelation) {
    if (easyTypeEnum == EasyTypeEnum.from) {
      fromSymbol.dayRelation = stringDayRelation;
    } else if (easyTypeEnum == EasyTypeEnum.to) {
      toSymbol.dayRelation = stringDayRelation;
    } else if (easyTypeEnum == EasyTypeEnum.hide) {
      hideSymbol.dayRelation = stringDayRelation;
    } else
      coLog('easyTypeEnum:$easyTypeEnum');
  }

  String getSymbolRelation() {
    return _symbolRelation;
  }

  void setSymbolRelation(String stringSymbolRelation) {
    _symbolRelation = stringSymbolRelation;
  }

  String getMonthRelation(EasyTypeEnum easyTypeEnum) {
    if (easyTypeEnum == EasyTypeEnum.from) {
      return fromSymbol.monthRelation;
    } else if (easyTypeEnum == EasyTypeEnum.to) {
      return toSymbol.monthRelation;
    } else if (easyTypeEnum == EasyTypeEnum.hide) {
      return hideSymbol.monthRelation;
    } else {
      coLog('easyTypeEnum:$easyTypeEnum');
      return 'easyTypeEnum:$easyTypeEnum';
    }
  }

  void setMonthRelation(EasyTypeEnum easyTypeEnum, String stringMonthRelation) {
    if (easyTypeEnum == EasyTypeEnum.from) {
      fromSymbol.monthRelation = stringMonthRelation;
    } else if (easyTypeEnum == EasyTypeEnum.to) {
      toSymbol.monthRelation = stringMonthRelation;
    } else if (easyTypeEnum == EasyTypeEnum.hide) {
      hideSymbol.monthRelation = stringMonthRelation;
    } else
      coLog('easyTypeEnum:$easyTypeEnum');
  }

  String getEmptyDescription(EasyTypeEnum easyTypeEnum) {
    if (easyTypeEnum == EasyTypeEnum.from) {
      return fromSymbol.emptyDescription;
    } else if (easyTypeEnum == EasyTypeEnum.to) {
      return toSymbol.emptyDescription;
    } else if (easyTypeEnum == EasyTypeEnum.hide) {
      return hideSymbol.emptyDescription;
    } else {
      coLog('easyTypeEnum:$easyTypeEnum');
      return 'easyTypeEnum:$easyTypeEnum';
    }
  }

  void setEmptyDescription(EasyTypeEnum easyTypeEnum, String emptyDescription) {
    if (easyTypeEnum == EasyTypeEnum.from) {
      fromSymbol.emptyDescription = emptyDescription;
    } else if (easyTypeEnum == EasyTypeEnum.to) {
      toSymbol.emptyDescription = emptyDescription;
    } else if (easyTypeEnum == EasyTypeEnum.hide) {
      hideSymbol.emptyDescription = emptyDescription;
    } else
      coLog('easyTypeEnum:$easyTypeEnum');
  }

  /// `加载函数`/////////////////////////////////////////////////////////////////
  SABLogicRowModel logicModel() {
    return this.healthLogicRow.healthRow.inputLogicRow;
  }

  SABWordsRowModel wordsModel() {
    return logicModel().inputWordsRow;
  }
}
