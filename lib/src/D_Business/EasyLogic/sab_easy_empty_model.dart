import 'package:your_lucky/src/A_Context/sac_context.dart';
import 'package:your_lucky/src/A_Context/sac_global.dart';
import 'package:your_lucky/src/D_Business/Base/sab_base_model.dart';

class SABEasyEmptyModel extends SABBaseModel {
  SABEasyEmptyModel({
    required this.easyType,
    required this.symbolRow,
  });
  final EasyTypeEnum easyType;
  final int symbolRow;
  double? health;
  String stringSymbol = '';
  String emptyEarth = '';
  EmptyEnum emptyType = EmptyEnum.emptyNull;
  String earth = '';
  String strDay = '';
  bool isEarthConflict = false;

  void symbolBasicEmptyState (){
    if ("" != stringSymbol) {
      if (emptyEarth.contains(earth)) {
        if (isEarthConflict) {
          //爻遇旬空，日辰冲起而为用，谓之冲空则实。
          emptyType = EmptyEnum.emptyConflict;
        } else {
          emptyType = EmptyEnum.emptyYES;
        } // end if
      } //end if
    } else {
      coLog(StackTrace.current, LogTypeEnum.error, "stringSymbol为空");
    } // end if
  }
  static SABEasyEmptyModel emptyModel(){
    return SABEasyEmptyModel(
        easyType:EasyTypeEnum.typeNull,
        symbolRow:globalRowInvalid);
  }
}