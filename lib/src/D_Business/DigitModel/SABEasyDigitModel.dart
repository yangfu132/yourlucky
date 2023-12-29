// import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:yourlucky/src/A_Context/SACContext.dart';
import 'package:yourlucky/src/A_Context/SACGlobal.dart';
import 'package:yourlucky/src/D_Business/Base/SABBaseModel.dart';
import 'package:yourlucky/src/D_Business/DigitModel/SABDigitDiagramsModel.dart';
import 'package:yourlucky/src/D_Business/Strategy/SABEasyStrategyInfoModel.dart';

///此Model仅代表占卜时所创造的数据；
class SABEasyDigitModel extends SABBaseModel {
  //构造函数
  SABEasyDigitModel({
    required this.modelId,
    required this.strEasyGoal,
    required this.strUsefulDeity,
    required this.listEasyData,
    required this.stringTime,
    this.strStrategy = SABEasyStrategyInfoModel.avoid,
    this.dataJson = '',
  });

  int? modelId;

  String dataJson;

  String strStrategy;

  //属性：实例的随机数数组
  final List<int> listEasyData;

  //属性：实例的发生目的
  String strEasyGoal = "";

  //属性：实例的用神
  final String strUsefulDeity;

  final String stringTime;

  late final SABDigitDiagramsModel diagramsModel = _getDiagramsModel();

  void check() {
    if (listEasyData.isEmpty) {
      coLog(StackTrace.current, LogTypeEnum.check, "listEasyData.isEmpty");
    }
    if (strEasyGoal.isEmpty) {
      coLog(StackTrace.current, LogTypeEnum.check, "strEasyGoal.isEmpty");
    }
    if (strUsefulDeity.isEmpty) {
      coLog(StackTrace.current, LogTypeEnum.check, "strUsefulDeity.isEmpty");
    }
    if (stringTime.isEmpty) {
      coLog(StackTrace.current, LogTypeEnum.check, "strUsefulDeity.isEmpty");
    }
    diagramsModel.check();
    super.check();
  }

  SABDigitDiagramsModel _getDiagramsModel() {
    return SABDigitDiagramsModel(
      fromEasyKey: _getFromEasyKey(listEasyData),
      toEasyKey: _getToEasyKey(listEasyData),
      strUsefulDeity: strUsefulDeity,
    );
  }

  String getModelName() {
    return 'easy';
  }

  int? getModelId() {
    return modelId;
  }

  String describe() {
    String stringDescribe;
    if (isMovement(listEasyData)) {
      stringDescribe =
          "${diagramsModel.stringFromName}(${diagramsModel.stringFromPlace})->${diagramsModel.stringToName}(${diagramsModel.stringToPlace})";
    } else {
      stringDescribe =
          "${diagramsModel.stringFromName}(${diagramsModel.stringFromPlace})";
    }
    return stringDescribe;
  }

  String title() {
    String stringTitle = '';
    if (strEasyGoal.length > 0) {
      stringTitle = stringTime + strEasyGoal;
    } else {
      stringTitle = stringTime + strUsefulDeity;
    }
    return stringTitle;
  }

  bool isMovement(List<int> listEasyData) {
    bool tempMovement = false;
    for (int intItem in listEasyData) {
      if (8 == intItem || 9 == intItem) {
        tempMovement = true;
        break;
      } //else continue
    } //end for
    return tempMovement;
  }

  String _getFromEasyKey(List<int> listEasyData) {
    String strFromKey = "";
    int nValue, nFromValue;
    for (int nIndex = 0; nIndex < 6; nIndex++) {
      nValue = listEasyData[nIndex];
      if (nValue == 8)
        nFromValue = 0;
      else if (nValue == 9)
        nFromValue = 1;
      else
        nFromValue = nValue;
      strFromKey = "$strFromKey$nFromValue";
    } //end for

    return strFromKey;
  }

  String _getToEasyKey(List<int> listEasyData) {
    String strToKey = "";
    int nValue, nFromValue;
    for (int nIndex = 0; nIndex < 6; nIndex++) {
      nValue = listEasyData[nIndex];
      if (nValue == 8)
        nFromValue = 1;
      else if (nValue == 9)
        nFromValue = 0;
      else
        nFromValue = nValue;
      strToKey = "$strToKey$nFromValue";
    } //end for

    return strToKey;
  }

  SABEasyDigitModel.fromJson(Map<String, Object?> json)
      : this(
          modelId: json['id'] as int,
          strEasyGoal: json['easyGoal']! as String,
          strUsefulDeity: json['usefulDeity']! as String,
          stringTime: json['time']! as String,
          strStrategy: json['strategy']! as String,
          dataJson: json['dataJson']! as String,
          listEasyData: (json['easy']! as String)
              .split(',')
              .map((e) => int.parse(e))
              .toList(),
        );

  Map<String, Object?> toJson() {
    return {
      'id': modelId,
      'easyGoal': strEasyGoal,
      'usefulDeity': strUsefulDeity,
      'time': stringTime,
      'strategy': strStrategy,
      'dataJson': dataJson,
      'easy': listEasyData.join(','),
    };
  }

  /// `public 函数`/////////////////////////////////////////////////////////////

  bool isInGua(int intRow) {
    return 0 <= intRow && intRow <= 3;
  }

  bool isOutGua(int intRow) {
    return 4 <= intRow && intRow <= 6;
  }

  /// `get and set函数`/////////////////////////////////////////////////////////

  ///此函数获取内卦变动的爻列表
  List inGuaMovementArray() {
    List inMovementArray = [];

    for (int intIndex = 3; intIndex < 6; intIndex++) {
      int intValue = listEasyData[intIndex];
      if (8 == intValue || 9 == intValue) {
        inMovementArray.add(intValue);
      }
      //else cont.
    } //end for

    return inMovementArray;
  }

  ///此函数获取外卦变动的爻列表
  List outGuaMovementArray() {
    List outMovementArray = [];
    for (int intIndex = 0; intIndex < 3; intIndex++) {
      int intValue = listEasyData[intIndex];

      if (8 == intValue || 9 == intValue) {
        outMovementArray.add(intValue);
      }
      //else cont.
    } //end for

    return outMovementArray;
  }

  bool isMovementAtRow(int nRow) {
    bool result = false;

    if (0 <= nRow && nRow < 6) {
      if (8 == listEasyData[nRow]) {
        result = true;
      } else if (9 == listEasyData[nRow]) {
        result = true;
      }
      //else cont.
    } else
      result = false;
    //CO_LOG(@"error!");

    return result;
  }

  int digitAtIndex(int intSymbolIndex) {
    return listEasyData[intSymbolIndex];
  }
}
