
import 'package:yourlucky/src/D_Business/Base/SABBaseModel.dart';

import 'SAUButtonModel.dart';
typedef ButtonTapCallback = void Function(SAUButtonModel itemModel);

class SAUBottomButtonBarModel extends SABBaseModel {
  SAUBottomButtonBarModel({required this.itemList});
  final List<SAUButtonModel> itemList;

  static SAUBottomButtonBarModel save () {
    SAUButtonModel model = SAUButtonModel(title: "保存",code: "save");
    final SAUBottomButtonBarModel buttonModel = SAUBottomButtonBarModel(itemList: [model]);
    return  buttonModel;
  }
}
