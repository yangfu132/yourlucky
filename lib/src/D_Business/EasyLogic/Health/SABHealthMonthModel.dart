import 'package:yourlucky/src/D_Business/Base/SABBaseModel.dart';
import 'package:yourlucky/src/D_Business/EasyWords/SABWordsMonthModel.dart';

class SABHealthMonthModel extends SABBaseModel {
  SABHealthMonthModel({
    required this.wordsModel,
  });
  final SABWordsMonthModel wordsModel;

  final double health = 100.0;

  ///输出值
  final double monthOut = 1;

  ///输出权
  final double monthOutRight = 100.0;

  List<String> arraySeason = ["旺", "相", "余气", "休", "囚", "死"];
}
