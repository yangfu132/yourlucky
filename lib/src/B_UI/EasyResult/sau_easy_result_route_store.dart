import 'package:flutter/material.dart';
import 'package:your_lucky/src/A_Context/sac_context.dart';
import 'package:your_lucky/src/A_Context/sac_global.dart';
import 'package:your_lucky/src/B_UI/Common/Route/Detail/sau_detail_route.dart';
import 'package:your_lucky/src/B_UI/Common/Route/Detail/sau_route_title_model.dart';
import 'package:your_lucky/src/B_UI/Common/Route/sau_textfield_route.dart';
import 'package:your_lucky/src/B_UI/Common/Route/sau_textfield_route_model.dart';
import 'package:your_lucky/src/B_UI/EasyResult/sau_seak_future_route_store.dart';
import 'package:your_lucky/src/C_ViewModel/EasyDetail/sab_easy_detail_model.dart';
import 'package:your_lucky/src/D_Business/Base/sab_base_model.dart';
import 'package:your_lucky/src/E_Service/sas_localizations_service.dart';

class SAUEasyResultRouteStore extends SABBaseModel {
  SAUEasyResultRouteStore({required this.detailModel});
  final SABEasyDetailModel detailModel;
  SAURouteTitleModel titleModel(){
    return SAURouteTitleModel.emptyTitleModel();
  }

  void loadData(void Function(String content) finish){
    finish('吉');
  }

  //趋吉
  void gotoSeekFortuneDetail(BuildContext context) {
    int uiRow = detailModel.getUsefulDeity().symbolRow + 1;
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      final store = SAUSeekFutureRouteStore(
          inputDetailModel:detailModel,
          uiRow: uiRow,
          easyType: detailModel.getUsefulDeity().easyType
      );
        return SAUDetailRoute(store:store);
    }));
  }

  //避凶
  void gotoAvoidEvilDetail(BuildContext context) {

  }

  void gotoTextField(BuildContext context) {
    String stringValue = detailModel.digitModel().strEasyGoal;
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      SAUTextFieldRouteModel model = SAUTextFieldRouteModel(
        stringTitle: SASLocalizationsService.easyNamed(context),
        stringValue: stringValue,
        stringPlaceholder: "请输入",
      );
      return SAUTextFieldRoute(
        model: model,
        onSave: (SAUTextFieldRouteModel model) {
          detailModel.digitModel().strEasyGoal = model.stringValue;
          SACContext.easyStore().save(detailModel.digitModel());
          Navigator.pop(context);
        },
      );
    }));
  }
}