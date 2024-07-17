import 'package:flutter/material.dart';
import 'package:your_lucky/src/B_UI/Common/Route/Detail/sau_route_title_model.dart';
import 'package:your_lucky/src/B_UI/Common/Route/sau_textfield_route.dart';
import 'package:your_lucky/src/B_UI/Common/Route/sau_textfield_route_model.dart';
import 'package:your_lucky/src/B_UI/Common/Widget/Button/sau_button_model.dart';
import 'package:your_lucky/src/B_UI/Common/Widget/ListCell/sau_list_cell_model.dart';
import 'package:your_lucky/src/D_Business/Base/sab_base_model.dart';

class SAUListRouteStore extends SABBaseModel{

  List<SAUListCellModel> listData = [];

  SAURouteTitleModel titleModel(){
    return SAURouteTitleModel.emptyTitleModel();
  }

  void loadData(VoidCallback refreshAction){
  }

  SAUListCellModel cellModelAtIndex(int index){
    SAUListCellModel cellModel;
    if (index < listData.length) {
      cellModel = listData[index];
    } else {
      cellModel = SAUListCellModel.errorOutRangeCellModel("length:${listData.length},index:$index");
    }
    return cellModel;
  }

  void onButtonClicked(SAUButtonModel buttonModel,BuildContext context, VoidCallback refreshAction) {
    if ('annotate' == buttonModel.code) {
      onAnnotateTapped(context,refreshAction);
    }
  }
  void onAnnotateTapped(BuildContext context, VoidCallback refreshAction) {
    String strOldValue = '';
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      SAUTextFieldRouteModel model = SAUTextFieldRouteModel(
        stringTitle: "修改批注",
        stringValue: strOldValue,
        stringPlaceholder: "请输入",
      );
      return SAUTextFieldRoute(
        model: model,
        onSave: (SAUTextFieldRouteModel model) {
          // String strNewValue = model.stringValue;
          Navigator.pop(context);
        },
      );
    }));
  }

  void onCellTapped(SAUListCellModel model,BuildContext context, VoidCallback refreshAction){
  }
}