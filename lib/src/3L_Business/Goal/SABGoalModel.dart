import 'SABDeityModel.dart';
import 'SABLifeModel.dart';

class SABGoalModel {
  SABGoalModel({
    required this.deityModel,
    required this.lifeModel,
    required this.strategy,
  });

  final SABDeityModel deityModel;

  final SABLifeModel lifeModel;

  final String strategy;
}
