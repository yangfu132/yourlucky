import 'package:yourlucky/DemoSrc/builder_demo/item.dart';
import 'package:yourlucky/DemoSrc/builder_demo/packing.dart';
import 'package:yourlucky/DemoSrc/builder_demo/wrapper.dart';

abstract class BurgerDemo implements ItemDemo {
  @override
  PackingDemo packing() {
    return Wrapper();
  }

  @override
  double price();
}
