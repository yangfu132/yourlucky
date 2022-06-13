import 'package:yourlucky/src/D_Business/Base/SABBaseModel.dart';

class SABLogModel extends SABBaseModel {
  SABLogModel({
    required this.modelId,
    required this.dataId,
    required this.dataJson,
    required this.msg,
  });
  final int? modelId;
  final int? dataId;
  final String dataJson;
  final String msg;

  SABLogModel.fromJson(Map<String, Object?> json)
      : this(
          modelId: json['modelId']! as int,
          dataId: json['dataId']! as int,
          dataJson: json['dataJson']! as String,
          msg: json['msg']! as String,
        );

  Map<String, Object?> toJson() {
    return {
      'id': modelId,
      'dataId': dataId,
      'dataJson': dataJson,
      'msg': msg,
    };
  }

  String getModelName() {
    return 'logs';
  }

  int? getModelId() {
    return modelId;
  }

  String toString() {
    return '';
  }
}
