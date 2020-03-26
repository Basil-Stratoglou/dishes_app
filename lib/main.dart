import 'package:dishes_app/dish_data.dart';
import 'package:dishes_app/models/dish.dart';
import 'package:dishes_app/screens/categories_screen.dart';
import 'package:dishes_app/screens/category_dishes_screen.dart';
import 'package:dishes_app/screens/filters_screen.dart';
import 'package:dishes_app/screens/dish_detail_screen.dart';
import 'package:dishes_app/screens/tabs_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };
  List<Dish> _availableDishes = DISHES;
  List<Dish> _favoriteDishes = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      _availableDishes = DISHES.where((dish) {
        if (_filters['gluten'] && !dish.isGlutenFree) {
          return false;
        } else if (_filters['lactose'] && !dish.isLactoseFree) {
          return false;
        } else if (_filters['vegan'] && !dish.isVegan) {
          return false;
        } else if (_filters['vegetarian'] && !dish.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String dishId) {
    final existingIndex =
        _favoriteDishes.indexWhere((dish) => dish.id == dishId);
    if (existingIndex >= 0) {
      setState(() {
        _favoriteDishes.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteDishes.add(
          DISHES.firstWhere((dish) => dish.id == dishId),
        );
      });
    }
  }

  bool _isDishFavorite(String id) {
    return _favoriteDishes.any((dish) => dish.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dishes',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
            body1: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            body2: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            title: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'RobotoCondensed',
            )),
      ),
      // home: CategoriesScreen(),
      initialRoute: '/',
      routes: {
        '/': (ctx) => TabsScreen(_favoriteDishes),
        CategoryDishesScreen.routeName: (ctx) =>
            CategoryDishesScreen(_availableDishes),
        DishDetailScreen.routeName: (ctx) =>
            DishDetailScreen(_toggleFavorite, _isDishFavorite),
        FiltersScreen.routeName: (ctx) => FiltersScreen(_filters, _setFilters),
      },
      onGenerateRoute: (settings) {
        print(settings.arguments);
        // if (settings.name == '/dish-detail') {
        //   return ...;
        // }
        // else if (settings.name == '/something-else') {
        //   return ...;
        // }
        // return MaterialPageRoute(
        //   builder: (ctx) => CategoriesScreen(),
        // );
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
    );
  }
}
