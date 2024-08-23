
import 'package:flutter/material.dart';
import 'package:your_lucky/src/A_Context/sac_global.dart';
import 'package:your_lucky/src/B_UI/Common/Route/Detail/sau_detail_route_model.dart';
import 'package:your_lucky/src/B_UI/Common/Route/Detail/sau_detail_route_store.dart';
import 'package:your_lucky/src/B_UI/Common/Route/Detail/sau_route_title_model.dart';
import 'package:your_lucky/src/B_UI/EasyDetail/sau_easy_text_route_store.dart';
import 'package:your_lucky/src/B_UI/EasyResult/sau_symbol_model.dart';
import 'package:your_lucky/src/C_ViewModel/EasyDetail/sab_row_detail_model.dart';

class SAUSeekFutureRouteStore extends SAUDetailRouteStore{
  SAUSeekFutureRouteStore({
    required super.inputDetailModel,
    required super.uiRow,
    required super.easyType});

  @override
  SAUDetailRouteModel requestData() {
    final titleModel = SAURouteTitleModel.titleFromString('趋吉信息');

    final symbolList = getSymbolList();
    List<SAUDetailCardModel> cardList = [];
    for (int nIndex = 0; nIndex < symbolList.length; nIndex++) {
      SAUSymbolModel model = symbolList[nIndex];
      cardList.add(seekFutureCard(model,nIndex));
    }
    data = SAUDetailRouteModel(titleModel:titleModel,
        cardList:cardList,
        buttonRoles:[]);
    return data;
  }

  List<SAUSymbolModel> getSymbolList(){
    List<SAUSymbolModel> symbolList = [];
    final usefulModel = inputDetailModel.getUsefulDeity();
    if (usefulModel.easyType ==  EasyTypeEnum.from) {
      SAUSymbolModel usefulSymbolModel = SAUSymbolModel(symbolRow:usefulModel.symbolRow,
          easyType:usefulModel.easyType);
      symbolList.add(usefulSymbolModel);

      List usefulArray = inputDetailModel.wordsModel().arrayUsefulRow(EasyTypeEnum.from);
      for (int nRow in usefulArray) {
        if (nRow != usefulModel.symbolRow) {
          SAUSymbolModel symbolModel = SAUSymbolModel(symbolRow:nRow,
              easyType:EasyTypeEnum.from);
          symbolList.add(symbolModel);
        }
      }
    } else {
      SAUSymbolModel symbolModel = SAUSymbolModel(symbolRow:usefulModel.symbolRow,
          easyType:usefulModel.easyType);
      symbolList = [symbolModel];
    }
    return symbolList;
  }

  @override
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

  SAUDetailCardModel seekFutureCard (SAUSymbolModel symbolModel,int nIndex) {

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
    String title = '$indexDes吉神';
    final List<Map> resultList;
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


  // SAUDetailCardModel seekFutureCard () {
  //   final List<Map> resultList;
  //   if (0 == uiRow) {
  //     resultList = inputDetailModel.diagramsDetailModel.resultList;
  //   } else if (globalRowDay == uiRow) {
  //     resultList = inputDetailModel.dayModel.resultList();
  //   } else if (globalRowMonth == uiRow) {
  //     resultList =  inputDetailModel.monthModel.resultList();
  //   } else {
  //     SABRowDetailModel rowModel =
  //     inputDetailModel.rowModelAtRow(uiRow - 1);
  //     resultList =  rowModel.resultList(easyType);
  //   }
  //
  //   SAUDetailCardModel cardModel = SAUDetailCardModel(title: "趋吉",
  //       resultList: resultList,
  //       tapTitle:gotoBaseInfo
  //   );
  //   return cardModel;
  // }

  void gotoBaseInfo(BuildContext context,VoidCallback refreshAction) {
  }
}