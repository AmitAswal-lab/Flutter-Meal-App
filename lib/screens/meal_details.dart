import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_app/providers/favorite_provider.dart';

class MealDetailsScreen extends ConsumerWidget {
  const MealDetailsScreen({super.key, required this.meal,});

  final Meal meal;
  

  @override
  Widget build(BuildContext context, WidgetRef ref) {
   final favoriteMeals = ref.watch(favoriteMealsProvider);

   final isFavorite = favoriteMeals.contains(meal);

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [IconButton(
          onPressed: () {
            final wasAdded = ref.read(favoriteMealsProvider.notifier).toggleMealFavoriteStatus(meal);
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(wasAdded ? 'Meal added as a Favorite.' : 'Meals removed!'),
              )
            );
          }, 
          icon: Icon(isFavorite ? Icons.star : Icons.star_border_outlined),
          ),],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              meal.imageUrl,
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16),
            Text(
              'Ingredients',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12),
            for (final ingredient in meal.ingredients)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Text(
                  ingredient,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
            SizedBox(height: 24),
            Text(
              'Steps',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12),
            for (final step in meal.steps)
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 24,
                ),
                child: Text(
                  step,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
