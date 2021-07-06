import 'package:yourlucky/builder_demo/burger.dart';

class ChickenBurger extends BurgerDemo {
  @override
  String name() {
    return "ChickenBurger";
  }

  @override
  double price() {
    return 50;
  }
}
