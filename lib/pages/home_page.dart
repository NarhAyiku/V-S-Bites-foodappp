import 'package:flutter/material.dart';
import 'package:foodappp/components/PromoCard.dart';
import 'package:foodappp/components/my_food_tile.dart';
import 'package:foodappp/components/my_sliver_app_bar.dart';
import 'package:foodappp/models/food.dart';
import 'package:foodappp/models/restaurants.dart';
import 'package:foodappp/pages/ContinentalSection.dart';
import 'package:foodappp/pages/cart_page.dart';
import 'package:foodappp/pages/food_page.dart';
import 'package:foodappp/pages/foodcart.dart';
import 'package:provider/provider.dart';

import 'FoodSearchBar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  // Tab controller
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: FoodCategory.values.length, vsync: this);
  }

  List<Food> _filterFoodItems(List<Food> foods, String query) {
    if (query.isEmpty) return foods;

    return foods.where((food) {
      return food.name.toLowerCase().contains(query.toLowerCase()) ||
          food.description.toLowerCase().contains(query.toLowerCase()) ||
          food.category.toString().toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Restaurants>(
      builder: (context, restaurants, child) {
        final userCart = restaurants.cart;

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: Theme.of(context).colorScheme.background,
            foregroundColor: Theme.of(context).colorScheme.inversePrimary,
            // leading: Padding(
            //   padding: const EdgeInsets.all(10.0),
            //   child: Column(
            //     children: [
            //       Container(
            //         padding: const EdgeInsets.only(left: 10),
            //         child: CircleAvatar(
            //           backgroundColor: Colors.transparent,
            //           backgroundImage: AssetImage(
            //             'assets/images/Continental/vlogo.png',
            //           ),
            //           radius: 18,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
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
         body: Consumer<Restaurants>(
  builder: (context, restaurants, child) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
     
          const Padding(
            padding: EdgeInsets.only(left:20.0, right: 20),
            child: PromoCard(),
          ),
               SizedBox(height: 20),
          // SpecialOffers(),

          // ContinentalSection(
          //   fullMenu: restaurants.menu,
          // ),
          SpecialOffers(),
          for (var category in FoodCategory.values) ...[
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                category.name,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            
            const SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount:
                  _filterMenuByCategory(category, restaurants.menu).length,
              itemBuilder: (context, index) {
                final food = _filterMenuByCategory(
                    category, restaurants.menu)[index];

                return TweenAnimationBuilder(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: Duration(milliseconds: 400 + (index * 100)),
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
                              builder: (context) => FoodPage(food: food),
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

          
        ],
      ),
    );
  },
),

       
        );
      },
    );
  }
}

// Sort out and return a list of food items that belong to a specific category
List<Food> _filterMenuByCategory(FoodCategory category, List<Food> fullMenu) {
  return fullMenu.where((food) => food.category == category).toList();
}

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





class SpecialOfferCard extends StatelessWidget {
  const SpecialOfferCard({
    Key? key,
    required this.category,
    required this.image,
    required this.numOfBrands,
    required this.press,
  }) : super(key: key);

  final String category, image;
  final int numOfBrands;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: GestureDetector(
        onTap: press,
        child: SizedBox(
          width: 342,
          height: 150,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Stack(
              children: [
                Image.asset(
                  image,
                  fit: BoxFit.cover,
                  height: 150,
                ),
                Container(
                  decoration: const BoxDecoration(
                    // gradient: LinearGradient(
                    //   begin: Alignment.topCenter,
                    //   end: Alignment.bottomCenter,
                    //   colors: [
                    //     Colors.black54,
                    //     Colors.black38,
                    //     Colors.black38,
                    //     Colors.black38,
                    //   ],
                    // ),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(
                //     horizontal: 15,
                //     vertical: 10,
                //   ),
                //   child: Text.rich(
                //     TextSpan(
                //       style: const TextStyle(color: Colors.white),
                //       children: [
                //         TextSpan(
                //           text: "$category\n",
                //           style: const TextStyle(
                //             fontSize: 18,
                //             fontWeight: FontWeight.bold,
                //           ),
                //         ),
                //         TextSpan(text: "$numOfBrands Brands")
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key? key,
    required this.title,
    required this.press,
  }) : super(key: key);

  final String title;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
           style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
        ),
        // TextButton(
        //   onPressed: press,
        //   style: TextButton.styleFrom(foregroundColor: Colors.grey),
        //   child: const Text("See more"),
        // ),
      ],
    );
  }
}



class SpecialOffers extends StatelessWidget {
  const SpecialOffers({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 20),
        //   child: SectionTitle(
        //     title: "Special for you",
        //     press: () {},
        //   ),
        // ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SpecialOfferCard(
                image: "assets/images/Local/2025-07-13 18.24.37.jpg",
                category: "Fashion",
                numOfBrands: 24,
                press: () {},
              ),
              SpecialOfferCard(
                image: "assets/images/Local/2025-07-13 20.13.56.png",
                category: "Smartphone",
                numOfBrands: 18,
                press: () {},
              ),
              
              const SizedBox(width: 20),
            ],
          ),
        ),
      ],
    );
  }
}