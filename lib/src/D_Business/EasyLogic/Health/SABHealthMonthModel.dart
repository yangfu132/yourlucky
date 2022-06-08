import 'package:yourlucky/src/D_Business/Base/SABBaseModel.dart';
import 'package:yourlucky/src/D_Business/EasyWords/SABWordsMonthModel.dart';

class SABHealthMonthModel extends SABBaseModel {
  SABHealthMonthModel({
    required this.wordsModel,
    required this.health,
  });
  final SABWordsMonthModel wordsModel;
  final double health;
}
