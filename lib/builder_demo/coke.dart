import 'package:yourlucky/builder_demo/cold_drink.dart';

class CokeDemo extends ColdDrink {
  @override
  String name() {
    return "Coke";
  }

  @override
  double price() {
    return 30;
  }
}
