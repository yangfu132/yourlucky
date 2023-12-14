import 'package:yourlucky/src/D_Business/Base/SABBaseModel.dart';

class SABSettingModel extends SABBaseModel {
  SABSettingModel({
    required this.modelId,
    required this.settingTitle,
    required this.settingValue
  });
  int? modelId;
  String settingTitle;
  bool settingValue;



  SABSettingModel.fromJson(Map<String, Object?> json)
      : this(
    modelId: json['id'] as int,
    settingTitle: json['settingTitle']! as String,
    settingValue: json['settingValue']! as bool,
  );

  Map<String, Object?> toJson() {
    return {
      'id': modelId,
      'settingTitle': settingTitle,
      'settingValue': settingValue,
    };
  }
}