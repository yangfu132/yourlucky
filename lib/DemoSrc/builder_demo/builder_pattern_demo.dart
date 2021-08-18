import 'package:yourlucky/DemoSrc/builder_demo/meal.dart';
import 'package:yourlucky/DemoSrc/builder_demo/meal_builder.dart';

class BuilderPatternDemo {
  void mainMethod() {
    MealBuilder mealBuilder = MealBuilder();
    MealDemo vegMeal = mealBuilder.prepareVegMeal();
    print("Veg Meal");
    vegMeal.showItems();
    print("Total Cost: ${vegMeal.getCost()}");

    MealDemo nonVegMeal = mealBuilder.prepareVegMeal();
    print("Non-Veg Meal");
    nonVegMeal.showItems();
    print("Total Cost: ${nonVegMeal.getCost()}");
  }
}
