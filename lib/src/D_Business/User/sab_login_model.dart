import 'package:your_lucky/src/D_Business/Base/sab_base_model.dart';

enum LoginTypeEnum {
  textType, //文本
  switchType, //开关
  textField, //文本输入框
}


class SABLoginModel extends SABBaseModel {
  SABLoginModel({
    required this.modelId,
    required this.userName,
    required this.userPassword,
    required this.userMail,
    required this.loginType,
    required this.dataJson,
    required this.isLogged,
  });
  int? modelId;
  String userName;
  String userPassword;
  String userMail;
  String dataJson;
  LoginTypeEnum? loginType;
  bool isLogged = false;

  @override String getModelName() {
    return 'setting';
  }

  @override int? getModelId() {
    return modelId;
  }

  // int? modelId;
  // String userName;
  // String userPassword;
  // String userMail;
  // String stringRemark;
  // LoginTypeEnum? settingType;

  SABLoginModel.fromJson(Map<String, Object?> json)
      : this(
    modelId: json['id'] as int,
    userName: json['settingKey']! as String,
    userPassword: json['settingTitle']! as String,
    userMail: json['stringValue']! as String,
    loginType: LoginTypeEnum.values[json['loginType'] as int],
    dataJson: json['dataJson']! as String,
    isLogged: false,
  );

  @override Map<String, Object?> toJson() {
    return {
      'id': modelId,
      'userName': userName,
      'userPassword': userPassword,
      'userMail': userMail,
      'settingType': loginType!.index,
      'dataJson': dataJson,
    };
  }
}