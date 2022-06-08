import 'package:yourlucky/src/D_Business/Base/SABBaseModel.dart';
import 'package:yourlucky/src/D_Business/EasyWords/SABWordsMonthModel.dart';

class SABHealthMonthModel extends SABBaseModel {
  SABHealthMonthModel({
    required this.wordsModel,
  });
  final SABWordsMonthModel wordsModel;
  final double health = 100.0;

  ///输出权
  final double monthOut = 1;

  ///输出值
  final double monthOutRight = 100.0;

  ///`基础函数`//////////////////////////////////////////////////////

  List arraySeason() {
    return ["旺", "相", "余气", "休", "囚", "死"];
  }
}
