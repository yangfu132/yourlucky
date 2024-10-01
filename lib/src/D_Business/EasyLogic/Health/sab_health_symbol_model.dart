import 'package:your_lucky/src/A_Context/sac_context.dart';
import 'package:your_lucky/src/A_Context/sac_global.dart';
import 'package:your_lucky/src/D_Business/Base/sab_base_model.dart';
import 'package:your_lucky/src/D_Business/EasyLogic/Health/sab_health_action_model.dart';

class SABHealthSymbolModel extends SABBaseModel {
  SABHealthSymbolModel({
    required this.outRight,
    required this.outRightUnEmpty,
    required this.critical,
    required this.initModel,
  }) {
    setAction(initModel);
  }
  List<SABHealthActionModel> actionList = [];

  final double critical;
  double _doubleHealth = 0;
  OutRightEnum outRight;
  OutRightEnum outRightUnEmpty;
  final SABHealthActionModel initModel;
  bool isBasicHealth = false;
  double getHealthAction() {
    return _doubleHealth;
  }

  void sumAction(SABHealthActionModel actionModel) {
    _doubleHealth = _doubleHealth + actionModel.doubleHealth;
    actionList.add(actionModel);
  }

  void setAction(SABHealthActionModel actionModel) {
    _doubleHealth = actionModel.doubleHealth;
    actionList.add(actionModel);
    if (ActionTypeEnum.update == actionModel.nActionType) {
      if (actionModel.sumActionList.isEmpty || isBasicHealth) {
        coLog(StackTrace.current, LogTypeEnum.error, "没有变化为什么要更新");
      }
    }
  }

  SABHealthSymbolModel.fromJson(Map<String, Object?> json)
      : this(
    critical: json['critical'] as double,
    outRightUnEmpty: json['outRightUnEmpty']! as OutRightEnum,
    outRight: json['outRight']! as OutRightEnum,
      initModel:SABHealthActionModel(nActionType:ActionTypeEnum.fromJson,
          doubleHealth: 0,
          easyType: EasyTypeEnum.typeNull,
          nRow: globalRowInvalid,
          sumActionList:[]),
  );

  @override Map<String, Object?> toJson() {
    return {
      'critical': critical,
      'doubleHealth': _doubleHealth,
      'outRight': outRight,
      'outRightUnEmpty':outRightUnEmpty,
    };
  }

  double healthWithCritical() {
    return _doubleHealth - critical;
  }

  bool isStrong() {
    return healthWithCritical() > 0;
  }

  String healthDescription() {
    String strResult = "??";
    if (isStrong()) {
      strResult = "强";
    } else {
      strResult = "弱";
    }
    strResult = '${healthWithCritical().toStringAsFixed(4)}($strResult)';
    return strResult;
  }


}
