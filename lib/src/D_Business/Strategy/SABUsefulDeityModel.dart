import 'package:yourlucky/src/A_Context/SACGlobal.dart';
import 'package:yourlucky/src/D_Business/Base/SABBaseModel.dart';

class SABUsefulDeityModel extends SABBaseModel {
  SABUsefulDeityModel({required this.intRow, required this.easyType});
  final int intRow;
  final EasyTypeEnum easyType;
  void check() {
    super.check();
  }
}
