import 'dart:math';

// import 'package:cloud_firestore/cloud_firestore.dart';

///此Model仅代表占卜时所创造的数据；
class SABEasyDigitModel {
  //构造函数
  SABEasyDigitModel(
    this._strEasyGoal,
    this._strUsefulDeity,
    this.easyDateTime,
    this._listEasyData, {
    stringTitle,
    stringDescribe,
  }) {
    if (null == stringTitle || stringTitle.isEmpty) {
      this.stringTitle = "原始";
    } else {
      this.stringTitle = stringTitle;
    }

    if (stringDescribe == null || stringDescribe.isEmpty) {
      this.stringDescribe = "原始";
    } else {
      this.stringDescribe = stringDescribe;
    }
  }
  SABEasyDigitModel.fromJson(Map<String, Object?> json)
      : this(
          json['strEasyGoal']! as String,
          json['strUsefulDeity']! as String,
    json['easyDateTime']! as DateTime,
          (json['listEasyData']! as List).cast<int>(),
          stringTitle: json['stringTitle']! as String,
          stringDescribe: json['stringDescribe']! as String,
        );

  Map<String, Object?> toJson() {
    return {
      'listEasyData': _listEasyData,
      'strEasyGoal': _strEasyGoal,
      'easyDateTime': easyDateTime,
      'strUsefulDeity': _strUsefulDeity,
      'stringTitle': stringTitle,
      'stringDescribe': stringDescribe
    };
  }

  //属性：实例发生时间
  final DateTime easyDateTime;

  //属性：实例的随机数数组
  final List<int> _listEasyData;

  //属性：实例的发生目的
  final String _strEasyGoal;

  //属性：实例的用神
  final String _strUsefulDeity;

  late String stringTitle;

  late String stringDescribe;

  /// `public 函数`/////////////////////////////////////////////////////////////

  ///利用随机数创造数据
  static List<int> generateEasyArray() {
    var listEasyData = List<int>.empty(growable: true);
    for (int nIndex = 0; nIndex < 6; nIndex++) {
      int randomNum = Random().nextInt(3);
      if (2 == randomNum)
        randomNum = 8;
      else if (3 == randomNum) randomNum = 9;
      //else cont.
      listEasyData.add(randomNum);
    } //endf
    //return _listEasyData;
    print('listEasyData:$listEasyData');
    //[0, 8, 0, 1, 1, 1]
    //[8, 8, 0, 8, 0, 0]
    //[0, 1, 1, 8, 8, 1]

    return listEasyData;
  }

  bool isMovement() {
    bool tempMovement = false;
    for (int intItem in _listEasyData) {
      if (8 == intItem || 9 == intItem) {
        tempMovement = true;
        break;
      } //else continue
    } //end for
    return tempMovement;
  }

  bool isInGua(int intRow) {
    return 0 <= intRow && intRow <= 3;
  }

  bool isOutGua(int intRow) {
    return 4 <= intRow && intRow <= 6;
  }

  ///此函数获取内卦变动的爻列表
  List inGuaMovementArray() {
    List inMovementArray = [];

    for (int intIndex = 3; intIndex < 6; intIndex++) {
      int intValue = _listEasyData[intIndex];
      if (8 == intValue || 9 == intValue) {
        inMovementArray.add(intValue);
      }
      //else cont.
    } //endf

    return inMovementArray;
  }

  ///此函数获取外卦变动的爻列表
  List outGuaMovementArray() {
    List outMovementArray = [];
    for (int intIndex = 0; intIndex < 3; intIndex++) {
      int intValue = _listEasyData[intIndex];

      if (8 == intValue || 9 == intValue) {
        outMovementArray.add(intValue);
      }
      //else cont.
    } //endf

    return outMovementArray;
  }

  /// `get and set函数`/////////////////////////////////////////////////////////

  DateTime getEasyTime() {
    return easyDateTime;
  }

  //函数：占卜目的
  String getEasyGoal() {
    return _strEasyGoal;
  }

  //函数：用神
  String getUsefulDeity() {
    return _strUsefulDeity;
  }

  bool isMovementAtRow(int nRow) {
    bool result = false;

    if (0 <= nRow && nRow < 6) {
      if (8 == _listEasyData[nRow]) {
        result = true;
      } else if (9 == _listEasyData[nRow]) {
        result = true;
      }
      //else cont.
    } else
      result = false;
    //CO_LOG(@"error!");

    return result;
  }

  String fromEasyKey() {
    String strFromKey = "";
    int nValue, nFromValue;
    for (int nIndex = 0; nIndex < 6; nIndex++) {
      nValue = _listEasyData[nIndex];
      if (nValue == 8)
        nFromValue = 0;
      else if (nValue == 9)
        nFromValue = 1;
      else
        nFromValue = nValue;
      strFromKey = "$strFromKey$nFromValue";
    } //endf

    return strFromKey;
  }

  String toEasyKey() {
    String strToKey = "";
    int nValue, nFromValue;
    for (int nIndex = 0; nIndex < 6; nIndex++) {
      nValue = _listEasyData[nIndex];
      if (nValue == 8)
        nFromValue = 1;
      else if (nValue == 9)
        nFromValue = 0;
      else
        nFromValue = nValue;
      strToKey = "$strToKey$nFromValue";
    } //endf

    return strToKey;
  }

  int digitAtIndex(int intSymbolIndex) {
    return _listEasyData[intSymbolIndex];
  }
}
