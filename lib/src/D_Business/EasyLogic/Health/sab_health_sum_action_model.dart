import 'package:your_lucky/src/A_Context/sac_global.dart';
import 'package:your_lucky/src/D_Business/Base/sab_base_model.dart';
import 'package:your_lucky/src/D_Business/EasyLogic/Health/sab_health_sum_addend_model.dart';
import 'package:your_lucky/src/D_Business/EasyLogic/Health/sab_health_sum_target_model.dart';

class SABHealthSumActionModel extends SABBaseModel {
  SABHealthSumActionModel({
    required this.addendModel,
    required this.targetModel,
    required this.isEarthAddendBornTarget,
    required this.isEarthAddendRestrictsTarget,
  });
  final SABHealthSumAddendModel addendModel;
  final SABHealthSumTargetModel targetModel;
  final bool isEarthAddendBornTarget;
  final bool isEarthAddendRestrictsTarget;
  late final String timeDes = getTimeDes();

  double getAffectRate(){
    //(globalMaxDefensive - basicDefenseModel.defensive)
    return globalMaxDefensive - targetModel.defenseModel.defensive;
  }

  double getAddendValue () {
    double fHealth = 0;
    if (isEarthAddendBornTarget) {
      fHealth = addendModel.outModel.getOut();
    } //else cont.

    if (isEarthAddendRestrictsTarget) {
      fHealth = -1 * getAffectRate() * addendModel.outModel.getOut();
    } //else cont.
    return fHealth;
  }

  double getResult(){
    return targetModel.health + getAddendValue();
  }
}