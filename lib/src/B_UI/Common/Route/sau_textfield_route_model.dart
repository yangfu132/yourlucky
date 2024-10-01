
import 'package:your_lucky/src/D_Business/Base/sab_base_model.dart';

class SAUTextFieldRouteModel extends SABBaseModel {
  SAUTextFieldRouteModel({required this.stringTitle, this.stringValue = "", this.stringRemark, this.stringPlaceholder});
  final String stringTitle;
  String stringValue = "";
  String? stringPlaceholder;
  String? stringRemark;
}