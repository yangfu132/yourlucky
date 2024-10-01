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
    return 'user_sign';
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
    userName: json['userName']! as String,
    userPassword: json['userPassword']! as String,
    userMail: json['userMail']! as String,
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
      'loginType': loginType!.index,
      'dataJson': dataJson,
    };
  }

  static SABLoginModel empty () {
    return SABLoginModel(modelId: null,
        userName: '',
        userPassword: '',
        userMail: '',
        loginType: LoginTypeEnum.textType,
        dataJson: '',
        isLogged: false);
  }

  void setModel(SABLoginModel model) {
    modelId = model.modelId;
    userName = model.userName;
    userPassword = model.userPassword;
    userMail = model.userMail;
    loginType = model.loginType;
    dataJson = model.dataJson;
  }
}