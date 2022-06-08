import 'package:yourlucky/src/A_Context/SACGlobal.dart';
import 'package:yourlucky/src/D_Business/Base/SABBaseModel.dart';

class SABParentInfoModel extends SABBaseModel {
  SABParentInfoModel({required this.intRow, required this.easyType});
  final int intRow;
  final EasyTypeEnum easyType;
  static List baseCategoryArray() {
    return ['父母', '官鬼', '兄弟', '妻财', '子孙'];
  }
}