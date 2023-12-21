
import 'package:yourlucky/src/D_Business/Base/SABBaseModel.dart';

class SAUButtonModel extends SABBaseModel {
  SAUButtonModel({required this.title, required this.code, this.highLight = true});
  final String title;
  final String code;
  bool highLight;
}