import 'package:flutter/material.dart';
import 'package:your_lucky/src/A_Context/sac_global.dart';
import 'package:your_lucky/src/B_UI/Common/Route/Detail/sau_detail_route_store.dart';
import 'package:your_lucky/src/B_UI/Common/Route/Detail/sau_route_title_model.dart';
import 'package:your_lucky/src/C_ViewModel/EasyDetail/sab_row_detail_model.dart';
import 'package:your_lucky/src/D_Business/EasyLogic/sab_easy_empty_model.dart';
import 'sau_detail_route_model.dart';

class SAUDetailDetailRouteStore extends SAUDetailRouteStore{
  SAUDetailDetailRouteStore({
    required super.inputDetailModel,
    required super.uiRow,
    required super.easyType});
  SABEasyEmptyModel easyEmptyModel = SABEasyEmptyModel.emptyModel();
  @override
  SAUDetailRouteModel requestData() {
    final titleModel = SAURouteTitleModel.titleFromDetailModel(inputDetailModel,
        uiRow,
        easyType,
        resultAction);
    data = SAUDetailRouteModel(titleModel:titleModel,
        cardList:[
          healthInfoCard(),
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

  SAUDetailCardModel healthInfoCard () {
    SAUDetailCardModel cardModel = SAUDetailCardModel(title: "基本信息",
        resultList: resultList(),
        tapTitle:gotoBaseInfo
    );
    return cardModel;
  }


  String itemValue(String itemKey) {
    int symbolRow = uiRow - 1;
    String resultValue = '';
    switch (itemKey) {
      case 'health':
        resultValue = "${easyEmptyModel.health}";
        break;
      default:
        resultValue = '$itemKey 未找到值 ';
        break;
    }
    return resultValue;
  }

  String resultSymbolEmpty(int nRow, EasyTypeEnum easyType) {
    String strEmpty = "";
    switch (inputDetailModel.healthLogicModel().getSymbolEmptyState(nRow, easyType)) {
      case EmptyEnum.emptyNO:
        break;
      case EmptyEnum.emptyYES:
        strEmpty = "[空]";
        break;
      case EmptyEnum.emptyFalse:
        strEmpty = "[假空]";
        break;
      case EmptyEnum.emptyReal:
        strEmpty = "[真空]";
        break;
      case EmptyEnum.emptyConflict:
        strEmpty = "[冲空不空]";
        break;
      default:
        break;
    } //ends

    return strEmpty;
  }

  List<Map> resultList() {
    final List<String> itemKeyList = ['health'];
    var result = List<Map>.empty(growable: true);
    for (String itemKey in itemKeyList) {
      result.add({'key':itemKey,'value':itemValue(itemKey)});
    }
    return result;
  }

  void gotoBaseInfo(BuildContext context,VoidCallback refreshAction) {
  }
}
