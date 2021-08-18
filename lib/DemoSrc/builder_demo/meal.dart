import 'package:yourlucky/DemoSrc/builder_demo/item.dart';

class MealDemo {
  List<ItemDemo> items = <ItemDemo>[];

  void addItem(ItemDemo itemDemo) {
    items.add(itemDemo);
  }

  double getCost() {
    double cost = 0;
    for (ItemDemo itemDemo in items) {
      cost += itemDemo.price();
    }
    return cost;
  }

  void showItems() {
    for (ItemDemo itemDemo in items) {
      print('item:' + itemDemo.name());
      print(",Packing:" + itemDemo.packing().pack());
      print(",Price:${itemDemo.price()}");
    }
  }
}
