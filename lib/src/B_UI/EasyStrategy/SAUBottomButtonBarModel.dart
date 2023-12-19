
import 'package:yourlucky/src/D_Business/Base/SABBaseModel.dart';

class SAUBottomButtonBarModel extends SABBaseModel {
  SAUBottomButtonBarModel({required this.itemList});
  final List<SAUButtonModel> itemList;
}

class SAUButtonModel extends SABBaseModel {
  SAUButtonModel({required this.title, required this.code, this.highLight = true});
  final String title;
  final String code;
  bool highLight;
}