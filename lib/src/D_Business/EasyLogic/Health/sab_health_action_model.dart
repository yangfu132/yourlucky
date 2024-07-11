import 'package:your_lucky/src/A_Context/sac_global.dart';
import 'package:your_lucky/src/D_Business/Base/sab_base_model.dart';
import 'package:your_lucky/src/D_Business/EasyLogic/Health/sab_health_sum_action_model.dart';

class SABHealthActionModel extends SABBaseModel {
  SABHealthActionModel({
    required this.nActionType,
    required this.doubleHealth,
    required this.easyType,
    required this.sumActionList,
    required this.nRow});
  final ActionTypeEnum nActionType;

  final double doubleHealth;
  final EasyTypeEnum easyType;
  final int nRow;
  double? basicDefense;

  double? affectHealth;
  EasyTypeEnum? affectEasyType;
  int? nAffectRow;
  double? conversionRate;

  final List<SABHealthSumActionModel> sumActionList;
}