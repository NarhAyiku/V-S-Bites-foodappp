// food item
class Food {
  final String name;           //cheese burger
  final String description;    // a very big cheese burger  with hot pepper like what women will show you!!!
  final String imagePath;      //lib/image/
  final String price;          //100
  final FoodCategory category; // burger
  List<Addon> availableAddons;  //[extra cheese and pepper ]

  Food({
    required this.name,
    required this.description,
    required this.imagePath,
    required this.price,
    required this.category,
    required this.availableAddons,
  });
}

// food categories
enum FoodCategory {

  Local,
  Continental,
  Salads,
  Sides,
  Drinks,
}

// food addons
class Addon{
  String name;
  double price;

  Addon({required this.name,
    required this.price,
  });
}