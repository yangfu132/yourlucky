
import 'package:your_lucky/src/D_Business/Base/sab_base_model.dart';

class SAUButtonModel extends SABBaseModel {
  SAUButtonModel({required this.title, required this.code, this.highLight = true});
  final String title;
  final String code;
  bool highLight;
}