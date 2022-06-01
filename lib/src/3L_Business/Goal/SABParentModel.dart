import 'package:yourlucky/src/1L_Context/SACGlobal.dart';

class SABParentModel {
  SABParentModel({required this.intRow, required this.easyType});
  final int intRow;
  final EasyTypeEnum easyType;
  static List baseCategoryArray() {
    return ['父母', '官鬼', '兄弟', '妻财', '子孙'];
  }
}
