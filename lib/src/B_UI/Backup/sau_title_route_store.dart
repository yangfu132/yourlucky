import 'package:your_lucky/src/B_UI/Backup/sau_base_route_store.dart';
import 'package:your_lucky/src/B_UI/Common/Route/Detail/sau_route_title_model.dart';

class SAUTitleRouteStore extends SAUBaseRouteStore {
  SAUTitleRouteStore({required this.title});
  final String title;
  @override
  SAURouteTitleModel titleModel(){
    return SAURouteTitleModel.titleFromString(title);
  }
}