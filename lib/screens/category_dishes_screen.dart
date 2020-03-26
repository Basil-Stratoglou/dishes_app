import 'package:dishes_app/models/dish.dart';
import 'package:dishes_app/widgets/dish_item.dart';
import 'package:flutter/material.dart';

class CategoryDishesScreen extends StatefulWidget {
  static const routeName = '/category-dishes';

  final List<Dish> availableDishes;

  const CategoryDishesScreen(this.availableDishes);

  @override
  _CategoryDishesScreenState createState() => _CategoryDishesScreenState();
}

class _CategoryDishesScreenState extends State<CategoryDishesScreen> {
  String categoryTitle;
  List<Dish> displayedDishes;
  bool _loadedInitData = false;

  @override
  void didChangeDependencies() {
    if (!_loadedInitData) {
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      categoryTitle = routeArgs['title'];
      final categoryId = routeArgs['id'];
      displayedDishes = widget.availableDishes.where(
        (dish) {
          return dish.categories.contains(categoryId);
        },
      ).toList();
      _loadedInitData = true;
      super.didChangeDependencies();
    }
  }

  void _removeDish(String dishId) {
    setState(() {
      displayedDishes.removeWhere((dish) => dish.id == dishId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return DishItem(
            id: displayedDishes[index].id,
            title: displayedDishes[index].title,
            imageUrl: displayedDishes[index].imageUrl,
            affordability: displayedDishes[index].affordability,
            complexity: displayedDishes[index].complexity,
            duration: displayedDishes[index].duration,
          );
        },
        itemCount: displayedDishes.length,
      ),
    );
  }
}
