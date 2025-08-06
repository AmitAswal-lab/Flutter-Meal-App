import 'package:flutter/material.dart';
import 'package:meal_app/data/dummy_data.dart';
import 'package:meal_app/models/category.dart';
import 'package:meal_app/models/meal.dart';


import 'package:meal_app/screens/meals.dart';
import 'package:meal_app/widgets/category_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key, required this.onToggleFavorite});

  final void Function(Meal meal) onToggleFavorite;

  void _selectCategory(BuildContext context, Category category) {

    final filterMeals = dummyMeals.where((meals) => meals.categories.contains(category.id)).toList();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(title: category.title, meals: filterMeals, onToggleFavorite: onToggleFavorite,),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return  GridView(
        padding: EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.5,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: availableCategories
            .map((category) => CategoryGridItem(category: category, onSelectCategory: (){
              _selectCategory(context, category);
            }))
            .toList(),
        /*for(final category in availableCategories)
         CategoryGridItem(category: category)*/
    );
  }
}
