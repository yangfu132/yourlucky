import 'package:flutter/material.dart';
import 'package:your_lucky/src/A_Context/sac_context.dart';
import 'package:your_lucky/src/A_Context/sac_global.dart';
import 'package:your_lucky/src/B_UI/Common/Route/Detail/sau_route_title_model.dart';
import 'package:your_lucky/src/B_UI/Common/Route/sau_textfield_route.dart';
import 'package:your_lucky/src/B_UI/Common/Route/sau_textfield_route_model.dart';
import 'package:your_lucky/src/C_ViewModel/EasyDetail/sab_easy_detail_model.dart';
import 'package:your_lucky/src/C_ViewModel/EasyDetail/sab_row_detail_model.dart';
import 'package:your_lucky/src/D_Business/Base/sab_base_model.dart';

import 'sau_detail_route_model.dart';

class SAUDetailRouteStore extends SABBaseModel{
  SAUDetailRouteStore({
    required this.inputDetailModel,
    required this.uiRow,
    required this.easyType});

  final SABEasyDetailModel inputDetailModel;
  final int uiRow;
  EasyTypeEnum easyType;
  SAUDetailRouteModel data = loadingDetailRouteModel('');

  SAUDetailRouteModel requestData() {
    final titleModel = SAURouteTitleModel.titleFromDetailModel(inputDetailModel,
        uiRow,
        easyType,
        resultAction);
    data = SAUDetailRouteModel(titleModel:titleModel,
        cardList:[
          debugInfoCard()
        ],
        buttonRoles:[]);
    return data;
  }

  void resultAction(BuildContext context, VoidCallback refreshAction) {
    if (0 == uiRow) {
      gotoTextField(context);
    } else {
      SABRowDetailModel rowModel =
      inputDetailModel.rowModelAtRow(uiRow - 1);
      easyType = rowModel.getNextEasyType(easyType);
      refreshAction();
    }
  }

  SAUDetailCardModel debugInfoCard () {
    return todoCard("debug信息");
  }

  void gotoTextField(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      SAUTextFieldRouteModel model = SAUTextFieldRouteModel(
        stringTitle: "修改目的",
        stringValue: inputDetailModel.digitModel().strEasyGoal,
        stringPlaceholder: "请输入",
      );
      return SAUTextFieldRoute(
        model: model,
        onSave: (SAUTextFieldRouteModel model) {
          inputDetailModel.digitModel().strEasyGoal =
              model.stringValue;
          SACContext.easyStore().save(inputDetailModel.digitModel());
          Navigator.pop(context);
        },
      );
    }));
  }

  void tapButton(String code) async {

  }
}
