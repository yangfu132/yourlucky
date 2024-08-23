
import 'package:flutter/material.dart';
import 'package:your_lucky/src/A_Context/sac_global.dart';
import 'package:your_lucky/src/B_UI/Common/Route/Detail/sau_detail_route_model.dart';
import 'package:your_lucky/src/B_UI/Common/Route/Detail/sau_detail_route_store.dart';
import 'package:your_lucky/src/B_UI/Common/Route/Detail/sau_route_title_model.dart';
import 'package:your_lucky/src/B_UI/EasyResult/sau_symbol_model.dart';
import 'package:your_lucky/src/C_ViewModel/EasyDetail/sab_row_detail_model.dart';
import 'package:your_lucky/src/D_Business/EasyLogic/BaseLogic/sab_easy_logic_business.dart';
class SAUAvoidEvilRouteStore extends SAUDetailRouteStore{
  SAUAvoidEvilRouteStore({
    required super.inputDetailModel,
    required super.uiRow,
    required super.easyType});

  @override
  SAUDetailRouteModel requestData() {
    final titleModel = SAURouteTitleModel.titleFromString('避祸信息');

    final symbolList = getSymbolList();
    List<SAUDetailCardModel> cardList = [];
    for (int nIndex = 0; nIndex < symbolList.length; nIndex++) {
      SAUSymbolModel model = symbolList[nIndex];
      cardList.add(avoidEvilCard(model,nIndex,symbolList.length > 1));
    }
    data = SAUDetailRouteModel(titleModel:titleModel,
        cardList:cardList,
        buttonRoles:[]);
    return data;
  }

  List<SAUSymbolModel> getSymbolList(){
    List<SAUSymbolModel> symbolList = [];
    SABEasyLogicBusiness logicBusiness = SABEasyLogicBusiness(inputDetailModel.digitModel());
    List bornArray = logicBusiness.lifeBornArray();
    for (int nRow in bornArray) {
      SAUSymbolModel symbolModel = SAUSymbolModel(symbolRow:nRow,
          easyType:EasyTypeEnum.from);
      symbolList.add(symbolModel);
    }
    return symbolList;
  }

  SAUDetailCardModel avoidEvilCard (SAUSymbolModel symbolModel,int nIndex,bool bMulti) {

    String indexDes = '';
    switch(nIndex) {
      case 0:
        indexDes = '第一';
        break;
      case 1:
        indexDes = '第二';
        break;
      case 2:
        indexDes = '第三';
        break;
      case 3:
        indexDes = '第四';
        break;
      case 4:
        indexDes = '第五';
        break;
      case 5:
        indexDes = '第六';
        break;
      default:
        break;
    }
    String title = '';
    if (bMulti) {
      title = '可以避祸的时间和方位（$indexDes）';
    } else {
      title = '可以避祸的时间和方位';
    }

    List<Map> resultList = [];
    if (globalRowDay == symbolModel.symbolRow) {
      resultList = inputDetailModel.dayModel.resultList();
    } else if (globalRowMonth == uiRow) {
      resultList =  inputDetailModel.monthModel.resultList();
    } else {
      SABRowDetailModel rowModel =
      inputDetailModel.rowModelAtRow(symbolModel.symbolRow);
      resultList =  rowModel.resultList(easyType);
      // title = rowModel.getSymbolName(easyType);
    }

    SAUDetailCardModel cardModel = SAUDetailCardModel(title: title,
        resultList: resultList,
        tapTitle:gotoBaseInfo
    );
    return cardModel;
  }

  void gotoBaseInfo(BuildContext context,VoidCallback refreshAction) {
  }
}