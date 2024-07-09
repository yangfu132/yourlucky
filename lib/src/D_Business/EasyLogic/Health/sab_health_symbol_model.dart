import 'package:your_lucky/src/A_Context/sac_global.dart';
import 'package:your_lucky/src/D_Business/Base/sab_base_model.dart';
import 'package:your_lucky/src/D_Business/EasyLogic/BaseLogic/sab_logic_symbol_model.dart';

class SABHealthSymbolModel extends SABBaseModel {
  SABHealthSymbolModel({
    required this.doubleHealth,
    required this.outRight,
    required this.critical,
  });
  final double critical;
  double doubleHealth;
  OutRightEnum outRight;


  SABHealthSymbolModel.fromJson(Map<String, Object?> json)
      : this(
    critical: json['critical'] as double,
    doubleHealth: json['doubleHealth'] as double,
    outRight: json['outRight']! as OutRightEnum,
  );

  @override Map<String, Object?> toJson() {
    return {
      'critical': critical,
      'doubleHealth': doubleHealth,
      'outRight': outRight,
    };
  }

  double healthWithCritical() {
    return doubleHealth - critical;
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
