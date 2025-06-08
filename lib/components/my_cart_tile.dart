import 'package:flutter/material.dart';
import 'package:foodappp/components/my_quantity_selector.dart';
import 'package:foodappp/models/cart_item.dart';
import 'package:foodappp/models/restaurants.dart';
import 'package:provider/provider.dart';

class MyCartTile extends StatelessWidget {
  final CartItem cartItem;

  const MyCartTile({
    super.key,
    required this.cartItem,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Consumer<Restaurants>(
      builder: (context, restaurants, child) => Container(
        decoration: BoxDecoration(
          color: colorScheme.secondary,
          borderRadius: BorderRadius.circular(8),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: Column(
          children: [
            // Food Info
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(9),
                    child: Image.asset(
                      cartItem.food.imagePath,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),

                  const SizedBox(width: 10),

                  // Name + Price
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(cartItem.food.name,
                          style: theme.textTheme.titleMedium),
                      const SizedBox(height: 4),
                      Text(
                        '₵${cartItem.food.price}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.primary,
                        ),
                      ),

                      const SizedBox(height: 10),

<<<<<<< HEAD
                      // Quantity Controls
                      QuantitySelector(
                        quantity: cartItem.quantity,
                        food: cartItem.food,
                        onDecrement: () {
                          restaurants.removeFromCart(cartItem);
                        },
                        onIncrement: () {
                          restaurants.addToCart(
                              cartItem.food, cartItem.selectedAddons);
                        },
                      ),
=======

                      // Quantity Controls
                  QuantitySelector(
                    quantity: cartItem.quantity,
                    food: cartItem.food,
                    onDecrement: () {
                      restaurants.removeFromCart(cartItem);
                    },
                    onIncrement: () {
                      restaurants.addToCart(
                          cartItem.food, cartItem.selectedAddons);
                    },
                  ),
>>>>>>> 7d254673eea77aca16eeeb906fa5155b870e92e7
                    ],
                  ),
                ],
              ),
            ),

            // Add-ons (only visible if any)
            if (cartItem.selectedAddons.isNotEmpty)
              SizedBox(
                height: 60,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding:
                      const EdgeInsets.only(left: 10, bottom: 10, right: 10),
                  children: cartItem.selectedAddons.map((addon) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: FilterChip(
                        label: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(addon.name),
                            const SizedBox(width: 4),
                            Text('(₵${addon.price})'),
                          ],
                        ),
                        shape: StadiumBorder(
                          side: BorderSide(color: colorScheme.primary),
                        ),
                        onSelected: (_) {},
                        backgroundColor: colorScheme.secondary,
                        labelStyle: TextStyle(
                          color: colorScheme.inversePrimary,
                          fontSize: 12,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}


  //       import 'package:flutter/material.dart';
  //       import 'package:foodappp/components/my_quantity_selector.dart';
  //       import 'package:foodappp/models/cart_item.dart';
  //       import 'package:foodappp/models/restaurants.dart';
  //       import 'package:provider/provider.dart';


  //  class MyCartTile extends StatelessWidget {
  //    final CartItem cartItem;

  //    const MyCartTile({
  //      super.key,
  //      required this.cartItem,
  //    });

  //    @override
  //    Widget build(BuildContext context) {
  //      return Consumer <Restaurants>(
  //       builder: (context, restaurants, child) => Container(
  //         decoration: BoxDecoration(
  //           color: Theme.of(context).colorScheme.secondary,
  //           borderRadius: BorderRadius.circular(8),
  //         ),
  //         margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
  //         child: Column(
  //           children: [
  //             Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: Row(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   //food image
  //                   ClipRRect(
  //                     borderRadius: BorderRadius.circular(8),
  //                     child: Image.asset(cartItem.food.imagePath,
  //                       width: 100,
  //                       height: 100,
  //                     ),
  //                   ),
                
  //                   const SizedBox(width: 10,),
                
  //                   // name and price
  //                   Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children:[
  //                       // food name
  //                       Text(cartItem.food.name),
                
  //                       // food price
  //                       Text('\₵'+ cartItem.food.price.toString(),
  //                        style: TextStyle(
  //                         fontWeight: FontWeight.bold,
  //                         color: Theme.of(context).colorScheme.primary),
  //                     ),
                
                
  //                     ],
  //                   ),

  //                   const Spacer(),

  //                   // increment or decrement quantity
  //                   QuantitySelector(
  //                     quantity: cartItem.quantity,
  //                     food: cartItem.food, 
  //                     onDecrement: () {
  //                       restaurants.removeFromCart(cartItem);
  //                     },
  //                     onIncrement: () {
  //                       restaurants.addToCart(cartItem.food,cartItem.selectedAddons);
  //                     },
  //                     ),
  //                 ],
  //                 ),
  //             ),


  //                 //addons
  //                 SizedBox(
  //                   height: cartItem.selectedAddons.isEmpty ? 0 : 60,
  //                   child: ListView(
  //                     scrollDirection: Axis.horizontal,
  //                     padding: const EdgeInsets.only(left: 10, bottom: 10, right: 10),
  //                     children: cartItem.selectedAddons
  //                     .map((addon) => Padding(
  //                       padding: const EdgeInsets.only(right: 8.0),
  //                       child: FilterChip(
  //                         label: Row(
  //                         children: [
  //                           // addon name 
  //                           Text(addon.name),
                        
  //                           // addon price
  //                           Text('(₵{addon.price})'),
                        
  //                          ],
  //                         ),
  //                         shape: const StadiumBorder(
  //                           side: BorderSide(
  //                             color: Theme.of(context).colorScheme.primary,)),
  //                        onSelected: (value){},
  //                         backgroundColor: 
  //                           Theme.of(context).colorScheme.secondary,
  //                         labelStyle: TextStyle(
  //                           color: Theme.of(context).colorScheme.inversePrimary,
  //                           fontSize: 12,
  //                         ),
  //                        ),
  //                     ),
  //                      )
  //                      .toList(),
  //                   ),
  //                   ),


  //         ],),
  //       ),
  //       );
       
  //    }
  //  }