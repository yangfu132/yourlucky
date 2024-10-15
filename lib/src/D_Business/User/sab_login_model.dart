
import 'dart:convert';

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
  }) {
    if (dataJson.isNotEmpty) {
      Map<String, dynamic> extraData = Map<String, dynamic>.from(json.decode(dataJson));
      String? aaa = extraData["isLogged"];
      if (null != aaa) {
        aaa.toLowerCase() == 'true';
        isLogged = bool.parse(aaa);
      }
      // isLogged = extraData["isLogged"] ?? false;
    } // else {}
  }

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

  SABLoginModel.fromJson(Map<String, Object?> jsonData)
      : this(
    modelId: jsonData['id'] as int,
    userName: jsonData['userName']! as String,
    userPassword: jsonData['userPassword']! as String,
    userMail: jsonData['userMail']! as String,
    loginType: LoginTypeEnum.values[jsonData['loginType'] as int],
    dataJson: jsonData['dataJson']! as String,
  );

  @override Map<String, Object?> toJson() {
    Map<String, dynamic> extraData = {};
    extraData["isLogged"] = isLogged.toString();
    ///TODO:add more item
    if (extraData.isNotEmpty) {
      dataJson = json.encode(extraData);
    }

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
        dataJson: '');
  }

  void setModel(SABLoginModel model) {
    modelId = model.modelId;
    userName = model.userName;
    userPassword = model.userPassword;
    userMail = model.userMail;
    loginType = model.loginType;
    dataJson = model.dataJson;
    isLogged = model.isLogged;
  }
}