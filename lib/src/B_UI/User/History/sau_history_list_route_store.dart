import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:your_lucky/src/D_Business/Base/sab_base_model.dart';
import 'package:your_lucky/src/D_Business/DigitModel/sab_easy_digit_model.dart';
import 'package:your_lucky/src/E_Service/FireBase/sas_cloud_fire_store_service.dart';

class SAUHistoryListRouteStore extends SABBaseModel{
  final cloudService = SASCloudFireStoreService();

  void gotoBaseInfo(BuildContext context,VoidCallback refreshAction) {

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
}