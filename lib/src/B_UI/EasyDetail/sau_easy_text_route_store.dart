import 'package:your_lucky/src/B_UI/Common/Route/sau_text_route_store.dart';
import 'package:your_lucky/src/D_Business/BasicEasy/sab_easy_text_business.dart';

class SAUEasyTextRouteStore extends SAUTextRouteStore {
  SAUEasyTextRouteStore({
    required this.easyKey,
  });

  final SABEasyTextBusiness business = SABEasyTextBusiness();
  final String easyKey;

  @override
  void loadData(void Function(String content) finish){
    business.getEasyText(easyKey, (content) {

    });
  }
}