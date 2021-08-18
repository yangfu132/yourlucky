import 'package:yourlucky/DemoSrc/builder_demo/chicken_buiger.dart';
import 'package:yourlucky/DemoSrc/builder_demo/coke.dart';
import 'package:yourlucky/DemoSrc/builder_demo/meal.dart';
import 'package:yourlucky/DemoSrc/builder_demo/pepsi.dart';
import 'package:yourlucky/DemoSrc/builder_demo/veg_buiger.dart';

class MealBuilder {
  MealDemo prepareVegMeal() {
    MealDemo mealDemo = new MealDemo();
    mealDemo.addItem(new VegBurger());
    mealDemo.addItem(new CokeDemo());
    return mealDemo;
  }

  MealDemo prepareNonVegMeal() {
    MealDemo mealDemo = new MealDemo();
    mealDemo.addItem(new ChickenBurger());
    mealDemo.addItem(new PepsiDemo());
    return mealDemo;
  }
}
