import 'package:yourlucky/src/3L_Business/HealthLogic/SABRowHealthLogicModel.dart';

import '../../1L_Context/SACContext.dart';
import '../../1L_Context/SACGlobal.dart';
import '../Easy/SABRowWordsModel.dart';
import '../HealthLogic/Logic/SABRowLogicModel.dart';

class SABRowAnalysisModel {
  SABRowAnalysisModel(
    this.healthLogicRow,
  );
  final SABRowHealthLogicModel healthLogicRow;

  ///{
  ///monthRelation
  ///dayRelation
  ///symbolRelation
  ///}
  Map mapSymbolFrom = {};
  Map mapSymbolTo = {};
  Map mapSymbolHide = {};

  String getDayRelation(EasyTypeEnum easyTypeEnum) {
    if (easyTypeEnum == EasyTypeEnum.from) {
      return mapSymbolFrom['dayRelation'];
    } else if (easyTypeEnum == EasyTypeEnum.to) {
      return mapSymbolTo['dayRelation'];
    } else if (easyTypeEnum == EasyTypeEnum.hide) {
      return mapSymbolHide['dayRelation'];
    } else {
      colog('easyTypeEnum:$easyTypeEnum');
      return 'easyTypeEnum:$easyTypeEnum';
    }
  }

  void setDayRelation(EasyTypeEnum easyTypeEnum, String stringDayRelation) {
    if (easyTypeEnum == EasyTypeEnum.from) {
      mapSymbolFrom['dayRelation'] = stringDayRelation;
    } else if (easyTypeEnum == EasyTypeEnum.to) {
      mapSymbolTo['dayRelation'] = stringDayRelation;
    } else if (easyTypeEnum == EasyTypeEnum.hide) {
      mapSymbolHide['dayRelation'] = stringDayRelation;
    } else
      colog('easyTypeEnum:$easyTypeEnum');
  }

  String getSymbolRelation() {
    return mapSymbolFrom['symbolRelation'];
  }

  void setSymbolRelation(String stringSymbolRelation) {
    mapSymbolFrom['symbolRelation'] = stringSymbolRelation;
  }

  String getMonthRelation(EasyTypeEnum easyTypeEnum) {
    if (easyTypeEnum == EasyTypeEnum.from) {
      return mapSymbolFrom['monthRelation'];
    } else if (easyTypeEnum == EasyTypeEnum.to) {
      return mapSymbolTo['monthRelation'];
    } else if (easyTypeEnum == EasyTypeEnum.hide) {
      return mapSymbolHide['monthRelation'];
    } else {
      colog('easyTypeEnum:$easyTypeEnum');
      return 'easyTypeEnum:$easyTypeEnum';
    }
  }

  void setMonthRelation(EasyTypeEnum easyTypeEnum, String stringMonthRelation) {
    if (easyTypeEnum == EasyTypeEnum.from) {
      mapSymbolFrom['monthRelation'] = stringMonthRelation;
    } else if (easyTypeEnum == EasyTypeEnum.to) {
      mapSymbolTo['monthRelation'] = stringMonthRelation;
    } else if (easyTypeEnum == EasyTypeEnum.hide) {
      mapSymbolHide['monthRelation'] = stringMonthRelation;
    } else
      colog('easyTypeEnum:$easyTypeEnum');
  }

  /// `加载函数`/////////////////////////////////////////////////////////////////
  SABRowLogicModel logicModel() {
    return this.healthLogicRow.healthRow.inputLogicRow;
  }

  SABRowWordsModel wordsModel() {
    return logicModel().inputWordsRow;
  }
}
