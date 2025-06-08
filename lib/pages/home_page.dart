import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:foodappp/components/PromoCard.dart';
import 'package:foodappp/components/my_food_tile.dart';
import 'package:foodappp/components/my_sliver_app_bar.dart';
import 'package:foodappp/models/food.dart';
import 'package:foodappp/models/restaurants.dart';
import 'package:foodappp/pages/cart_page.dart';
import 'package:foodappp/pages/food_page.dart';
import 'package:foodappp/pages/foodcart.dart';
import 'package:provider/provider.dart';

import 'FoodSearchBar.dart';

=======
import 'package:foodappp/components/my_current_location.dart';
import 'package:foodappp/components/my_description_box.dart';
import 'package:foodappp/components/my_drawer.dart';
import 'package:foodappp/components/my_food_tile.dart';
import 'package:foodappp/components/my_sliver_app_bar.dart';
import 'package:foodappp/components/my_tab_bar.dart';
import 'package:foodappp/models/food.dart';
import 'package:foodappp/models/restaurants.dart';
import 'package:foodappp/pages/food_page.dart';
import 'package:provider/provider.dart';

>>>>>>> 7d254673eea77aca16eeeb906fa5155b870e92e7
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  // Tab controller
  late TabController _tabController;
<<<<<<< HEAD
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
=======
>>>>>>> 7d254673eea77aca16eeeb906fa5155b870e92e7

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: FoodCategory.values.length, vsync: this);
  }

<<<<<<< HEAD
  List<Food> _filterFoodItems(List<Food> foods, String query) {
    if (query.isEmpty) return foods;

    return foods.where((food) {
      return food.name.toLowerCase().contains(query.toLowerCase()) ||
          food.description.toLowerCase().contains(query.toLowerCase()) ||
          food.category.toString().toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

=======
>>>>>>> 7d254673eea77aca16eeeb906fa5155b870e92e7
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
<<<<<<< HEAD
    _searchController.dispose();
=======
  }

  // Sort out and return a list of food items that belong to a specific category
  List<Food> _filterMenuByCategory(FoodCategory category, List<Food> fullMenu) {
    return fullMenu.where((food) => food.category == category).toList();
  }

  // return list of food items in a given category
  List<Widget> getFoodInThisCategory(List<Food> fullMenu) {
    return FoodCategory.values.map((category) {

      // get category menu
      List<Food> categoryMenu = _filterMenuByCategory(category, fullMenu);

      return ListView.builder(
        itemCount: categoryMenu.length,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          // get individual food
          final food = categoryMenu [index];

          // return food tile UI
          return FoodTile(food: food,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FoodPage(food: food),
              ),
            ),
            // imagePath: 'assets/images/cheese_burger.png',
          );
        },
      );
    }).toList();
>>>>>>> 7d254673eea77aca16eeeb906fa5155b870e92e7
  }

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return Consumer<Restaurants>(
      builder: (context, restaurants, child) {
        final userCart = restaurants.cart;

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Theme.of(context).colorScheme.background,
            foregroundColor: Theme.of(context).colorScheme.inversePrimary,
            leading: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 10),
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage: AssetImage(
                        'assets/images/Continental/vlogo.png',
                      ),
                      radius: 18,
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CartPage(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.shopping_cart),
                    ),
                  ),
                  if (userCart.isNotEmpty)
                    Positioned(
                      right: 10,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 20,
                          minHeight: 20,
                        ),
                        child: Text(
                          '${userCart.length}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              )
            ],
          ),
          // drawer: MyDrawer(),
          // body: NestedScrollView(
          //   headerSliverBuilder: (context, innerBoxIsScrolled) => [
          //     MySliverAppBar(
          //       title: MyTabBar(tabController: _tabController),
          //       child: Column(
          //         mainAxisAlignment: MainAxisAlignment.end,
          //         children: [
          //           // Divider(
          //           //   indent: 25,
          //           //   endIndent: 25,
          //           //   color: Theme.of(context).colorScheme.secondary,
          //           // ),
          //           // My current location
          //           Padding(
          //             padding: const EdgeInsets.all(30.0),
          //             child: PromoCard(),
          //           ),
          //           // const MyCurrentLocation(),
          //           // Description box

          //           // Delivery bracket
          //           // const MyDescriptionBox(),
          //         ],
          //       ),
          //     ),
          // ],

          body: Consumer<Restaurants>(
            builder: (context, restaurants, child) {
              return ListView(
                children: [
                  for (var category in FoodCategory.values) ...[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: PromoCard(),
                        ),
                        FoodSearchBar(
                          searchController: _searchController,
                          onSearch: (query) {
                            setState(() {
                              _searchQuery = query;
                            });
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: Row(
                            children: [
                              Text(
                                category.toString().split('.').last,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              Spacer(),
                              // Text(
                              //   'see more',
                              //   style: Theme.of(context)
                              //       .textTheme
                              //       .headlineSmall
                              //       ?.copyWith(
                              //         fontSize: 12,
                              //         color: const Color.fromARGB(
                              //             255, 214, 100, 38),
                              //         fontWeight: FontWeight.bold,
                              //       ),
                              // ),
                              SizedBox(width: 4),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 13,
                                color: const Color.fromARGB(255, 214, 100, 38),
                              ),
                            ],
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true, // Add this
                          physics:
                              const NeverScrollableScrollPhysics(), // Add this
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount:
                              _filterMenuByCategory(category, restaurants.menu)
                                  .length,
                          itemBuilder: (context, index) {
                            final food = _filterMenuByCategory(
                                category, restaurants.menu)[index];
                            return TweenAnimationBuilder(
                              tween: Tween(begin: 0.0, end: 1.0),
                              duration:
                                  Duration(milliseconds: 400 + (index * 100)),
                              builder: (context, value, child) {
                                return Transform.translate(
                                  offset: Offset(0, 20 * (1 - value)),
                                  child: Opacity(
                                    opacity: value,
                                    child: FoodCard(
                                      food: food,
                                      onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              FoodPage(food: food),
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
                    ),
                  ],
                ],
              );
            },
          ),
          // body: Consumer<Restaurants>(
          //   builder: (context, restaurants, child) => TabBarView(
          //     controller: _tabController,
          //     children: getFoodInThisCategory(restaurants.menu),
          //   ),
          // ),
        );
      },
    );
  }
}

// Sort out and return a list of food items that belong to a specific category
List<Food> _filterMenuByCategory(FoodCategory category, List<Food> fullMenu) {
  return fullMenu.where((food) => food.category == category).toList();
}

// // return list of food items in a given category
// List<Widget> getFoodInThisCategory(List<Food> fullMenu) {
//   return FoodCategory.values.map((category) {
//     // get category menu
//     List<Food> categoryMenu = _filterMenuByCategory(category, fullMenu);

//     return ListView.builder(
//       itemCount: categoryMenu.length,
//       padding: EdgeInsets.zero,
//       physics: const NeverScrollableScrollPhysics(),
//       itemBuilder: (context, index) {
//         // get individual food
//         final food = categoryMenu[index];

//         // return food tile UI
//         return FoodTile(
//           food: food,
//           onTap: () => Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => FoodPage(food: food),
//             ),
//           ),
//           // imagePath: 'assets/images/cheese_burger.png',
//         );
//       },
//     );
//   }).toList();
// }

List<Widget> getFoodInThisCategory(List<Food> fullMenu) {
  return FoodCategory.values.map((category) {
    // get category menu
    List<Food> categoryMenu = _filterMenuByCategory(category, fullMenu);

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                // get individual food
                final food = categoryMenu[index];

                // Add staggered animation
                return TweenAnimationBuilder(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: Duration(milliseconds: 600 + (index * 100)),
                  builder: (context, value, child) {
                    return Transform.translate(
                      offset: Offset(0, 50 * (1 - value)),
                      child: Opacity(
                        opacity: value,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  offset: const Offset(0, 4),
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            child: FoodTile(
                              food: food,
                              onTap: () {
                                // Add scale animation on tap
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FoodPage(food: food),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              childCount: categoryMenu.length,
            ),
          ),
        ),
      ],
    );
  }).toList();
}
=======
    return Scaffold(
      drawer: MyDrawer(),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          MySliverAppBar(
            title: MyTabBar(tabController: _tabController),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Divider(
                  indent: 25,
                  endIndent: 25,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                // My current location
                const MyCurrentLocation(),
                // Description box
                const MyDescriptionBox(),
              ],
            ),
          ),
        ],
        body: Consumer<Restaurants>(
          builder: (context, restaurants, child) => TabBarView(
            controller: _tabController,
            children: getFoodInThisCategory(restaurants.menu),
          ),
        ),
      ),
    );
  }
}
>>>>>>> 7d254673eea77aca16eeeb906fa5155b870e92e7
