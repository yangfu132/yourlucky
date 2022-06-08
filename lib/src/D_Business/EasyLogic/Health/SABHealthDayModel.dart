import 'package:yourlucky/src/D_Business/Base/SABBaseModel.dart';
import 'package:yourlucky/src/D_Business/EasyWords/SABWordsDayModel.dart';

class SABHealthDayModel extends SABBaseModel {
  SABHealthDayModel({
    required this.wordsModel,
  });
  final SABWordsDayModel wordsModel;
  final double health = 100.0;

  ///输出值
  final double dayOut = 1.2;

  ///输出权
  final double dayOutRight = 100.0;
}
