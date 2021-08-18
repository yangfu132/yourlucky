import 'package:yourlucky/DemoSrc/builder_demo/bottle.dart';
import 'package:yourlucky/DemoSrc/builder_demo/item.dart';
import 'package:yourlucky/DemoSrc/builder_demo/packing.dart';

abstract class ColdDrink implements ItemDemo {
  @override
  PackingDemo packing() {
    return Bottle();
  }

  @override
  double price();
}
