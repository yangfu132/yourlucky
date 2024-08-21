import 'package:your_lucky/src/B_UI/Common/Route/Detail/sau_route_title_model.dart';
import 'package:your_lucky/src/C_ViewModel/EasyDetail/sab_easy_detail_model.dart';
import 'package:your_lucky/src/D_Business/Base/sab_base_model.dart';

class SAUEasyResultRouteStore extends SABBaseModel {
  SAUEasyResultRouteStore({required this.detailModel});
  final SABEasyDetailModel detailModel;
  SAURouteTitleModel titleModel(){
    return SAURouteTitleModel.emptyTitleModel();
  }

  void loadData(void Function(String content) finish){
    finish('吉');
  }
}