import 'package:your_lucky/src/A_Context/sac_global.dart';
import 'package:your_lucky/src/D_Business/Base/sab_base_model.dart';

class SAUSymbolModel extends SABBaseModel {
  SAUSymbolModel({required this.symbolRow, required this.easyType});
  final int symbolRow;
  final EasyTypeEnum easyType;
}
