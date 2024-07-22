import 'package:your_lucky/src/A_Context/sac_context.dart';
import 'package:your_lucky/src/A_Context/sac_global.dart';
import 'package:your_lucky/src/D_Business/Base/sab_base_model.dart';
import 'package:your_lucky/src/D_Business/DigitModel/sab_easy_digit_model.dart';
import 'package:your_lucky/src/D_Business/EasyLogic/BaseLogic/sab_easy_logic_model.dart';
import 'package:your_lucky/src/D_Business/EasyLogic/Health/sab_health_model.dart';
import 'package:your_lucky/src/D_Business/EasyLogic/sab_easy_health_logic_model.dart';
import 'package:your_lucky/src/D_Business/EasyWords/sab_easy_words_model.dart';
import 'package:your_lucky/src/D_Business/Strategy/sab_useful_deity_model.dart';

import '../EasyAnalysis/sab_easy_analysis_model.dart';
import 'sab_diagrams_detail_model.dart';
import 'sab_row_detail_model.dart';
import 'sab_symbol_detail_model.dart';

class SABEasyDetailModel extends SABBaseModel {
  SABEasyDetailModel(
      this._analysisModel,
      this.stringDetailName,
      this.diagramsDetailModel,
      this.monthModel,
      this.dayModel,
      );
  final SABDiagramsDetailModel diagramsDetailModel;
  final SABEasyAnalysisModel _analysisModel;
  final String stringDetailName;
  final List<SABRowDetailModel> _listRowModels = List<SABRowDetailModel>.empty(growable: true);
  final SABSymbolDetailModel monthModel;
  final SABSymbolDetailModel dayModel;
  @override void check() {
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

  SABEasyHealthLogicModel healthLogicModel() {
    return _analysisModel.inputHealthLogicModel;
  }

  SABHealthModel healthModel() {
    return healthLogicModel().inputHealthModel;
  }

  SABEasyLogicModel logicModel() {
    return healthModel().inputLogicModel;
  }

  SABEasyWordsModel wordsModel() {
    return logicModel().inputWordsModel;
  }

  SABEasyDigitModel digitModel() {
    return wordsModel().inputDigitModel;
  }

  List<String> addHideSymbolDes(SABRowDetailModel rowModel) {
    List<String> valueItem = List<String>.empty(growable: true);
    if (rowModel.stringDeity == '伏神') {
      valueItem.add(rowModel.hideSymbol.monthRelation);
      valueItem.add(rowModel.hideSymbol.dayRelation);
      valueItem.add(rowModel.hideSymbol.symbolHealthDes);
    } else {
      valueItem.add('');
      valueItem.add('');
      valueItem.add('');
    }
    return valueItem;
  }

  List<String> addToSymbolDes(SABRowDetailModel rowModel) {
    List<String> valueItem = List<String>.empty(growable: true);
    if (rowModel.logicModel().inputWordsRow.isMovement()) {
      valueItem.add(rowModel.logicModel().stringSymbolForwardOrBack);
      valueItem.add(rowModel.toSymbol.symbolHealthDes);
      valueItem.add(rowModel.toSymbol.monthRelation);
      valueItem.add(rowModel.toSymbol.dayRelation);
    } else {
      valueItem.add('');
      valueItem.add('');
      valueItem.add('');
      valueItem.add('');
    }
    return valueItem;
  }

  List<String> addFromSymbolDes(SABRowDetailModel rowModel){
    List<String> valueItem = List<String>.empty(growable: true);
    valueItem.add(rowModel.stringDeity);
    valueItem.add(rowModel.stringAnimal);
    valueItem.add(rowModel.stringConflictOrPair);
    valueItem.add(rowModel.fromSymbol.monthRelation);
    valueItem.add(rowModel.fromSymbol.dayRelation);
    valueItem.add(rowModel.fromSymbol.symbolHealthDes);
    valueItem.add(rowModel.stringGoal);
    return valueItem;
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
      List<String> valueItem = List<String>.empty(growable: true);
      valueItem.addAll(addFromSymbolDes(rowModel));
      listResult.add(valueItem);
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
      List<String> valueItem = List<String>.empty(growable: true);
      valueItem.addAll(addHideSymbolDes(rowModel));
      valueItem.addAll(addFromSymbolDes(rowModel));
      listResult.add(valueItem);
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
        (wordsModel().monthSkyEarth()),
        (wordsModel().daySkyEarth()),
      ]
    ];

    for (SABRowDetailModel rowModel in _rowModelsArray()) {
      List<String> valueItem = List<String>.empty(growable: true);
      valueItem.addAll(addFromSymbolDes(rowModel));
      valueItem.addAll(addToSymbolDes(rowModel));
      listResult.add(valueItem);
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
    final listResult = <List<String>>[];

    final listTitle = <String>[
    "伏月",
    "伏日",
    "【】伏神【】",
    '事情',
    '六神',
    '六爻冲合',
    wordsModel().monthSkyEarth(),
    wordsModel().daySkyEarth(),
    "本:${wordsModel().getFromEasyName()}",
    "世应",
    '进化',
    '变:${wordsModel().getToEasyName()}',
    (wordsModel().monthSkyEarth()),
    (wordsModel().daySkyEarth()),
    ];
    listResult.add(listTitle);

    for (SABRowDetailModel rowModel in _rowModelsArray()) {
      List<String> valueItem = List<String>.empty(growable: true);
      valueItem.addAll(addHideSymbolDes(rowModel));
      valueItem.addAll(addFromSymbolDes(rowModel));
      valueItem.addAll(addToSymbolDes(rowModel));
      listResult.add(valueItem);
    }
    final listKey =  <String>[
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
    ];

    final mapResult = <String, List>{
      "key":listKey,
      "value": listResult
    };
    return mapResult;
  }

  Map<String, List> detailList() {
    Map<String, List> mapResult;
    SABUsefulDeityModel usefulDeity = getUsefulDeity();
    bool bStaticEasy = healthLogicModel()
        .inputHealthModel
        .inputLogicModel
        .diagramsModel
        .bStaticEasy;
    if (bStaticEasy) {
      if (EasyTypeEnum.from == usefulDeity.easyType) {
        mapResult = staticHaveUsefulDeity();
      } else if (EasyTypeEnum.typeNull == usefulDeity.easyType) {
        mapResult = staticHaveUsefulDeity();
      } else {
        mapResult = staticHideUsefulDeity();
      }
    } else {
      if (EasyTypeEnum.from == usefulDeity.easyType) {
        mapResult = moveHaveUsefulDeity();
      } else if (EasyTypeEnum.typeNull == usefulDeity.easyType) {
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
  //
  // List<SABRowDetailModel> _initRowModelsArray() {
  //   var listRowModels = <SABRowDetailModel>[];
  //   for (int intRow = 0; intRow < 6; intRow++) {
  //     SABRowDetailModel model =
  //         SABRowDetailModel(_analysisModel.rowModelAtRow(intRow));
  //     listRowModels.add(model);
  //   }
  //
  //   return listRowModels;
  // }

  void addRow(SABRowDetailModel detailRow){
    _listRowModels.add(detailRow);
  }

  SABRowDetailModel rowModelAtRow(int intRow) {
    if (intRow > _listRowModels.length) {
      coLog(StackTrace.current, LogTypeEnum.error, "intRow:$intRow");
    }

    return _rowModelsArray()[intRow];
  }

  SABUsefulDeityModel getUsefulDeity() {
    return healthLogicModel().usefulDeity;
  }
}
