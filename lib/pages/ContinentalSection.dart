import 'package:flutter/material.dart';
import 'package:foodappp/components/my_food_tile.dart';
import 'package:foodappp/models/food.dart';
import 'package:foodappp/pages/foodcart.dart';
import '../pages/food_page.dart';

class ContinentalSection extends StatelessWidget {
  final List<Food> fullMenu;
  final String searchQuery;

  const ContinentalSection({
    Key? key,
    required this.fullMenu,
    this.searchQuery = '',
  }) : super(key: key);

  List<Food> _filterByCategory(List<Food> menu) {
    return menu.where((food) => food.category == FoodCategory.Continental).toList();
  }

  List<Food> _filterFoodItems(List<Food> foods, String query) {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return foods;

    return foods.where((food) {
      return food.name.toLowerCase().contains(q) ||
          food.description.toLowerCase().contains(q) ||
          food.category.name.toLowerCase().contains(q);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final categoryMenu = _filterByCategory(fullMenu);
    final filteredMenu = _filterFoodItems(categoryMenu, searchQuery);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Text(
            'Continental',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        ListView.builder(
          scrollDirection: Axis.vertical,
          physics: const NeverScrollableScrollPhysics(), // so it plays well inside another scroll view
          shrinkWrap: true, // important
          itemCount: filteredMenu.length,
          itemBuilder: (context, index) {
            final food = filteredMenu[index];
            return TweenAnimationBuilder(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: Duration(milliseconds: 400 + (index * 100)),
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(0, 20 * (1 - value)),
                  child: Opacity(
                    opacity: value,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: FoodCard(
                        food: food,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FoodPage(food: food),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
