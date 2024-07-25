import 'package:flutter/material.dart';
import 'package:your_lucky/src/A_Context/sac_global.dart';
import 'package:your_lucky/src/B_UI/Common/Route/Detail/sau_detail_route_store.dart';
import 'package:your_lucky/src/B_UI/Common/Route/Detail/sau_route_title_model.dart';
import 'package:your_lucky/src/C_ViewModel/EasyDetail/sab_row_detail_model.dart';
import '../Common/Route/Detail/sau_detail_route_model.dart';

class SAUBaseInfoDetailRouteStore extends SAUDetailRouteStore{
  SAUBaseInfoDetailRouteStore({
    required super.inputDetailModel,
    required super.uiRow,
    required super.easyType});

  // final SABEasyDetailModel inputDetailModel;
  // final int uiRow;
  // EasyTypeEnum easyType;
  // SAUDetailRouteModel data = loadingDetailRouteModel('');
  @override
  SAUDetailRouteModel requestData() {
    final titleModel = SAURouteTitleModel.titleFromDetailModel(inputDetailModel,
        uiRow,
        easyType,
        resultAction);
    data = SAUDetailRouteModel(titleModel:titleModel,
        cardList:[
          baseInfoCard(),
          debugInfoCard()
        ],
        buttonRoles:[]);
    return data;
  }

  SAUDetailCardModel baseInfoCard () {
    final List<Map> resultList;
    if (0 == uiRow) {
      resultList = inputDetailModel.diagramsDetailModel.resultList;
    } else if (globalRowDay == uiRow) {
      resultList = inputDetailModel.dayModel.resultList();
    } else if (globalRowMonth == uiRow) {
      resultList =  inputDetailModel.monthModel.resultList();
    } else {
      SABRowDetailModel rowModel =
      inputDetailModel.rowModelAtRow(uiRow - 1);
      resultList =  rowModel.resultList(easyType);
    }

    SAUDetailCardModel cardModel = SAUDetailCardModel(title: "基本信息",
        resultList: resultList,
        tapTitle:gotoBaseInfo
    );
    return cardModel;
  }

  void gotoBaseInfo(BuildContext context,VoidCallback refreshAction) {
  }
}
