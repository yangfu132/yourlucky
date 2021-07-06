import 'package:yourlucky/builder_demo/item.dart';
import 'package:yourlucky/builder_demo/packing.dart';
import 'package:yourlucky/builder_demo/wrapper.dart';

abstract class BurgerDemo implements ItemDemo {
  @override
  PackingDemo packing() {
    return Wrapper();
  }

  @override
  double price();
}
