import 'package:dishes_app/models/dish.dart';
import 'package:dishes_app/widgets/dish_item.dart';
import 'package:flutter/material.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Dish> favoriteDishes;

  const FavoritesScreen(this.favoriteDishes);
  @override
  Widget build(BuildContext context) {
    if (favoriteDishes.isEmpty) {
      return Center(
        child: Text('You have no favorites yet. Please add some!'),
      );
    } else {
      return ListView.builder(
        itemBuilder: (ctx, index) {
          return DishItem(
            id: favoriteDishes[index].id,
            title: favoriteDishes[index].title,
            imageUrl: favoriteDishes[index].imageUrl,
            affordability: favoriteDishes[index].affordability,
            complexity: favoriteDishes[index].complexity,
            duration: favoriteDishes[index].duration,
          );
        },
        itemCount: favoriteDishes.length,
      );
    }
  }
}
