import 'package:yourlucky/DemoSrc/builder_demo/burger.dart';

class VegBurger extends BurgerDemo {
  @override
  String name() {
    return "VegBurger";
  }

  @override
  double price() {
    return 25;
  }
}
