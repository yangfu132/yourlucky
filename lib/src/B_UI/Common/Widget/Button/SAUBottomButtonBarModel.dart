
import 'package:yourlucky/src/D_Business/Base/SABBaseModel.dart';

class SAUBottomButtonBarModel extends SABBaseModel {
  SAUBottomButtonBarModel({required this.itemList});
  final List<SAUButtonModel> itemList;

  static SAUBottomButtonBarModel save () {
    SAUButtonModel model = SAUButtonModel(title: "保存",code: "save");
    final SAUBottomButtonBarModel buttonModel = SAUBottomButtonBarModel(itemList: [model]);
    return  buttonModel;
  }
}

class SAUButtonModel extends SABBaseModel {
  SAUButtonModel({required this.title, required this.code, this.highLight = true});
  final String title;
  final String code;
  bool highLight;
}