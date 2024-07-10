import 'package:your_lucky/src/A_Context/sac_global.dart';
import 'package:your_lucky/src/D_Business/Base/sab_base_model.dart';

class SABHealthActionModel extends SABBaseModel {
  SABHealthActionModel({required this.doubleHealth,
    required this.easyType,
    required this.nRow});
  final double doubleHealth;
  final EasyTypeEnum easyType;
  final int nRow;
}