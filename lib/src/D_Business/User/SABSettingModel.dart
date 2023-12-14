import 'package:yourlucky/src/D_Business/Base/SABBaseModel.dart';

class SABSettingModel extends SABBaseModel {
  SABSettingModel({
    required this.modelId,
    required this.settingKey,
    required this.settingTitle,
    required this.settingValue,
    required this.settingRemark,
  });
  int? modelId;
  String settingKey;
  String settingTitle;
  bool settingValue;
  String settingRemark;


  SABSettingModel.fromJson(Map<String, Object?> json)
      : this(
    modelId: json['id'] as int,
    settingKey: json['settingKey']! as String,
    settingTitle: json['settingTitle']! as String,
    settingValue: json['settingValue']! as bool,
    settingRemark: json['settingRemark']! as String,
  );

  Map<String, Object?> toJson() {
    return {
      'id': modelId,
      'settingKey': settingKey,
      'settingTitle': settingTitle,
      'settingValue': settingValue,
      'settingRemark': settingRemark,
    };
  }
}