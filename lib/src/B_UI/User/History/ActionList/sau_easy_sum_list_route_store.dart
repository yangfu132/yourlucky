
import 'package:flutter/material.dart';
import 'package:your_lucky/src/A_Context/sac_global.dart';
import 'package:your_lucky/src/B_UI/Common/Route/Detail/sau_route_title_model.dart';
import 'package:your_lucky/src/B_UI/Common/Route/List/sau_list_route_store.dart';
import 'package:your_lucky/src/B_UI/Common/Widget/ListCell/sau_list_cell_model.dart';
import 'package:your_lucky/src/C_ViewModel/EasyDetail/sab_easy_detail_model.dart';
import 'package:your_lucky/src/D_Business/EasyLogic/Health/sab_health_sum_action_model.dart';
import 'package:your_lucky/src/D_Business/EasyLogic/Health/sab_health_symbol_model.dart';

class SAUEasySumListRouteStore extends SAUListRouteStore{
  SAUEasySumListRouteStore({
    required this.inputDetailModel,
    required this.nRow,
    required this.easyType,
    required this.listSumAction,
  });
  final SABEasyDetailModel inputDetailModel;
  int nRow;
  final EasyTypeEnum easyType;

  final List<SABHealthSumActionModel> listSumAction;

  @override
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

  @override
  void loadData(VoidCallback refreshAction){
    for (SABHealthSumActionModel actionModel in listSumAction) {
      SAUListCellModel cellModel = SAUListCellModel.fromSumModel(actionModel);
      listData.add(cellModel);
    } // end for
    refreshAction();
  }

  // void onCellTapped(BuildContext context, VoidCallback refreshAction){
  //   // Navigator.push(context, MaterialPageRoute(builder: (context) {
  //   //   SABEasyDetailBusiness detailBusiness = SABEasyDetailBusiness(model);
  //   //   return SAUStrategyResultRoute(detailBusiness.outputDetailModel());
  //   // }))
  // }
}