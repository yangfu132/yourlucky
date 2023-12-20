
import 'package:yourlucky/src/D_Business/Base/SABBaseModel.dart';

class SAUTextFieldRouteModel extends SABBaseModel {
  SAUTextFieldRouteModel({required this.stringTitle, this.stringValue = "", this.stringRemark, this.stringPlaceholder});
  final String stringTitle;
  String stringValue = "";
  String? stringPlaceholder;
  String? stringRemark;
}