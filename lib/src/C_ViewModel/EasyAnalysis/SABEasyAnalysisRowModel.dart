import 'package:yourlucky/src/D_Business/Base/SABBaseModel.dart';
import 'package:yourlucky/src/D_Business/EasyLogic/BaseLogic/SABLogicRowModel.dart';
import 'package:yourlucky/src/D_Business/EasyLogic/SABHealthLogicRowModel.dart';
import 'package:yourlucky/src/D_Business/EasyWords/SABWordsRowModel.dart';

import '../../A_Context/SACContext.dart';
import '../../A_Context/SACGlobal.dart';
import 'SABEasyAnalysisSymbolModel.dart';

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
      coLog(StackTrace.current,LogTypeEnum.error,'easyTypeEnum:$easyTypeEnum');
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
    } else {
      coLog(StackTrace.current,LogTypeEnum.error, 'easyTypeEnum:$easyTypeEnum');
    }
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
      coLog(StackTrace.current,LogTypeEnum.error,'easyTypeEnum:$easyTypeEnum');
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
    } else {
      coLog(StackTrace.current,LogTypeEnum.error, 'easyTypeEnum:$easyTypeEnum');
    }
  }

  String getEmptyDescription(EasyTypeEnum easyTypeEnum) {
    if (easyTypeEnum == EasyTypeEnum.from) {
      return fromSymbol.emptyDescription;
    } else if (easyTypeEnum == EasyTypeEnum.to) {
      return toSymbol.emptyDescription;
    } else if (easyTypeEnum == EasyTypeEnum.hide) {
      return hideSymbol.emptyDescription;
    } else {
      coLog(StackTrace.current,LogTypeEnum.error,'easyTypeEnum:$easyTypeEnum');
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
    } else {
      coLog(StackTrace.current,LogTypeEnum.error,'easyTypeEnum:$easyTypeEnum');
    }
  }

  /// `加载函数`/////////////////////////////////////////////////////////////////
  SABLogicRowModel logicModel() {
    return this.healthLogicRow.healthRow.inputLogicRow;
  }

  SABWordsRowModel wordsModel() {
    return logicModel().inputWordsRow;
  }
}
