import 'package:flutter/material.dart';
import 'package:your_lucky/src/A_Context/sac_global.dart';
import 'package:your_lucky/src/B_UI/Common/Route/Detail/sau_route_title_model.dart';
import 'package:your_lucky/src/B_UI/Common/Route/Text/sau_text_route.dart';
import 'package:your_lucky/src/B_UI/Common/Route/Text/sau_text_route_store.dart';
import 'package:your_lucky/src/C_ViewModel/EasyDetail/sab_easy_detail_model.dart';
import 'package:your_lucky/src/D_Business/BasicEasy/sab_easy_text_business.dart';

class SAUEasyTextRouteStore extends SAUTextRouteStore {
  SAUEasyTextRouteStore({
    required this.inputDetailModel,
    required this.easyType,
    required this.symbolRow,
  });
  final SABEasyDetailModel inputDetailModel;
  final SABEasyTextBusiness business = SABEasyTextBusiness();
  final int symbolRow;
  final EasyTypeEnum easyType;
  late final String easyKey = inputDetailModel.diagramsModel().getEasyKey(easyType);
  bool isAll = false;

  @override
  void loadData(void Function(String content) finish){
    if (isAll) {
      business.getEasyText(easyKey, finish);
    } else {
      business.getSymbolText(easyKey, symbolRow,finish);
    }
  }

  @override
  SAURouteTitleModel titleModel(){
    return SAURouteTitleModel(
        title:inputDetailModel.diagramsModel().getEasyName(easyType),
        actionTitle: isAll ? '' : '全部',
        tapTitle:(BuildContext context,VoidCallback refreshAction){
          SAUEasyTextRouteStore store = SAUEasyTextRouteStore(
            inputDetailModel: inputDetailModel,
            easyType: easyType,
            symbolRow:symbolRow,
          );
          store.isAll = true;
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return SAUTextRoute(store:store);
          }));
        });
  }
}