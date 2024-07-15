import 'package:your_lucky/src/A_Context/sac_global.dart';
import 'package:your_lucky/src/D_Business/Base/sab_base_model.dart';

class SABDefensiveModel extends SABBaseModel {
  SABDefensiveModel({
    required this.nRow,
    required this.easyType,
  });
  final int nRow;
  final EasyTypeEnum easyType;
  late final double defensive;
}

class SABHealthSumTargetModel extends SABBaseModel {
  SABHealthSumTargetModel({
    required this.nRow,
    required this.easyType,
    required this.symbolEarth,
    required this.defenseModel,
  });
  final int nRow;
  final EasyTypeEnum easyType;
  final String symbolEarth;
  final SABDefensiveModel defenseModel;
  late final double health;
}