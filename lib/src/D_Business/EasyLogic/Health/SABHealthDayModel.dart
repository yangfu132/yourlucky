import 'package:yourlucky/src/D_Business/Base/SABBaseModel.dart';
import 'package:yourlucky/src/D_Business/EasyWords/SABWordsDayModel.dart';

class SABHealthDayModel extends SABBaseModel {
  SABHealthDayModel({
    required this.wordsModel,
    required this.health,
  });
  final SABWordsDayModel wordsModel;
  final double health;
}
