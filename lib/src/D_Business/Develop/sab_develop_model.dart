// import 'package:cloud_firestore/cloud_firestore.dart';

import 'dart:convert';

import 'package:your_lucky/src/A_Context/sac_context.dart';
import 'package:your_lucky/src/A_Context/sac_global.dart';
import 'package:your_lucky/src/D_Business/Base/sab_base_model.dart';

///此Model仅代表开发任务所创造的数据；
class SABDevelopModel extends SABBaseModel {
  //构造函数
  SABDevelopModel({
    required this.modelId,
    required this.strGoal,
    required this.strUsefulDeity,
    required this.listRelationData,
    required this.stringTime,
    this.strStrategy = "Strategy",
    this.dataJson = '',
  }) {
    if (dataJson.isNotEmpty) {
       extraData = Map<String, dynamic>.from(json.decode(dataJson));
       strAnnotate = extraData["annotate"] ?? "";
    }
  }

  int? modelId;

  String strStrategy;

  //属性：实例的随机数数组
  final List<int> listRelationData;

  //属性：实例的发生目的
  String strGoal = "";

  //属性：实例的用神
  final String strUsefulDeity;

  final String stringTime;

  String dataJson;

  Map<String, dynamic> extraData = {};

  String strAnnotate = "";

  @override void check() {
    if (listRelationData.isEmpty) {
      coLog(StackTrace.current, LogTypeEnum.check, "listRelationData.isEmpty");
    }
    if (strGoal.isEmpty) {
      coLog(StackTrace.current, LogTypeEnum.check, "strGoal.isEmpty");
    }
    if (strUsefulDeity.isEmpty) {
      coLog(StackTrace.current, LogTypeEnum.check, "strUsefulDeity.isEmpty");
    }
    if (stringTime.isEmpty) {
      coLog(StackTrace.current, LogTypeEnum.check, "strUsefulDeity.isEmpty");
    }
    super.check();
  }

  ///注解，相当于经验
  void setAnnotate(String annotate) {
    strAnnotate = annotate;
  }

  @override String getModelName() {
    return 'develop_task';
  }

  @override int? getModelId() {
    return modelId;
  }

  String describe() {
    String stringDescribe = 'String';
    return stringDescribe;
  }

  String title() {
    String stringTitle = '';
    if (strGoal.isNotEmpty) {
      stringTitle = stringTime + strGoal;
    } else {
      stringTitle = stringTime + strUsefulDeity;
    }
    return stringTitle;
  }

  bool isMovement(List<int> listRelationData) {
    bool tempMovement = false;
    for (int intItem in listRelationData) {
      if (8 == intItem || 9 == intItem) {
        tempMovement = true;
        break;
      } //else continue
    } //end for
    return tempMovement;
  }

  SABDevelopModel.fromJson(Map<String, Object?> json)
      : this(
          modelId: json['id'] as int,
          strGoal: json['goal']! as String,
          strUsefulDeity: json['usefulDeity']! as String,
          stringTime: json['time']! as String,
          strStrategy: json['strategy']! as String,
          dataJson: json['dataJson']! as String,
          listRelationData: (json['relationData']! as String)
              .split(',')
              .map((e) => int.parse(e))
              .toList(),
        );

  @override Map<String, Object?> toJson() {
    if (strAnnotate.isNotEmpty) {
       extraData["annotate"] = strAnnotate;
    }

    if (extraData.isNotEmpty) {
       dataJson = json.encode(extraData);
    }

    return {
      'id': modelId,
      'goal': strGoal,
      'usefulDeity': strUsefulDeity,
      'time': stringTime,
      'strategy': strStrategy,
      'dataJson': dataJson,
      'relationData': listRelationData.join(','),
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
      int intValue = listRelationData[intIndex];
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
      int intValue = listRelationData[intIndex];

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
      if (8 == listRelationData[nRow]) {
        result = true;
      } else if (9 == listRelationData[nRow]) {
        result = true;
      }
      //else cont.
    } else {
      result = false;
    } // end if

    return result;
  }

  int digitAtIndex(int intSymbolIndex) {
    return listRelationData[intSymbolIndex];
  }
}
