import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:your_lucky/src/A_Context/sac_context.dart';
import 'package:your_lucky/src/A_Context/sac_global.dart';
import 'package:your_lucky/src/B_UI/Common/Route/sau_textfield_route.dart';
import 'package:your_lucky/src/B_UI/Common/Route/sau_textfield_route_model.dart';
import 'package:your_lucky/src/B_UI/Common/Widget/Button/sau_button_model.dart';
import 'package:your_lucky/src/B_UI/Common/Widget/sau_alert_view.dart';
import 'package:your_lucky/src/B_UI/Common/Widget/sau_toast_widget.dart';
import 'package:your_lucky/src/B_UI/EasyStrategy/sau_strategy_result_route.dart';
import 'package:your_lucky/src/B_UI/Common/Route/List/sau_list_route.dart';
import 'package:your_lucky/src/B_UI/User/History/ActionList/sau_easy_action_list_route_store.dart';
import 'package:your_lucky/src/C_ViewModel/EasyDetail/sab_easy_detail_business.dart';
import 'package:your_lucky/src/D_Business/Base/sab_base_model.dart';
import 'package:your_lucky/src/D_Business/DigitModel/sab_easy_digit_model.dart';
import 'package:your_lucky/src/E_Service/FireBase/sas_cloud_fire_store_service.dart';

class SAUHistoryListRouteStore extends SABBaseModel{
  final cloudService = SASCloudFireStoreService();
  List<SABEasyDigitModel> historyData = [];

  void loadData(VoidCallback refreshAction){
    SACContext.easyStore().load((dataList) {
      historyData = dataList;
      refreshAction();
    });
  }


  void gotoBaseInfo(BuildContext context,VoidCallback refreshAction) {

  }

  void onCellClicked(BuildContext context,SABEasyDigitModel model){
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      SABEasyDetailBusiness detailBusiness = SABEasyDetailBusiness(model);
      return SAUStrategyResultRoute(detailBusiness.outputDetailModel());
    }));
  }

  void onButtonClicked (BuildContext context,
      int positionNow,
      SABEasyDigitModel model,
      SAUButtonModel value,
      VoidCallback refreshAction){
    if ('delete' == value.code) {
      deleteHistory(context, model, positionNow,refreshAction);
    }
    if ('annotate' == value.code) {
      onAnnotateTapped(context,model);
    }
    if ('upload' == value.code) {
      onUploadTapped(model);
    }
    if ('removeUpload' == value.code) {
      onRemoveUploadTapped(model);
    }
    if ('actionList' == value.code) {
      onActionListTapped(context,model);
    }
  }

  void onAnnotateTapped(BuildContext context,SABEasyDigitModel digitModel) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      SAUTextFieldRouteModel model = SAUTextFieldRouteModel(
        stringTitle: "修改批注",
        stringValue: digitModel.strAnnotate,
        stringPlaceholder: "请输入",
      );
      return SAUTextFieldRoute(
        model: model,
        onSave: (SAUTextFieldRouteModel model) {
          digitModel.strAnnotate = model.stringValue;
          SACContext.easyStore().save(digitModel);
          Navigator.pop(context);
        },
      );
    }));
  }

  void deleteHistory(BuildContext context,
      SABEasyDigitModel model,
      int positionNow,
      VoidCallback refreshAction) {

    SAUAlertWidget.showTitle(context, '删除后将无法看到该条记录，请谨慎操作', [
      SAUAlertAction(title: '取消', isColorGrey: true),
      SAUAlertAction(
          title: '确定',
          isDefault: true,
          action: () {
            SAUToastWidget.show("你点击了删除 ${model.title()}");
            SACContext.easyStore().delete(model);
            historyData.removeAt(positionNow);
            refreshAction();
          })
    ]);
  }

  void onUploadTapped(SABEasyDigitModel model) {
    BotToast.showLoading();
    cloudService.addModel(model.getModelName(), model, () {
      BotToast.closeAllLoading();
    });
  }

  void onRemoveUploadTapped(SABEasyDigitModel model) {
    BotToast.showLoading();
    cloudService.removeModel(model.getModelName(), model, () {
      BotToast.closeAllLoading();
    });
  }

  void onActionListTapped(BuildContext context, SABEasyDigitModel model){
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      SABEasyDetailBusiness detailBusiness = SABEasyDetailBusiness(model);
      SAUActionListRouteStore store = SAUActionListRouteStore(
          inputDetailModel:detailBusiness.outputDetailModel(),
          nRow:0,
        easyType: EasyTypeEnum.from,
      );
      return SAUListRoute(store:store);
    }));
  }
}