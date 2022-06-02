// import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:yourlucky/src/3L_Business/Diagrams/SABDiagramsModel.dart';

///此Model仅代表占卜时所创造的数据；
class SABEasyDigitModel {
  //构造函数
  SABEasyDigitModel({
    required this.strEasyGoal,
    required this.strUsefulDeity,
    required this.easyDateTime,
    required this.listEasyData,
    required this.stringFormatTime,
  });

  //属性：实例发生时间
  final DateTime easyDateTime;

  //属性：实例的随机数数组
  final List<int> listEasyData;

  //属性：实例的发生目的
  final String strEasyGoal;

  //属性：实例的用神
  final String strUsefulDeity;

  final String stringFormatTime;

  late String stringDescribe = describe();

  late final String fromEasyKey = _getFromEasyKey(listEasyData);

  late final String toEasyKey = _getToEasyKey(listEasyData);

  late final SABDiagramsModel diagramsModel = _getDiagramsModel();

  SABDiagramsModel _getDiagramsModel() {
    return SABDiagramsModel(
      fromEasyKey: fromEasyKey,
      toEasyKey: toEasyKey,
    );
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
      stringTitle = stringFormatTime + strEasyGoal;
    } else {
      stringTitle = stringFormatTime + strUsefulDeity;
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
          strEasyGoal: json['easyGoal']! as String,
          strUsefulDeity: json['usefulDeity']! as String,
          easyDateTime: json['easyDateTime']! as DateTime,
          listEasyData: (json['easyData']! as List).cast<int>(),
          stringFormatTime: json['formatTime']! as String,
        );

  Map<String, Object?> toJson() {
    return {
      'easyData': listEasyData,
      'easyGoal': strEasyGoal,
      'easyDateTime': easyDateTime,
      'usefulDeity': strUsefulDeity,
      'formatTime': stringFormatTime,
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
