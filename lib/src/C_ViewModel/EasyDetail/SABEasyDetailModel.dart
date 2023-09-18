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
  final List<SABRowDetailModel> _listRowModels = List<SABRowDetailModel>.empty(growable: true);

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

  List<String> addHideSymbolDes(SABRowDetailModel rowModel) {
    List<String> valueItem = List<String>.empty(growable: true);
    if (rowModel.stringDeity == '用神') {
      valueItem.add(rowModel.hideSymbol.monthRelation);
      valueItem.add(rowModel.hideSymbol.dayRelation);
      valueItem.add(rowModel.hideSymbol.symbolHealthDes);
    } else {
      valueItem.add('');
      valueItem.add('');
      valueItem.add('');
      valueItem.add('');
    }
    return valueItem;
  }

  List<String> addToSymbolDes(SABRowDetailModel rowModel) {
    List<String> valueItem = List<String>.empty(growable: true);
    if (rowModel.logicModel().inputWordsRow.bMovement) {
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
        '${wordsModel().monthSkyEarth()}',
        '${wordsModel().daySkyEarth()}',
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
      List<String> valueItem = List<String>.empty(growable: true);
      valueItem.addAll(addHideSymbolDes(rowModel));
      valueItem.addAll(addFromSymbolDes(rowModel));
      valueItem.addAll(addToSymbolDes(rowModel));
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
}
