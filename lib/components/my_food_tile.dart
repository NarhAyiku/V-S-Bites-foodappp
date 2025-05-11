import 'package:flutter/material.dart';
import '../models/food.dart';

class FoodTile extends StatelessWidget {
  final Food food;
  final void Function()? onTap;

  const FoodTile({
    super.key,
    required this.food,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap?.call, // Properly handling nullable function
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                // Text food details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // Align text to left
                    children: [
                      Text(food.name,),
                      Text(
                        '₵' + food.price.toString(),
                        style: TextStyle( color:Theme.of(context).colorScheme.primary),
                      ),
                      Text(
                        food.description,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary),
                      ),
                    ],
                  ),
                ),
            
                const SizedBox(width: 10),
            
                // Food image
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(food.imagePath, height: 120, fit: BoxFit.cover),
                ),
              ],
            ),
          ),
        ),

        // Divider line
        Divider(
          color: Theme.of(context).colorScheme.tertiary,
          endIndent: 25,
          indent: 25,
        ),
      ],
    );
  }
}
