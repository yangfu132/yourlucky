import 'package:flutter/material.dart';
import 'package:your_lucky/src/A_Context/sac_global.dart';
import 'package:your_lucky/src/B_UI/Common/Route/Detail/sau_detail_route_store.dart';
import 'package:your_lucky/src/B_UI/Common/Route/Detail/sau_route_title_model.dart';
import 'package:your_lucky/src/C_ViewModel/EasyDetail/sab_row_detail_model.dart';
import '../Common/Route/Detail/sau_detail_route_model.dart';

class SAUDetailDetailRouteStore extends SAUDetailRouteStore{
  SAUDetailDetailRouteStore({
    required super.inputDetailModel,
    required super.uiRow,
    required super.easyType});
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
    final easyEmptyModel = inputDetailModel.healthLogicModel().symbolEmpty(symbolRow, easyType);
    easyEmptyModel.health = inputDetailModel.healthModel().symbolHealthAtRow(symbolRow, easyType);
    String resultValue = '';
    switch (itemKey) {
      case 'easyType':
        resultValue = easyEmptyModel.easyType.name;
        break;
      case 'symbolRow':
        resultValue = "${easyEmptyModel.symbolRow}";
        break;
      case 'stringSymbol':
        resultValue = easyEmptyModel.stringSymbol;
        break;
      case 'health':
        resultValue = "${easyEmptyModel.health}";
        break;
      case 'emptyEarth':
        resultValue = easyEmptyModel.emptyEarth;
        break;
      case 'strDay':
        resultValue = easyEmptyModel.strDay;
        break;
      case 'isConflictDay':
        resultValue = "${easyEmptyModel.isConflictDay}";
        break;
      case 'isFalseEmpty':
        resultValue = "${easyEmptyModel.isFalseEmpty}";
        break;
      case 'isRealEmpty':
        resultValue = "${easyEmptyModel.isRealEmpty}";
        break;
      case 'emptyType':
        resultValue = easyEmptyModel.emptyType.name;
        break;
      case 'bWang':
        resultValue = "${easyEmptyModel.bWang}";
        break;
      case 'bMove':
        resultValue = "${easyEmptyModel.bMove}";
        break;
      case 'bRestrictHide':
        resultValue = "${easyEmptyModel.bRestrictHide}";
        break;
      case 'monthConflict':
        resultValue = easyEmptyModel.monthConflict.name;
        break;
      case 'season':
        resultValue = easyEmptyModel.season;
        break;
      default:
        resultValue = '$itemKey 未找到值 ';
        break;
    }
    return resultValue;
  }
  // bool bWang = false;
  // bool bMove = false;
  // bool bRestrictHide = false;
  // MonthConflictEnum monthConflict = MonthConflictEnum.conflictNull;

  List<Map> resultList() {
    final List<String> itemKeyList = [
      'easyType','symbolRow','stringSymbol','health', 'emptyEarth',
      'strDay','isConflictDay','isFalseEmpty','isRealEmpty','emptyType',
      'bWang','bMove','bRestrictHide','monthConflict','season',
      ];
    var result = List<Map>.empty(growable: true);
    for (String itemKey in itemKeyList) {
      result.add({'key':itemKey,'value':itemValue(itemKey)});
    }
    return result;
  }

  void gotoBaseInfo(BuildContext context,VoidCallback refreshAction) {
  }
}
