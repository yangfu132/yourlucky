import 'package:yourlucky/builder_demo/cold_drink.dart';

class PepsiDemo extends ColdDrink {
  @override
  String name() {
    return "Pepsi";
  }

  @override
  double price() {
    return 35;
  }
}
