import 'package:yourlucky/builder_demo/chicken_buiger.dart';
import 'package:yourlucky/builder_demo/meal.dart';
import 'package:yourlucky/builder_demo/pepsi.dart';
import 'package:yourlucky/builder_demo/veg_buiger.dart';
import 'package:yourlucky/builder_demo/coke.dart';

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
