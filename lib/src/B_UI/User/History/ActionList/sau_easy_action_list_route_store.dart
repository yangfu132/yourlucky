
import 'package:flutter/material.dart';
import 'package:your_lucky/src/A_Context/sac_global.dart';
import 'package:your_lucky/src/B_UI/Common/Route/Detail/sau_route_title_model.dart';
import 'package:your_lucky/src/B_UI/Common/Route/List/sau_list_route.dart';
import 'package:your_lucky/src/B_UI/Common/Route/List/sau_list_route_store.dart';
import 'package:your_lucky/src/B_UI/Common/Widget/ListCell/sau_list_cell_model.dart';
import 'package:your_lucky/src/B_UI/User/History/ActionList/sau_easy_sum_list_route_store.dart';
import 'package:your_lucky/src/C_ViewModel/EasyDetail/sab_easy_detail_model.dart';
import 'package:your_lucky/src/D_Business/EasyLogic/Health/sab_health_action_model.dart';
import 'package:your_lucky/src/D_Business/EasyLogic/Health/sab_health_symbol_model.dart';
class SAUActionListRouteStore extends SAUListRouteStore{
  SAUActionListRouteStore({
    required this.inputDetailModel,
    required this.nRow,
    required this.easyType,
  });
  final SABEasyDetailModel inputDetailModel;
  int nRow;
  final EasyTypeEnum easyType;

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
    SABHealthSymbolModel? symbol = inputDetailModel.healthModel().symbol(nRow, easyType);
    if (null != symbol) {
      for (SABHealthActionModel actionModel in symbol.actionList) {
        actionModel.isBasicHealth = symbol.isBasicHealth;
        SAUListCellModel cellModel = SAUListCellModel.fromActionModel(actionModel);
        listData.add(cellModel);
      } // end for
    } // end if
    refreshAction();
  }

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