﻿import 'package:yourlucky/src/A_Context/SACContext.dart';

class SABBaseModel {
  SABBaseModel();

  SABBaseModel.fromJson(Map<String, Object?> json);

  Map<String, Object?> toJson() {
    return {};
  }

  String getModelName() {
    return '';
  }

  int? getModelId() {
    return null;
  }

  String toString() {
    Map<String, Object?> json = toJson();
    return json.toString();
  }

  void check() {
    coLog('${this.runtimeType} checked');
  }
}
