import 'package:your_lucky/src/A_Context/sac_global.dart';
import 'package:your_lucky/src/D_Business/Base/sab_base_model.dart';

class SABOutModel extends SABBaseModel {
  SABOutModel({
    required this.nRow,
    required this.easyType,
  });
  final int nRow;
  final EasyTypeEnum easyType;
  late final double health;
  late final double conversionRate;
  OutRightEnum outRight = OutRightEnum.rightTypeNull;

  double getOut(){
    //health * conversionRate
    final result = health * conversionRate;
    return result;
  }
}

class SABHealthSumAddendModel extends SABBaseModel {
  SABHealthSumAddendModel({
    required this.nRow,
    required this.easyType,
    required this.symbolEarth,
    required this.outModel
  });
  final int nRow;
  final EasyTypeEnum easyType;
  final String symbolEarth;
  final SABOutModel outModel;

  double getOut(){
    return outModel.getOut();
  }
}