import 'package:yourlucky/src/3L_Business/EasyLogic/SABRowHealthLogicModel.dart';
import 'package:yourlucky/src/3L_Business/EasyLogicDescription/SABSymbolLogicDescriptionModel.dart';

import '../../1L_Context/SACContext.dart';
import '../../1L_Context/SACGlobal.dart';
import '../EasyLogic/BaseLogic/SABRowLogicModel.dart';
import '../EasyWords/SABWordsRowModel.dart';

class SABRowLogicDescriptionModel {
  SABRowLogicDescriptionModel(
    this.healthLogicRow,
  );
  final SABRowHealthLogicModel healthLogicRow;

  late final SABSymbolLogicDescriptionModel fromSymbol =
      SABSymbolLogicDescriptionModel(
          inputHealthLogic: this.healthLogicRow.fromSymbol);
  late final SABSymbolLogicDescriptionModel toSymbol =
      SABSymbolLogicDescriptionModel(
          inputHealthLogic: this.healthLogicRow.toSymbol);
  late final SABSymbolLogicDescriptionModel hideSymbol =
      SABSymbolLogicDescriptionModel(
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
  SABRowLogicModel logicModel() {
    return this.healthLogicRow.healthRow.inputLogicRow;
  }

  SABWordsRowModel wordsModel() {
    return logicModel().inputWordsRow;
  }
}
