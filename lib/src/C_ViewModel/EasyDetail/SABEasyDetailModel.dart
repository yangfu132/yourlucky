import 'package:yourlucky/src/A_Context/SACContext.dart';
import 'package:yourlucky/src/A_Context/SACGlobal.dart';
import 'package:yourlucky/src/D_Business/Base/SABBaseModel.dart';
import 'package:yourlucky/src/D_Business/DigitModel/SABEasyDigitModel.dart';
import 'package:yourlucky/src/D_Business/EasyLogic/SABEasyHealthLogicModel.dart';
import 'package:yourlucky/src/D_Business/EasyWords/SABEasyWordsModel.dart';
import 'package:yourlucky/src/D_Business/Strategy/SABUsefulDeityModel.dart';

import '../EasyAnalysis/SABEasyAnalysisModel.dart';
import 'SABDiagramsDetailModel.dart';
import 'SABRowDetailModel.dart';

class SABEasyDetailModel extends SABBaseModel {
  SABEasyDetailModel(
      this._analysisModel, this.stringDetailName, this.diagramsDetailModel);
  final SABDiagramsDetailModel diagramsDetailModel;
  final SABEasyAnalysisModel _analysisModel;
  final String stringDetailName;
  late List<SABRowDetailModel> _listRowModels = _initRowModelsArray();

  void check() {
    diagramsDetailModel.check();
    _analysisModel.check();
    for (SABRowDetailModel row in _listRowModels) {
      row.check();
    }
    if (stringDetailName.isEmpty) {
      coLog(StackTrace.current, LogTypeEnum.check, "stringDetailName.isEmpty");
    }
    super.check();
  }

  SABEasyDigitModel digitModel() {
    return wordsModel().inputDigitModel;
  }

  SABEasyWordsModel wordsModel() {
    return _analysisModel
        .inputHealthLogicModel.inputHealthModel.inputLogicModel.inputWordsModel;
  }

  SABEasyHealthLogicModel healthLogicModel() {
    return _analysisModel.inputHealthLogicModel;
  }

  Map<String, List> staticHaveUsefulDeity() {
    final listResult = <List<String>>[
      [
        '事情',
        '六神',
        '六爻冲合',
        wordsModel().monthSkyEarth(),
        wordsModel().daySkyEarth(),
        "本:${wordsModel().getFromEasyName()}",
        "世应",
      ]
    ];

    for (SABRowDetailModel rowModel in _rowModelsArray()) {
      final listItem = <String>[
        rowModel.stringDeity,
        rowModel.stringAnimal,
        rowModel.stringConflictOrPair,
        rowModel.fromSymbol.monthRelation,
        rowModel.fromSymbol.dayRelation,
        rowModel.fromSymbol.symbolHealthDes,
        rowModel.stringGoal,
      ];
      listResult.add(listItem);
    }

    final mapResult = <String, List>{
      "key": <String>[
        '事情',
        '六神',
        '六爻冲合',
        '本月',
        '本日',
        '本卦',
        '世应',
      ],
      "value": listResult
    };
    return mapResult;
  }

  Map<String, List> staticHideUsefulDeity() {
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
        "本:${wordsModel().getFromEasyName()}",
        "世应",
      ]
    ];

    for (SABRowDetailModel rowModel in _rowModelsArray()) {
      final listItem = <String>[
        rowModel.hideSymbol.monthRelation,
        rowModel.hideSymbol.dayRelation,
        rowModel.hideSymbol.symbolHealthDes,
        rowModel.stringDeity,
        rowModel.stringAnimal,
        rowModel.stringConflictOrPair,
        rowModel.fromSymbol.monthRelation,
        rowModel.fromSymbol.dayRelation,
        rowModel.fromSymbol.symbolHealthDes,
        rowModel.stringGoal,
      ];
      listResult.add(listItem);
    }

    final mapResult = <String, List>{
      "key": <String>[
        '伏月',
        '伏日',
        '伏卦',
        '事情',
        '六神',
        '六爻冲合',
        '本月',
        '本日',
        '本卦',
        '世应',
      ],
      "value": listResult
    };
    return mapResult;
  }

  Map<String, List> moveHaveUsefulDeity() {
    final listResult = <List<String>>[
      [
        '事情',
        '六神',
        '六爻冲合',
        wordsModel().monthSkyEarth(),
        wordsModel().daySkyEarth(),
        "本:${wordsModel().getFromEasyName()}",
        "世应",
        '进化',
        '变:${wordsModel().getToEasyName()}',
        '${wordsModel().monthSkyEarth()}',
        '${wordsModel().daySkyEarth()}',
      ]
    ];

    for (SABRowDetailModel rowModel in _rowModelsArray()) {
      final listItem = <String>[
        rowModel.stringDeity,
        rowModel.stringAnimal,
        rowModel.stringConflictOrPair,
        rowModel.fromSymbol.monthRelation,
        rowModel.fromSymbol.dayRelation,
        rowModel.fromSymbol.symbolHealthDes,
        rowModel.stringGoal,
        rowModel.logicModel().stringSymbolForwardOrBack,
        rowModel.toSymbol.symbolHealthDes,
        rowModel.toSymbol.monthRelation,
        rowModel.toSymbol.dayRelation,
      ];
      listResult.add(listItem);
    }
    final mapResult = <String, List>{
      "key": <String>[
        '事情',
        '六神',
        '六爻冲合',
        '本月',
        '本日',
        '本卦',
        '世应',
        '进化',
        '变卦',
        '变月',
        '变日'
      ],
      "value": listResult
    };
    return mapResult;
  }

  Map<String, List> moveHideUsefulDeity() {
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
        "本:${wordsModel().getFromEasyName()}",
        "世应",
        '进化',
        '变:${wordsModel().getToEasyName()}',
        '${wordsModel().monthSkyEarth()}',
        '${wordsModel().daySkyEarth()}',
      ]
    ];

    for (SABRowDetailModel rowModel in _rowModelsArray()) {
      final listItem = <String>[
        rowModel.hideSymbol.monthRelation, //stringHideMonthR,
        rowModel.hideSymbol.dayRelation, //stringHideDayR,
        rowModel.hideSymbol.symbolHealthDes, //stringHideSymbolH,
        rowModel.stringDeity,
        rowModel.stringAnimal,
        rowModel.stringConflictOrPair,
        rowModel.fromSymbol.monthRelation, //stringFromMonthR,
        rowModel.fromSymbol.dayRelation, //stringFromDayR,
        rowModel.fromSymbol.symbolHealthDes, //stringFromEasySymbolH,
        rowModel.stringGoal,
        rowModel.logicModel().stringSymbolForwardOrBack,
        rowModel.toSymbol.symbolHealthDes, // stringToEasySymbolH,
        rowModel.toSymbol.monthRelation, //stringToMonthR,
        rowModel.toSymbol.dayRelation, //stringToDayR,
      ];
      listResult.add(listItem);
    }
    final mapResult = <String, List>{
      "key": <String>[
        '伏月',
        '伏日',
        '伏卦',
        '事情',
        '六神',
        '六爻冲合',
        '本月',
        '本日',
        '本卦',
        '世应',
        '进化',
        '变卦',
        '变月',
        '变日'
      ],
      "value": listResult
    };
    return mapResult;
  }

  Map<String, List> detailList() {
    Map<String, List> mapResult;
    SABUsefulDeityModel usefulDeity = healthLogicModel().usefulDeity;
    bool bStaticEasy = healthLogicModel()
        .inputHealthModel
        .inputLogicModel
        .diagramsModel
        .bStaticEasy;
    if (bStaticEasy) {
      if (EasyTypeEnum.from == usefulDeity.easyType) {
        mapResult = staticHaveUsefulDeity();
      } else if (EasyTypeEnum.type_null == usefulDeity.easyType) {
        mapResult = staticHaveUsefulDeity();
      } else {
        mapResult = staticHideUsefulDeity();
      }
    } else {
      if (EasyTypeEnum.from == usefulDeity.easyType) {
        mapResult = moveHaveUsefulDeity();
      } else if (EasyTypeEnum.type_null == usefulDeity.easyType) {
        mapResult = moveHaveUsefulDeity();
      } else {
        mapResult = moveHideUsefulDeity();
      }
    }
    return mapResult;
  }

  void rowDetailList(int intRow) {}

  /// `加载函数`/////////////////////////////////////////////////////////////////
  List _rowModelsArray() {
    return _listRowModels;
  }

  List<SABRowDetailModel> _initRowModelsArray() {
    var listRowModels = <SABRowDetailModel>[];
    for (int intRow = 0; intRow < 6; intRow++) {
      SABRowDetailModel model =
          SABRowDetailModel(_analysisModel.rowModelAtRow(intRow));
      listRowModels.add(model);
    }

    return listRowModels;
  }

  SABRowDetailModel rowModelAtRow(int intRow) {
    if (intRow > _listRowModels.length) {
      coLog(StackTrace.current, LogTypeEnum.error, "intRow:$intRow");
    }
    return _rowModelsArray()[intRow];
  }
}
