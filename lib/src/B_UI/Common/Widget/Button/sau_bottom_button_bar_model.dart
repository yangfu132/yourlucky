
import 'package:your_lucky/src/D_Business/Base/sab_base_model.dart';

import 'sau_button_model.dart';
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
