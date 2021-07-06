import 'package:yourlucky/builder_demo/bottle.dart';
import 'package:yourlucky/builder_demo/item.dart';
import 'package:yourlucky/builder_demo/packing.dart';

abstract class ColdDrink implements ItemDemo {
  @override
  PackingDemo packing() {
    return Bottle();
  }

  @override
  double price();
}
