import 'package:flutter/foundation.dart';
import 'package:your_lucky/src/A_Context/sac_context.dart';
import 'package:your_lucky/src/A_Context/sac_global.dart';

class SABBaseModel {
  SABBaseModel();

  String getTimeDes(){
    final DateTime theDate = DateTime.now().toLocal();
    return theDate.toString();
  }

  String? cloudId;

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

  @override String toString() {
    Map<String, Object?> json = toJson();
    return json.toString();
  }

  void check() {
    coLog(
      StackTrace.current,
      LogTypeEnum.check,
      '--- $runtimeType checked --- ',
    );
  }

  void error() {
    coLog(
      StackTrace.current,
      LogTypeEnum.error,
      '--- $runtimeType error --- ',
    );
    debugPrint("");
  }

  void printMsg (String message) {
    debugPrint(message);
  }
}
