import 'package:flutter/material.dart';
import 'package:your_lucky/src/A_Context/sac_global.dart';
import 'package:your_lucky/src/B_UI/Common/Route/Detail/sau_route_title_model.dart';
import 'package:your_lucky/src/B_UI/Common/Route/sau_textfield_route.dart';
import 'package:your_lucky/src/B_UI/Common/Route/sau_textfield_route_model.dart';
import 'package:your_lucky/src/B_UI/Common/Widget/Button/sau_button_model.dart';
import 'package:your_lucky/src/B_UI/Common/Widget/ListCell/sau_list_cell_model.dart';
import 'package:your_lucky/src/C_ViewModel/EasyDetail/sab_easy_detail_model.dart';
import 'package:your_lucky/src/D_Business/Base/sab_base_model.dart';
import 'package:your_lucky/src/D_Business/EasyLogic/Health/sab_health_action_model.dart';
import 'package:your_lucky/src/D_Business/EasyLogic/Health/sab_health_symbol_model.dart';

class SAUListRouteStore extends SABBaseModel{
  SAUListRouteStore({
    required this.inputDetailModel,
    required this.nRow,
    required this.easyType,
  });
  final SABEasyDetailModel inputDetailModel;

  int nRow;

  final EasyTypeEnum easyType;

  List<SAUListCellModel> listData = [];

  SAURouteTitleModel titleModel(){
    return SAURouteTitleModel.titleFromDetailModel(inputDetailModel,
        nRow + 1,
        easyType,
        resultAction);
  }

  void resultAction(BuildContext context, VoidCallback refreshAction) {
    nRow = nRow + 1;
    if (nRow > 5) {
      nRow = 0;
    }
    listData.clear();
    loadData(refreshAction);
  }

  void loadData(VoidCallback refreshAction){
    SABHealthSymbolModel? symbol = inputDetailModel.healthModel().symbol(nRow, easyType);
    if (null != symbol) {
      for (SABHealthActionModel actionModel in symbol.actionList) {
        SAUListCellModel cellModel = SAUListCellModel.fromActionModel(actionModel);
        listData.add(cellModel);
      } // end for
    } // end if
    refreshAction();
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