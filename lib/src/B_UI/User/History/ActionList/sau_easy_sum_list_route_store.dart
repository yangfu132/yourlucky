
import 'package:your_lucky/src/B_UI/Common/Route/List/sau_list_route_store.dart';
import 'package:your_lucky/src/D_Business/EasyLogic/Health/sab_health_sum_action_model.dart';

class SAUEasySumListRouteStore extends SAUListRouteStore{
  SAUEasySumListRouteStore({
    required super.inputDetailModel,
    required super.nRow,
    required super.easyType,
    required this.listSumAction,
  });

  final List<SABHealthSumActionModel> listSumAction;
  //
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
  // void onCellTapped(BuildContext context, VoidCallback refreshAction){
  //   // Navigator.push(context, MaterialPageRoute(builder: (context) {
  //   //   SABEasyDetailBusiness detailBusiness = SABEasyDetailBusiness(model);
  //   //   return SAUStrategyResultRoute(detailBusiness.outputDetailModel());
  //   // }))
  // }
}