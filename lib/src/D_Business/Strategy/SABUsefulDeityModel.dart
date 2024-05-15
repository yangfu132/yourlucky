import 'package:your_lucky/src/A_Context/sac_global.dart';
import 'package:your_lucky/src/D_Business/Base/SABBaseModel.dart';

class SABUsefulDeityModel extends SABBaseModel {
  SABUsefulDeityModel({required this.intRow, required this.easyType});
  final int intRow;
  final EasyTypeEnum easyType;
  void check() {
    super.check();
  }
}
