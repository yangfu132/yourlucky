
import 'package:your_lucky/src/B_UI/Common/Widget/Button/sau_button_model.dart';
import 'package:your_lucky/src/D_Business/Base/sab_base_model.dart';

class SAUDetailRouteModel extends SABBaseModel {
  SAUDetailRouteModel({required this.title,required this.resultList,required this.buttonRoles});
  final List<SAUButtonModel>? buttonRoles;
  final List<Map> resultList;
  final String title;

}
