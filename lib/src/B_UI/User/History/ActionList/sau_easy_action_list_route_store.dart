
import 'package:flutter/material.dart';
import 'package:your_lucky/src/B_UI/Common/Route/List/sau_list_route.dart';
import 'package:your_lucky/src/B_UI/Common/Route/List/sau_list_route_store.dart';
import 'package:your_lucky/src/B_UI/Common/Widget/ListCell/sau_list_cell_model.dart';
import 'package:your_lucky/src/B_UI/User/History/ActionList/sau_easy_sum_list_route_store.dart';
import 'package:your_lucky/src/D_Business/EasyLogic/Health/sab_health_action_model.dart';
class SAUActionListRouteStore extends SAUListRouteStore{
  SAUActionListRouteStore({
    required super.inputDetailModel,
    required super.nRow,
    required super.easyType,
  });
  // final SABEasyDetailModel inputDetailModel;
  //
  // int nRow;
  //
  // final EasyTypeEnum easyType;
  //
  // List<SAUListCellModel> listData = [];
  //
  // SAURouteTitleModel titleModel(){
  //   return SAURouteTitleModel.titleFromDetailModel(inputDetailModel,
  //       nRow + 1,
  //       easyType,
  //       resultAction);
  // }
  //
  // void resultAction(BuildContext context, VoidCallback refreshAction) {
  //   nRow = nRow + 1;
  //   if (nRow > 5) {
  //     nRow = 0;
  //   }
  //   listData.clear();
  //   loadData(refreshAction);
  // }
  //
  // void loadData(VoidCallback refreshAction){
  //   SABHealthSymbolModel? symbol = inputDetailModel.healthModel().symbol(nRow, easyType);
  //   if (null != symbol) {
  //     for (SABHealthActionModel actionModel in symbol.actionList) {
  //       SAUListCellModel cellModel = SAUListCellModel.fromActionModel(actionModel);
  //       listData.add(cellModel);
  //     } // end for
  //   } // end if
  //   refreshAction();
  // }
  //
  // SAUListCellModel cellModelAtIndex(int index){
  //   SAUListCellModel cellModel;
  //   if (index < listData.length) {
  //     cellModel = listData[index];
  //   } else {
  //     cellModel = SAUListCellModel.errorOutRangeCellModel("length:${listData.length},index:$index");
  //   }
  //   return cellModel;
  // }
  //
  // void onButtonClicked(SAUButtonModel buttonModel,BuildContext context, VoidCallback refreshAction) {
  //   if ('annotate' == buttonModel.code) {
  //     onAnnotateTapped(context,refreshAction);
  //   }
  // }
  // void onAnnotateTapped(BuildContext context, VoidCallback refreshAction) {
  //   String strOldValue = '';
  //   Navigator.push(context, MaterialPageRoute(builder: (context) {
  //     SAUTextFieldRouteModel model = SAUTextFieldRouteModel(
  //       stringTitle: "修改批注",
  //       stringValue: strOldValue,
  //       stringPlaceholder: "请输入",
  //     );
  //     return SAUTextFieldRoute(
  //       model: model,
  //       onSave: (SAUTextFieldRouteModel model) {
  //         // String strNewValue = model.stringValue;
  //         Navigator.pop(context);
  //       },
  //     );
  //   }));
  // }
  //
  @override
  void onCellTapped(SAUListCellModel model,BuildContext context, VoidCallback refreshAction){
    SABHealthActionModel actionModel = model.dataModel as SABHealthActionModel;
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      SAUEasySumListRouteStore store = SAUEasySumListRouteStore(
        inputDetailModel:inputDetailModel,
        nRow:nRow,
        easyType: easyType,
        listSumAction: actionModel.sumActionList
      );
      return SAUListRoute(store:store);
    }));
  }
}