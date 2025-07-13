// lib/pages/category_page.dart

import 'package:flutter/material.dart';
import 'package:foodappp/models/food.dart';
import 'package:foodappp/pages/food_page.dart';
import 'package:foodappp/pages/foodcart.dart';

class CategoryPage extends StatelessWidget {
  final FoodCategory category;
  final List<Food> fullMenu;

  const CategoryPage({
    Key? key,
    required this.category,
    required this.fullMenu,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filtered = fullMenu
        .where((food) => food.category == category)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(category.name),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: filtered.length,
        itemBuilder: (context, index) {
          final food = filtered[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: FoodCard(
              food: food,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FoodPage(food: food),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
