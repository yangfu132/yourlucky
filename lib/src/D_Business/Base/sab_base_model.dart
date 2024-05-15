import 'package:flutter/foundation.dart';
import 'package:your_lucky/src/A_Context/sac_context.dart';
import 'package:your_lucky/src/A_Context/sac_global.dart';

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
    coLog(
      StackTrace.current,
      LogTypeEnum.check,
      '--- ${this.runtimeType} checked --- ',
    );
  }

  void error() {
    coLog(
      StackTrace.current,
      LogTypeEnum.error,
      '--- ${this.runtimeType} error --- ',
    );
    debugPrint("");
  }

  void printMsg (String message) {
    debugPrint(message);
  }
}
