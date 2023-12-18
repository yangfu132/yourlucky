import 'package:yourlucky/src/D_Business/Base/SABBaseModel.dart';


enum SettingTypeEnum {
  textType, //文本
  switchType, //开关
  textField, //文本输入框
}


class SABSettingModel extends SABBaseModel {
  SABSettingModel({
    required this.modelId,
    required this.settingKey,
    required this.settingTitle,
    required this.intValue,
    required this.stringValue,
    required this.settingType,
    required this.stringRemark,
  });
  int? modelId;
  String settingKey;
  String settingTitle;
  int intValue;
  String stringValue;
  String stringRemark;
  SettingTypeEnum? settingType;


  String getModelName() {
    return 'setting';
  }

  int? getModelId() {
    return modelId;
  }
  
  SABSettingModel.fromJson(Map<String, Object?> json)
      : this(
    modelId: json['id'] as int,
    settingKey: json['settingKey']! as String,
    settingTitle: json['settingTitle']! as String,
    intValue: json['intValue']! as int,
    stringValue: json['stringValue']! as String,
    settingType: SettingTypeEnum.values[json['settingType'] as int],
    stringRemark: json['stringRemark']! as String,

  );

  Map<String, Object?> toJson() {
    return {
      'id': modelId,
      'settingKey': settingKey,
      'settingTitle': settingTitle,
      'intValue': intValue,
      'stringValue': stringValue,
      'settingType': settingType!.index,
      'stringRemark': stringRemark,
    };
  }
}