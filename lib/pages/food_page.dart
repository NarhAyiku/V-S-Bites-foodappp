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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.food.name),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: const Color.fromARGB(255, 0, 0, 0),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          CustomLikeButton(),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: AssetImage(widget.food.imagePath),
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.15),
                              BlendMode.darken,
                            ),
                          ),
                        ),
                      ),
                      // ClipRRect(
                      //   borderRadius: BorderRadius.circular(20),
                      //   child: Image.asset(widget.food.imagePath),
                      // ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: CustomLikeButton(),
                      ),
                      // Positioned(
                      //   top: 10,
                      //   left: 10,
                      //   child: IconButton(
                      //     color: Theme.of(context).colorScheme.secondary,
                      //     icon: const Icon(Icons.arrow_back_ios_rounded),
                      //     onPressed: () => Navigator.pop(context),
                      //   ),
                      // ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.food.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      Spacer(),
                      Icon(Icons.star, color: Colors.amber),
                      const SizedBox(width: 5),
                       Text(
                          '3.9 (Ratings)',
                          style: TextStyle(
                            color: const Color.fromARGB(255, 0, 0, 0),
                            fontSize: 15,
                          ),
                        ),
                        
                    ],
                  ),
                  SizedBox(height: 2),
                  Row(
                    children: [
                        // Spacer(),
                       Text(
                        'Price: ₵${widget.food.price}',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      Spacer(),
                         Text(
                        '₵200',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          decoration: TextDecoration.lineThrough,
                        ),
                        ),
                    
                    ],
                  ),
                  const SizedBox(height: 10),
                   Divider(color: Theme.of(context).colorScheme.secondary),
                  Text('Description',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )),
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
                  Column(
                    children: [
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
                                contentPadding: const EdgeInsets.symmetric(horizontal: 12, ),
                                  controlAffinity: ListTileControlAffinity.leading, // checkbox on the left
                               checkboxShape: const CircleBorder(),
                            value: selectedAddons[addon],
                            onChanged: (bool? value) {
                              setState(() {
                                selectedAddons[addon] = value!;
                              });
                            },
                            shape: const CircleBorder(),
                            activeColor: Colors.orange, // red when selected
                            checkColor: Colors.white, // tick color
                          );
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  // Center(
                  //   child: Column(
                  //     children: [
                  //       Image.asset(
                  //         'assets/images/Continental/vlogo.png',
                  //         width: 200,
                  //         height: 200,
                  //       ),
                  //       Text(
                  //         'No Add-Ons',
                  //       ),
                  //     ],
                  //   ),
                  // )
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 100,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '₵${widget.food.price}',
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              SizedBox(
                width: 250,
                child: MyButton(
                  onTap: addToCart,
                  text: "Add to Cart",
                  onTop: () {},
                ),
              ),
            ],
          ),
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