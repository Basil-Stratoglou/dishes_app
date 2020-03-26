import 'package:flutter/material.dart';
import 'package:dishes_app/dish_data.dart';

class DishDetailScreen extends StatelessWidget {
  static const routeName = '/dish-detail';

  final Function toggleFavorite;
  final Function isFavorite;

  const DishDetailScreen(this.toggleFavorite, this.isFavorite);

  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.title,
      ),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: 150,
      width: 300,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final dishId = ModalRoute.of(context).settings.arguments as String;
    final selectedDish = DISHES.firstWhere((dish) => dish.id == dishId);
    return Scaffold(
      appBar: AppBar(
        title: Text('${selectedDish.title}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectedDish.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildSectionTitle(context, 'Ingredients'),
            buildContainer(
              ListView.builder(
                  itemBuilder: (ctx, index) => Card(
                        color: Theme.of(context).accentColor,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 10,
                          ),
                          child: Text(
                            selectedDish.ingredients[index],
                          ),
                        ),
                      ),
                  itemCount: selectedDish.ingredients.length),
            ),
            buildSectionTitle(context, 'Steps'),
            buildContainer(ListView.builder(
              itemBuilder: (ctx, index) => Column(
                children: <Widget>[
                  ListTile(
                    leading: CircleAvatar(
                      child: Text('# ${(index + 1)}'),
                    ),
                    title: Text(
                      selectedDish.steps[index],
                    ),
                  ),
                  Divider(),
                ],
              ),
              itemCount: selectedDish.steps.length,
            ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => toggleFavorite(dishId),
        child: Icon(
          isFavorite(dishId) ? Icons.star : Icons.star_border,
        ),
      ),
    );
  }
}
