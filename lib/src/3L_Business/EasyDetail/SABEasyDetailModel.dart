import 'package:yourlucky/src/1L_Context/SACContext.dart';
import 'package:yourlucky/src/1L_Context/SACGlobal.dart';
import 'package:yourlucky/src/3L_Business/EasyLogic/SABEasyHealthLogicModel.dart';
import 'package:yourlucky/src/3L_Business/EasyWords/SABEasyWordsModel.dart';
import 'package:yourlucky/src/3L_Business/ExpertCategory/SABUsefulDeityModel.dart';

import '../EasyAnalysis/SABEasyAnalysisModel.dart';
import 'SABRowDetailModel.dart';

class SABEasyDetailModel {
  SABEasyDetailModel(this._analysisModel, this.stringDetailName);
  final SABEasyAnalysisModel _analysisModel;
  final String stringDetailName;
  late List _listRowModels = _initRowModelsArray();

  SABEasyWordsModel wordsModel() {
    return _analysisModel
        .inputHealthLogicModel.inputHealthModel.inputLogicModel.inputWordsModel;
  }

  SABEasyHealthLogicModel healthLogicModel() {
    return _analysisModel.inputHealthLogicModel;
  }

  List<List<String>> staticHaveUsefulDeity() {
    final listResult = <List<String>>[
      [
        '事情',
        '六神',
        '六爻冲合',
        wordsModel().monthSkyEarth(),
        wordsModel().daySkyEarth(),
        "本:${wordsModel().fromEasyName()}",
        "世应",
      ]
    ];

    for (SABRowDetailModel rowModel in _rowModelsArray()) {
      final listItem = <String>[
        rowModel.stringDeity,
        rowModel.stringAnimal,
        rowModel.stringConflictOrPair,
        rowModel.stringFromMonthR,
        rowModel.stringFromDayR,
        rowModel.stringFromEasySymbolH,
        rowModel.stringGoal,
      ];
      listResult.add(listItem);
    }
    return listResult;
  }

  List<List<String>> staticHideUsefulDeity() {
    final listResult = <List<String>>[
      [
        "月",
        "日",
        "伏神",
        '事情',
        '六神',
        '六爻冲合',
        wordsModel().monthSkyEarth(),
        wordsModel().daySkyEarth(),
        "本:${wordsModel().fromEasyName()}",
        "世应",
      ]
    ];

    for (SABRowDetailModel rowModel in _rowModelsArray()) {
      final listItem = <String>[
        rowModel.stringHideMonthR,
        rowModel.stringHideDayR,
        rowModel.stringHideSymbolH,
        rowModel.stringDeity,
        rowModel.stringAnimal,
        rowModel.stringConflictOrPair,
        rowModel.stringFromMonthR,
        rowModel.stringFromDayR,
        rowModel.stringFromEasySymbolH,
        rowModel.stringGoal,
      ];
      listResult.add(listItem);
    }
    return listResult;
  }

  List<List<String>> moveHaveUsefulDeity() {
    final listResult = <List<String>>[
      [
        '事情',
        '六神',
        '六爻冲合',
        wordsModel().monthSkyEarth(),
        wordsModel().daySkyEarth(),
        "本:${wordsModel().fromEasyName()}",
        "世应",
        '进化',
        '变:${wordsModel().toEasyName()}',
        '${wordsModel().monthSkyEarth()}',
        '${wordsModel().daySkyEarth()}',
      ]
    ];

    for (SABRowDetailModel rowModel in _rowModelsArray()) {
      final listItem = <String>[
        rowModel.stringDeity,
        rowModel.stringAnimal,
        rowModel.stringConflictOrPair,
        rowModel.stringFromMonthR,
        rowModel.stringFromDayR,
        rowModel.stringFromEasySymbolH,
        rowModel.stringGoal,
        rowModel.logicModel().stringSymbolForwardOrBack,
        rowModel.stringToEasySymbolH,
        rowModel.stringToMonthR,
        rowModel.stringToDayR,
      ];
      listResult.add(listItem);
    }
    return listResult;
  }

  List<List<String>> moveHideUsefulDeity() {
    final listResult = <List<String>>[
      [
        "月",
        "日",
        "伏神",
        '事情',
        '六神',
        '六爻冲合',
        wordsModel().monthSkyEarth(),
        wordsModel().daySkyEarth(),
        "本:${wordsModel().fromEasyName()}",
        "世应",
        '进化',
        '变:${wordsModel().toEasyName()}',
        '${wordsModel().monthSkyEarth()}',
        '${wordsModel().daySkyEarth()}',
      ]
    ];

    for (SABRowDetailModel rowModel in _rowModelsArray()) {
      final listItem = <String>[
        rowModel.stringHideMonthR,
        rowModel.stringHideDayR,
        rowModel.stringHideSymbolH,
        rowModel.stringDeity,
        rowModel.stringAnimal,
        rowModel.stringConflictOrPair,
        rowModel.stringFromMonthR,
        rowModel.stringFromDayR,
        rowModel.stringFromEasySymbolH,
        rowModel.stringGoal,
        rowModel.logicModel().stringSymbolForwardOrBack,
        rowModel.stringToEasySymbolH,
        rowModel.stringToMonthR,
        rowModel.stringToDayR,
      ];
      listResult.add(listItem);
    }
    return listResult;
  }

  List<List<String>> detailList() {
    List<List<String>> listResult;
    SABUsefulDeityModel usefulDeity = healthLogicModel().usefulDeity;
    bool bStaticEasy =
        healthLogicModel().inputHealthModel.inputLogicModel.bStaticEasy;
    if (bStaticEasy) {
      if (EasyTypeEnum.from == usefulDeity.easyType) {
        listResult = staticHaveUsefulDeity();
      } else if (EasyTypeEnum.type_null == usefulDeity.easyType) {
        listResult = staticHaveUsefulDeity();
      } else {
        listResult = staticHideUsefulDeity();
      }
    } else {
      if (EasyTypeEnum.from == usefulDeity.easyType) {
        listResult = moveHaveUsefulDeity();
      } else if (EasyTypeEnum.type_null == usefulDeity.easyType) {
        listResult = moveHaveUsefulDeity();
      } else {
        listResult = moveHideUsefulDeity();
      }
    }
    return listResult;
  }

  /// `加载函数`/////////////////////////////////////////////////////////////////
  List _rowModelsArray() {
    return _listRowModels;
  }

  List _initRowModelsArray() {
    var listRowModels = [];
    for (int intRow = 0; intRow < 6; intRow++) {
      SABRowDetailModel model =
          SABRowDetailModel(_analysisModel.rowModelAtRow(intRow));
      listRowModels.add(model);
    }

    return listRowModels;
  }

  SABRowDetailModel rowModelAtRow(int intRow) {
    if (intRow > _listRowModels.length) {
      colog("intRow:$intRow");
    }
    return _rowModelsArray()[intRow];
  }
}
