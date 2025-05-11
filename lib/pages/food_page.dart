import 'package:flutter/material.dart';
import 'package:foodappp/components/favorite.dart';
import 'package:foodappp/components/my_button.dart';
import 'package:foodappp/components/my_sliver_app_bar.dart';
import 'package:foodappp/models/food.dart';
import 'package:foodappp/models/restaurants.dart';
import 'package:provider/provider.dart';

class FoodPage extends StatefulWidget {
  final Food food;

  const FoodPage({super.key, required this.food});

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  late Map<Addon, bool> selectedAddons;

  @override
  void initState() {
    super.initState();
    selectedAddons = {
      for (var addon in widget.food.availableAddons) addon: false
    };
  }

  void addToCart() {
    Navigator.pop(context);
    List<Addon> currentlySelectedAddons = [];

    for (var addon in widget.food.availableAddons) {
      if (selectedAddons[addon] == true) {
        currentlySelectedAddons.add(addon);
      }
    }

    context.read<Restaurants>().addToCart(widget.food, currentlySelectedAddons);
  }
@override
Widget build(BuildContext context) {
  return Scaffold(
    body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(widget.food.imagePath),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: CustomLikeButton(),
                    ),
                     Positioned(
                      top: 10,
                      left: 10,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back_ios_rounded),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  widget.food.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Text(
                  '₵${widget.food.price}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 10),
                Text(widget.food.description),
                const SizedBox(height: 10),
                Divider(color: Theme.of(context).colorScheme.secondary),
                const SizedBox(height: 10),
                Text(
                  "Add-ons",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: widget.food.availableAddons.length,
                    itemBuilder: (context, index) {
                      Addon addon = widget.food.availableAddons[index];
                      return CheckboxListTile(
                        title: Text(addon.name),
                        subtitle: Text(
                          '₵${addon.price}',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        value: selectedAddons[addon],
                        onChanged: (bool? value) {
                          setState(() {
                            selectedAddons[addon] = value!;
                          });
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                MyButton(
                  onTap: addToCart,
                  text: "Add to Cart",
                  onTop: () {},
                ),
                const SizedBox(height: 25),
              ],
            ),
          ),
        ],
      ),
    ),
    
  );
}
}






// import 'package:flutter/material.dart';
// import 'package:foodappp/components/my_button.dart';
// import 'package:foodappp/models/food.dart';
// import 'package:foodappp/models/restaurants.dart';
// import 'package:provider/provider.dart';
//
// class FoodPage extends StatefulWidget {
//   final Food food;
//   final Map<Addon, bool> selectedAddons = {};
//
//   FoodPage({super.key, required this.food}) {
//     for (Addon addon in food.availableAddons) {
//       selectedAddons[addon] = false;
//     }
//   }
//
//   @override
//   State<FoodPage> createState() => _FoodPageState();
// }
//
// class _FoodPageState extends State<FoodPage> {
//   void addToCart(Food food, Map<Addon, bool> selectedAddons) {
//     Navigator.pop(context);
//
//     List<Addon> currentlySelectedAddons = [];
//     for (Addon addon in widget.food.availableAddons) {
//       if (widget.selectedAddons[addon] == true) {
//         currentlySelectedAddons.add(addon);
//       }
//     }
//
//     context.read<Restaurants>().addToCart(food, currentlySelectedAddons);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Scaffold(
//           body: SingleChildScrollView(
//             child: Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(25.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Image.asset(widget.food.imagePath),
//                       const SizedBox(height: 10),
//                       Text(
//                         widget.food.name,
//                         style: const TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 20,
//                         ),
//                       ),
//                       Text(
//                         '₵${widget.food.price}',
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Theme.of(context).colorScheme.primary,
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       Text(widget.food.description),
//                       const SizedBox(height: 10),
//                       Divider(color: Theme.of(context).colorScheme.secondary),
//                       const SizedBox(height: 10),
//                       Text(
//                         "Add-ons",
//                         style: TextStyle(
//                           color: Theme.of(context).colorScheme.inversePrimary,
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       Container(
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                             color: Theme.of(context).colorScheme.secondary,
//                           ),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: ListView.builder(
//                           shrinkWrap: true,
//                           physics: const NeverScrollableScrollPhysics(),
//                           padding: EdgeInsets.zero,
//                           itemCount: widget.food.availableAddons.length,
//                           itemBuilder: (context, index) {
//                             Addon addon = widget.food.availableAddons[index];
//                             return CheckboxListTile(
//                               title: Text(addon.name),
//                               subtitle: Text(
//                                 '₵${addon.price}',
//                                 style: TextStyle(
//                                   color:
//                                       Theme.of(context).colorScheme.primary,
//                                 ),
//                               ),
//                               value: widget.selectedAddons[addon],
//                               onChanged: (bool? value) {
//                                 setState(() {
//                                   widget.selectedAddons[addon] = value!;
//                                 });
//                               },
//                             );
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 MyButton(
//                   onTap: () => addToCart(widget.food, widget.selectedAddons),
//                   text: "Add to Cart", onTop: () {  },
//                 ),
//                 const SizedBox(height: 25),
//               ],
//             ),
//           ),
//         ),
//         SafeArea(
//           child: Opacity(
//             opacity: 0.6,
//             child: Container(
//               margin: const EdgeInsets.only(left: 25),
//               decoration: BoxDecoration(
//                 color: Theme.of(context).colorScheme.secondary,
//                 shape: BoxShape.circle,
//               ),
//               child: IconButton(
//                 icon: const Icon(Icons.arrow_back_ios_rounded),
//                 onPressed: () => Navigator.pop(context),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }