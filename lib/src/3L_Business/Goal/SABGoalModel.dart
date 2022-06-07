import 'package:yourlucky/src/3L_Business/Base/SABBaseModel.dart';

import 'SABDeityModel.dart';
import 'SABLifeModel.dart';

class SABGoalModel extends SABBaseModel {
  SABGoalModel({
    required this.deityModel,
    required this.lifeModel,
    // required this.strategyModel,
  });

  final SABDeityModel deityModel;

  final SABLifeModel lifeModel;

  // final SABEasyStrategyResultModel strategyModel;
}
