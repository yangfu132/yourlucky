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
    required this.settingValue,
    required this.settingRemark,
    required this.settingType,
  });
  int? modelId;
  String settingKey;
  String settingTitle;
  bool settingValue;
  String settingRemark;
  SettingTypeEnum? settingType;

  SABSettingModel.fromJson(Map<String, Object?> json)
      : this(
    modelId: json['id'] as int,
    settingKey: json['settingKey']! as String,
    settingTitle: json['settingTitle']! as String,
    settingValue: json['settingValue']! as bool,
    settingRemark: json['settingRemark']! as String,
    settingType: json['id'] as SettingTypeEnum,
  );

  Map<String, Object?> toJson() {
    return {
      'id': modelId,
      'settingKey': settingKey,
      'settingTitle': settingTitle,
      'settingValue': settingValue,
      'settingRemark': settingRemark,
      'settingType': settingType,
    };
  }
}