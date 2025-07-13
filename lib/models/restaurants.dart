// import 'package:collection/collection.dart';
// import 'package:flutter/material.dart';
// import 'package:foodappp/models/cart_item.dart';
// import 'package:intl/intl.dart';
// import 'food.dart';

// class Restaurants extends ChangeNotifier {
//   // list of food menu
//   final List<Food> _menu = [
//     // Local
//     Food(
//       name: "Abom",
//       description: "Traditional Ghanaian garden egg stew.",
//       imagePath: "assets/images/Local/abom.png",
//       price: '100',
//       category: FoodCategory.Local,
//       availableAddons: [
//         Addon(name: "Extra Koobi", price: 20),
//         Addon(name: "Hard Boiled Egg", price: 15),
//         Addon(name: "Avocado Slices", price: 10),
//       ],
//     ),
//     Food(
//       name: "Jollof",
//       description: "West African Jollof Rice — bold and spicy.",
//       imagePath: "assets/images/Local/jollof2.png",
//       price: '100',
//       category: FoodCategory.Local,
//       availableAddons: [
//         Addon(name: "Extra Shito", price: 10),
//         Addon(name: "Fried Egg", price: 15),
//         Addon(name: "Grilled Chicken", price: 40),
//       ],
//     ),
//     Food(
//       name: "Friedrice",
//       description: "Golden fried rice, rich with flavor.",
//       imagePath: "assets/images/Local/friedrice1.png",
//       price: '100',
//       category: FoodCategory.Local,
//       availableAddons: [
//         Addon(name: "Extra Chicken", price: 35),
//         Addon(name: "Shrimp", price: 30),
//         Addon(name: "Mixed Vegetables", price: 15),
//       ],
//     ),
//     Food(
//       name: "Banku and Okro",
//       description: "Soft banku paired with slippery okro soup.",
//       imagePath: "assets/images/Local/bankuandokro.png",
//       price: '100',
//       category: FoodCategory.Local,
//       availableAddons: [
//         Addon(name: "Extra Okro", price: 10),
//         Addon(name: "Tilapia", price: 50),
//         Addon(name: "Cow Foot", price: 25),
//       ],
//     ),
//     Food(
//       name: "Kenkey Platter",
//       description: "Kenkey served with fish and shito.",
//       imagePath: "assets/images/Local/kenkeyplatter.png",
//       price: '100',
//       category: FoodCategory.Local,
//       availableAddons: [
//         Addon(name: "Extra Shito", price: 10),
//         Addon(name: "Fried Fish", price: 45),
//         Addon(name: "Slices of Avocado", price: 10),
//       ],
//     ),

//     // Continental
//     Food(
//       name: "Beef Burritos",
//       description: "Beef Burritos with hot pepper!!!",
//       imagePath: "assets/images/Continental/Beef_Burritos.png",
//       price: '100',
//       category: FoodCategory.Continental,
//       availableAddons: [
//         Addon(name: "Extra cheese", price: 50),
//         Addon(name: "Bacon", price: 60),
//         Addon(name: "Avocado", price: 70),
//       ],
//     ),
//     Food(
//       name: "Tacos",
//       description: "with hot pepper like what women will show you!!!",
//       imagePath: "assets/images/Continental/Tacos.png",
//       price: '100',
//       category: FoodCategory.Continental,
//       availableAddons: [
//         Addon(name: "Extra cheese", price: 50),
//         Addon(name: "Bacon", price: 60),
//         Addon(name: "Avocado", price: 70),
//       ],
//     ),
//     Food(
//       name: "Pasta",
//       description: "A classic pasta with rich Italian sauce!",
//       imagePath: "assets/images/Continental/Pasta.png",
//       price: '100',
//       category: FoodCategory.Continental,
//       availableAddons: [
//         Addon(name: "Extra cheese", price: 50),
//         Addon(name: "Bacon", price: 60),
//         Addon(name: "Avocado", price: 70),
//       ],
//     ),
//     Food(
//       name: "Sushi",
//       description: "Fresh sushi rolls for your taste adventure.",
//       imagePath: "assets/images/Continental/Sushii.png",
//       price: '100',
//       category: FoodCategory.Continental,
//       availableAddons: [
//         Addon(name: "Extra wasabi", price: 50),
//         Addon(name: "Soy sauce", price: 60),
//         Addon(name: "Pickled ginger", price: 70),
//       ],
//     ),
//     Food(
//       name: "Lasangna",
//       description: "Layered pasta, cheese, and rich meat sauce!",
//       imagePath: "assets/images/Continental/Lasangna.png",
//       price: '100',
//       category: FoodCategory.Continental,
//       availableAddons: [
//         Addon(name: "Extra cheese", price: 50),
//         Addon(name: "Bacon", price: 60),
//         Addon(name: "Avocado", price: 70),
//       ],
//     ),

//     // Salads
//     Food(
//       name: "Garden Salad",
//       description: "Fresh and crispy garden salad.",
//       imagePath: "assets/images/Salads/salad4.png",
//       price: '50',
//       category: FoodCategory.Salads,
//       availableAddons: [],
//     ),
//     Food(
//       name: "Green Vinaigrette Salad",
//       description: "Healthy green salad with vinaigrette.",
//       imagePath: "assets/images/Salads/salad3.png",
//       price: '100',
//       category: FoodCategory.Salads,
//       availableAddons: [],
//     ),
//     Food(
//       name: "Greek Salad",
//       description:
//           "A refreshing mix of cucumbers, tomatoes, feta cheese, and olives.",
//       imagePath: "assets/images/Salads/salad4.png",
//       price: '120',
//       category: FoodCategory.Salads,
//       availableAddons: [],
//     ),
//     Food(
//       name: "Caesar Salad",
//       description:
//           "Crisp romaine lettuce tossed with parmesan, croutons, and Caesar dressing.",
//       imagePath: "assets/images/Salads/salad4.png",
//       price: '130',
//       category: FoodCategory.Salads,
//       availableAddons: [],
//     ),
//     Food(
//       name: "Fruit Salad",
//       description: "A colorful mix of seasonal fruits, fresh and juicy.",
//       imagePath: "assets/images/Salads/salad4.png",
//       price: '90',
//       category: FoodCategory.Salads,
//       availableAddons: [],
//     ),

//     // Sides
//     Food(
//       name: "Grilled Fish",
//       description: "Perfectly seasoned grilled fish.",
//       imagePath: "assets/images/Sides/grilledfish.png",
//       price: '100',
//       category: FoodCategory.Sides,
//       availableAddons: [],
//     ),
//     Food(
//       name: "Side",
//       description: "A tasty side to complement any meal.",
//       imagePath: "assets/images/Sides/side.png",
//       price: '100',
//       category: FoodCategory.Sides,
//       availableAddons: [],
//     ),
//     Food(
//       name: "Fried Chicken",
//       description: "Crispy, juicy fried chicken.",
//       imagePath: "assets/images/Sides/friedchicken.png",
//       price: '100',
//       category: FoodCategory.Sides,
//       availableAddons: [],
//     ),
//     Food(
//       name: "Fried Fish",
//       description: "Golden-battered fried fish.",
//       imagePath: "assets/images/Sides/friedfish.png",
//       price: '100',
//       category: FoodCategory.Sides,
//       availableAddons: [],
//     ),
//     Food(
//       name: "Grilled Chicken",
//       description: "Tender and smoky grilled chicken.",
//       imagePath: "assets/images/Sides/grilledchicken.png",
//       price: '100',
//       category: FoodCategory.Sides,
//       availableAddons: [],
//     ),

//     // Drinks
//     Food(
//       name: "Coke",
//       description: "Classic Coca-Cola, ice cold and refreshing.",
//       imagePath: "assets/images/Drinks/coke.png",
//       price: '100',
//       category: FoodCategory.Drinks,
//       availableAddons: [],
//     ),
//     Food(
//       name: "Coconut Water",
//       description: "Pure and natural coconut water.",
//       imagePath: "assets/images/Drinks/coconutwater.png",
//       price: '100',
//       category: FoodCategory.Drinks,
//       availableAddons: [],
//     ),
//     Food(
//       name: "Lemonade",
//       description: "Freshly squeezed lemonade with a zesty punch.",
//       imagePath: "assets/images/Drinks/lemonade.png",
//       price: '100',
//       category: FoodCategory.Drinks,
//       availableAddons: [],
//     ),
//     Food(
//       name: "Lemonade",
//       description: "Another twist on the classic lemonade.",
//       imagePath: "assets/images/Drinks/lemonade2.png",
//       price: '100',
//       category: FoodCategory.Drinks,
//       availableAddons: [],
//     ),
//     Food(
//       name: "Fanta",
//       description: "Sweet, fizzy orange delight.",
//       imagePath: "assets/images/Drinks/fanta2.png",
//       price: '100',
//       category: FoodCategory.Drinks,
//       availableAddons: [],
//     ),
//   ];

// // user cart
//   final List<CartItem> _cart = [];

//   // delivery address (which user can manage later)
//   String _deliveryAddress = "Tema First Light";
//   /*

//           G E T T E R S

//            */
//   List<Food> get menu => _menu;
//   List<CartItem> get cart => _cart;
//   String get deliveryAddress => _deliveryAddress;

//   get successfulOrders => null;
//   /*

//           O P E R A T I O N S

//            */
//   // add to cart
//   void addToCart(Food food, List<Addon> selectedAddons) {
//     // see if there is a cart item already with the same food and selected addons
//     CartItem? cartItem = _cart.firstWhereOrNull((item) {
//       //check if food is the item are the same
//       bool isSameFood = item.food.name == food.name;

//       // check and if the list of selected addons are the same
//       bool isSameAddons =
//           const ListEquality().equals(item.selectedAddons, selectedAddons);

//       return isSameFood && isSameAddons;
//     });
//     // if the cart item already exists, increase the quantity
//     if (cartItem != null) {
//       cartItem.quantity++;
//     }
//     // otherwise, add a new cart item to the cart
//     else {
//       _cart.add(
//         CartItem(food: food, selectedAddons: selectedAddons),
//       );
//     }
//     notifyListeners();
//   }

//   // remove from cart
//   void removeFromCart(CartItem cartItem) {
//     int cartIdex = _cart.indexOf(cartItem);

//     if (cartIdex != 1) {
//       if (_cart[cartIdex].quantity >= 1) {
//         _cart[cartIdex].quantity--;
//       } else {
//         _cart.removeAt(cartIdex);
//       }
//     }

//     notifyListeners();
//   }

//   // get total price of cart
//   double getTotalPrice() {
//     double total = 0.0;

//     for (CartItem cartItem in _cart) {
//       // Parse the price string into a double, with a fallback to 0.0 if it's invalid
//       double itemPrice = double.tryParse(cartItem.food.price) ?? 0.0;

//       // Calculate the total for this cart item, including add-ons
//       double itemTotal = itemPrice;

//       for (Addon addon in cartItem.selectedAddons) {
//         itemTotal += addon.price;
//       }

//       total += itemTotal * cartItem.quantity;
//     }

//     return total;
//   }

//   // get total number of items in cart
//   int getTotalItemCount() {
//     int getTotalItemCount = 0;

//     for (CartItem cartItem in _cart) {
//       getTotalItemCount += cartItem.quantity;
//     }

//     return getTotalItemCount;
//   }

//   // clear cart
//   void clearCart() {
//     _cart.clear();
//     notifyListeners();
//   }

//   // update delivery address
//   void updateDeliveryAddress(String newAddress) {
//     _deliveryAddress = newAddress;
//     notifyListeners();
//   }

//   /*
//           H E L P E R S
//            */

//   // generate receipt
//   String displayCartReceipt(dynamic cartItem) {
//     final receipt = StringBuffer();
//     receipt.writeln("Here you GO!! Your receipt.");
//     receipt.writeln();

//     // format the date to include up to seconds only
//     String formattedDate =
//         DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

//     receipt.writeln(formattedDate);
//     receipt.writeln();
//     receipt.writeln("-----------");

//     for (final cartItem in _cart) {
//       // Changed variable name to avoid conflict
//       receipt.writeln(
//           "₵${cartItem.quantity} x ₵${cartItem.food.name} - ₵${_formatPrice(double.parse(cartItem.food.price))}");
//       SizedBox(height: 5);
//       if (cartItem.selectedAddons.isNotEmpty) {
//         receipt.writeln("  Add-ons:₵${_formatAddons(cartItem.selectedAddons)}");
//       }
//       receipt.writeln();
//     }

//     receipt.writeln("-----------");
//     receipt.writeln();
//     receipt.writeln("Total Item : ${getTotalItemCount()}");
//     receipt.writeln("Total Price : ₵${_formatPrice(getTotalPrice())}");
//     receipt.writeln();
//     receipt.writeln("Delivery to: $deliveryAddress");
//     return receipt.toString();
//   }

// // format double value into money
//   String _formatPrice(double price) {
//     return price.toStringAsFixed(2);
//   }

// // format list of addons into a string summary
//   String _formatAddons(List<Addon> addons) {
//     return addons
//         .map((addon) => "${addon.name} (₵${_formatPrice(addon.price)})")
//         .join(", ");
//   }

//   // String get totalPrice {
//   //   double addonsPrice =
//   //       selectedAddons.fold(0, (sum, addon) => sum + addon.price);
//   //   return (food.price + addonsPrice) * quantity;
//   // }
// }






import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:foodappp/models/cart_item.dart';
import 'package:intl/intl.dart';
import 'food.dart';

class Restaurants extends ChangeNotifier {
  // list of food menu
  final List<Food> _menu = [
    // Local
    Food(
      name: "Abom",
      description: "Traditional Ghanaian garden egg stew.",
      imagePath: "assets/images/Local/abom.png",
      price: '100',
      category: FoodCategory.Local,
      availableAddons: [
        Addon(name: "Extra Koobi", price: 20),
        Addon(name: "Hard Boiled Egg", price: 15),
        Addon(name: "Avocado Slices", price: 10),
        Addon(name: "Spicy Chili Drizzle", price: 5), // Cute Addon
        Addon(name: "Tiny Fried Plantains", price: 12), // Cute Addon
      ],
    ),
    Food(
      name: "Jollof",
      description: "West African Jollof Rice — bold and spicy.",
      imagePath: "assets/images/Local/jollof2.png",
      price: '100',
      category: FoodCategory.Local,
      availableAddons: [
        Addon(name: "Extra Shito", price: 10),
        Addon(name: "Fried Egg", price: 15),
        Addon(name: "Grilled Chicken", price: 40),
        Addon(name: "Mini Coleslaw Scoop", price: 8), // Cute Addon
        Addon(name: "Sweet Plantain Chips", price: 10), // Cute Addon
      ],
    ),
    Food(
      name: "Friedrice",
      description: "Golden fried rice, rich with flavor.",
      imagePath: "assets/images/Local/friedrice1.png",
      price: '100',
      category: FoodCategory.Local,
      availableAddons: [
        Addon(name: "Extra Chicken", price: 35),
        Addon(name: "Shrimp", price: 30),
        Addon(name: "Mixed Vegetables", price: 15),
        Addon(name: "Crispy Fried Onion Topping", price: 7), // Cute Addon
        Addon(name: "Sesame Seed Sprinkle", price: 5), // Cute Addon
      ],
    ),
    Food(
      name: "Banku and Okro",
      description: "Soft banku paired with slippery okro soup.",
      imagePath: "assets/images/Local/bankuandokro.png",
      price: '100',
      category: FoodCategory.Local,
      availableAddons: [
        Addon(name: "Extra Okro", price: 10),
        Addon(name: "Tilapia", price: 50),
        Addon(name: "Cow Foot", price: 25),
        Addon(name: "Diced Kpakpo Shito", price: 6), // Cute Addon
        Addon(name: "Fresh Tomato Garnish", price: 4), // Cute Addon
      ],
    ),
    Food(
      name: "Kenkey Platter",
      description: "Kenkey served with fish and shito.",
      imagePath: "assets/images/Local/kenkeyplatter.png",
      price: '100',
      category: FoodCategory.Local,
      availableAddons: [
        Addon(name: "Extra Shito", price: 10),
        Addon(name: "Fried Fish", price: 45),
        Addon(name: "Slices of Avocado", price: 10),
        Addon(name: "Pickled Onion Rings", price: 7), // Cute Addon
        Addon(name: "Lime Wedge", price: 3), // Cute Addon
      ],
    ),

    // Continental
    Food(
      name: "Beef Burritos",
      description: "Beef Burritos with hot pepper!!!",
      imagePath: "assets/images/Continental/Beef_Burritos.png",
      price: '100',
      category: FoodCategory.Continental,
      availableAddons: [
        Addon(name: "Extra cheese", price: 50),
        Addon(name: "Bacon", price: 60),
        Addon(name: "Avocado", price: 70),
        Addon(name: "Mini Sour Cream Dollop", price: 10), // Cute Addon
        Addon(name: "Tiny Jalapeño Slices", price: 8), // Cute Addon
      ],
    ),
    Food(
      name: "Tacos",
      description: "with hot pepper like what women will show you!!!",
      imagePath: "assets/images/Continental/Tacos.png",
      price: '100',
      category: FoodCategory.Continental,
      availableAddons: [
        Addon(name: "Extra cheese", price: 50),
        Addon(name: "Bacon", price: 60),
        Addon(name: "Avocado", price: 70),
        Addon(name: "Pico de Gallo Scoop", price: 12), // Cute Addon
        Addon(name: "Lime Zest Sprinkle", price: 5), // Cute Addon
      ],
    ),
    Food(
      name: "Pasta",
      description: "A classic pasta with rich Italian sauce!",
      imagePath: "assets/images/Continental/Pasta.png",
      price: '100',
      category: FoodCategory.Continental,
      availableAddons: [
        Addon(name: "Extra cheese", price: 50),
        Addon(name: "Bacon", price: 60),
        Addon(name: "Avocado", price: 70),
        Addon(name: "Fresh Basil Leaves", price: 7), // Cute Addon
        Addon(name: "Cherry Tomato Halves", price: 9), // Cute Addon
      ],
    ),
    Food(
      name: "Sushi",
      description: "Fresh sushi rolls for your taste adventure.",
      imagePath: "assets/images/Continental/Sushii.png",
      price: '100',
      category: FoodCategory.Continental,
      availableAddons: [
        Addon(name: "Extra wasabi", price: 50),
        Addon(name: "Soy sauce", price: 60),
        Addon(name: "Pickled ginger", price: 70),
        Addon(name: "Edamame Pods", price: 15), // Cute Addon
        Addon(name: "Cute Fish-shaped Soy Sauce", price: 5), // Cute Addon
      ],
    ),
    Food(
      name: "Lasangna",
      description: "Layered pasta, cheese, and rich meat sauce!",
      imagePath: "assets/images/Continental/Lasangna.png",
      price: '100',
      category: FoodCategory.Continental,
      availableAddons: [
        Addon(name: "Extra cheese", price: 50),
        Addon(name: "Bacon", price: 60),
        Addon(name: "Avocado", price: 70),
        Addon(name: "Parmesan Crisp", price: 10), // Cute Addon
        Addon(name: "Mini Garlic Breadstick", price: 15), // Cute Addon
      ],
    ),

    // Salads
    Food(
      name: "Garden Salad",
      description: "Fresh and crispy garden salad.",
      imagePath: "assets/images/Salads/salad4.png",
      price: '50',
      category: FoodCategory.Salads,
      availableAddons: [
        Addon(name: "Crouton Crumbles", price: 5), // Cute Addon
        Addon(name: "Dressing Drizzle", price: 8), // Cute Addon
        Addon(name: "Sunflower Seeds", price: 6), // Cute Addon
      ],
    ),
    Food(
      name: "Extra Green Salad",
      description: "Healthy green salad with vinaigrette.",
      imagePath: "assets/images/Salads/salad3.png",
      price: '100',
      category: FoodCategory.Salads,
      availableAddons: [
        Addon(name: "Candied Pecans", price: 10), // Cute Addon
        Addon(name: "Goat Cheese Crumbles", price: 15), // Cute Addon
        Addon(name: "Berry Medley", price: 12), // Cute Addon
      ],
    ),
    Food(
      name: "Greek Salad",
      description:
          "A refreshing mix of cucumbers, tomatoes, feta cheese, and olives.",
      imagePath: "assets/images/Salads/salad4.png",
      price: '120',
      category: FoodCategory.Salads,
      availableAddons: [
        Addon(name: "Stuffed Grape Leaves", price: 20), // Cute Addon
        Addon(name: "Diced Bell Peppers", price: 8), // Cute Addon
        Addon(name: "Oregano Sprinkles", price: 3), // Cute Addon
      ],
    ),
    Food(
      name: "Caesar Salad",
      description:
          "Crisp romaine lettuce tossed with parmesan, croutons, and Caesar dressing.",
      imagePath: "assets/images/Salads/salad4.png",
      price: '130',
      category: FoodCategory.Salads,
      availableAddons: [
        Addon(name: "Crispy Prosciutto Bits", price: 18), // Cute Addon
        Addon(name: "Soft-boiled Egg", price: 15), // Cute Addon
        Addon(name: "Anchovy Fillets", price: 10), // Cute Addon
      ],
    ),
    Food(
      name: "Fruit Salad",
      description: "A colorful mix of seasonal fruits, fresh and juicy.",
      imagePath: "assets/images/Salads/salad4.png",
      price: '90',
      category: FoodCategory.Salads,
      availableAddons: [
        Addon(name: "Honey Drizzle", price: 5), // Cute Addon
        Addon(name: "Mint Sprig", price: 3), // Cute Addon
        Addon(name: "Whipped Cream Cloud", price: 10), // Cute Addon
      ],
    ),

    // Sides
    Food(
      name: "Grilled Fish",
      description: "Perfectly seasoned grilled fish.",
      imagePath: "assets/images/Sides/grilledfish.png",
      price: '100',
      category: FoodCategory.Sides,
      availableAddons: [
        Addon(name: "Lemon Butter Sauce", price: 15), // Cute Addon
        Addon(name: "Herbed Potato Wedges", price: 20), // Cute Addon
        Addon(name: "Grilled Asparagus", price: 18), // Cute Addon
      ],
    ),
    Food(
      name: "Side",
      description: "A tasty side to complement any meal.",
      imagePath: "assets/images/Sides/side.png",
      price: '100',
      category: FoodCategory.Sides,
      availableAddons: [
        Addon(name: "Garlic Aioli Dip", price: 10), // Cute Addon
        Addon(name: "Parmesan Dusting", price: 7), // Cute Addon
        Addon(name: "Chives Snips", price: 5), // Cute Addon
      ],
    ),
    Food(
      name: "Fried Chicken",
      description: "Crispy, juicy fried chicken.",
      imagePath: "assets/images/Sides/friedchicken.png",
      price: '100',
      category: FoodCategory.Sides,
      availableAddons: [
        Addon(name: "Honey Mustard Dip", price: 10), // Cute Addon
        Addon(name: "Spicy Mayo Drizzle", price: 8), // Cute Addon
        Addon(name: "Corn on the Cobette", price: 15), // Cute Addon
      ],
    ),
    Food(
      name: "Fried Fish",
      description: "Golden-battered fried fish.",
      imagePath: "assets/images/Sides/friedfish.png",
      price: '100',
      category: FoodCategory.Sides,
      availableAddons: [
        Addon(name: "Tartar Sauce Dollop", price: 10), // Cute Addon
        Addon(name: "Malt Vinegar Spritz", price: 5), // Cute Addon
        Addon(name: "Lemon Wedge", price: 3), // Cute Addon
      ],
    ),
    Food(
      name: "Grilled Chicken",
      description: "Tender and smoky grilled chicken.",
      imagePath: "assets/images/Sides/grilledchicken.png",
      price: '100',
      category: FoodCategory.Sides,
      availableAddons: [
        Addon(name: "BBQ Glaze", price: 12), // Cute Addon
        Addon(name: "Pineapple Salsa", price: 18), // Cute Addon
        Addon(name: "Cilantro Sprig", price: 4), // Cute Addon
      ],
    ),

    // Drinks
    Food(
      name: "Coke",
      description: "Classic Coca-Cola, ice cold and refreshing.",
      imagePath: "assets/images/Drinks/coke.png",
      price: '100',
      category: FoodCategory.Drinks,
      availableAddons: [
        Addon(name: "Cherry Splash", price: 8), // Cute Addon
        Addon(name: "Lime Slice", price: 5), // Cute Addon
        Addon(name: "Vanilla Swirl", price: 10), // Cute Addon
      ],
    ),
    Food(
      name: "Coconut Water",
      description: "Pure and natural coconut water.",
      imagePath: "assets/images/Drinks/coconutwater.png",
      price: '100',
      category: FoodCategory.Drinks,
      availableAddons: [
        Addon(name: "Pineapple Cube", price: 7), // Cute Addon
        Addon(name: "Mint Leaf Garnish", price: 4), // Cute Addon
        Addon(name: "Edible Flower", price: 12), // Cute Addon
      ],
    ),
    Food(
      name: "Lemonade",
      description: "Freshly squeezed lemonade with a zesty punch.",
      imagePath: "assets/images/Drinks/lemonade.png",
      price: '100',
      category: FoodCategory.Drinks,
      availableAddons: [
        Addon(name: "Strawberry Puree Swirl", price: 10), // Cute Addon
        Addon(name: "Blueberry Burst", price: 8), // Cute Addon
        Addon(name: "Lemon Wheel", price: 5), // Cute Addon
      ],
    ),
    Food(
      name: "Lemonade",
      description: "Another twist on the classic lemonade.",
      imagePath: "assets/images/Drinks/lemonade2.png",
      price: '100',
      category: FoodCategory.Drinks,
      availableAddons: [
        Addon(name: "Raspberry Fizz", price: 10), // Cute Addon
        Addon(name: "Cucumber Slice", price: 6), // Cute Addon
        Addon(name: "Rosemary Sprig", price: 5), // Cute Addon
      ],
    ),
    Food(
      name: "Fanta",
      description: "Sweet, fizzy orange delight.",
      imagePath: "assets/images/Drinks/fanta2.png",
      price: '100',
      category: FoodCategory.Drinks,
      availableAddons: [
        Addon(name: "Orange Zest Twist", price: 5), // Cute Addon
        Addon(name: "Gummy Bear Surprise", price: 7), // Cute Addon
        Addon(name: "Whipped Cream Topping", price: 10), // Cute Addon
      ],
    ),
  ];

// user cart
  final List<CartItem> _cart = [];

  // delivery address (which user can manage later)
  String _deliveryAddress = "Tema First Light";
  /*

          G E T T E R S

           */
  List<Food> get menu => _menu;
  List<CartItem> get cart => _cart;
  String get deliveryAddress => _deliveryAddress;

  get successfulOrders => null;
  /*

          O P E R A T I O N S

           */
  // add to cart
  void addToCart(Food food, List<Addon> selectedAddons) {
    // see if there is a cart item already with the same food and selected addons
    CartItem? cartItem = _cart.firstWhereOrNull((item) {
      //check if food is the item are the same
      bool isSameFood = item.food.name == food.name;

      // check and if the list of selected addons are the same
      bool isSameAddons =
          const ListEquality().equals(item.selectedAddons, selectedAddons);

      return isSameFood && isSameAddons;
    });
    // if the cart item already exists, increase the quantity
    if (cartItem != null) {
      cartItem.quantity++;
    }
    // otherwise, add a new cart item to the cart
    else {
      _cart.add(
        CartItem(food: food, selectedAddons: selectedAddons),
      );
    }
    notifyListeners();
  }

  // remove from cart
  void removeFromCart(CartItem cartItem) {
    int cartIdex = _cart.indexOf(cartItem);

    if (cartIdex != 1) {
      if (_cart[cartIdex].quantity >= 1) {
        _cart[cartIdex].quantity--;
      } else {
        _cart.removeAt(cartIdex);
      }
    }

    notifyListeners();
  }

  // get total price of cart
  double getTotalPrice() {
    double total = 0.0;

    for (CartItem cartItem in _cart) {
      // Parse the price string into a double, with a fallback to 0.0 if it's invalid
      double itemPrice = double.tryParse(cartItem.food.price) ?? 0.0;

      // Calculate the total for this cart item, including add-ons
      double itemTotal = itemPrice;

      for (Addon addon in cartItem.selectedAddons) {
        itemTotal += addon.price;
      }

      total += itemTotal * cartItem.quantity;
    }

    return total;
  }

  // get total number of items in cart
  int getTotalItemCount() {
    int getTotalItemCount = 0;

    for (CartItem cartItem in _cart) {
      getTotalItemCount += cartItem.quantity;
    }

    return getTotalItemCount;
  }

  // clear cart
  void clearCart() {
    _cart.clear();
    notifyListeners();
  }

  // update delivery address
  void updateDeliveryAddress(String newAddress) {
    _deliveryAddress = newAddress;
    notifyListeners();
  }

  /*
          H E L P E R S
           */

  // generate receipt
  String displayCartReceipt(dynamic cartItem) {
    final receipt = StringBuffer();
    receipt.writeln("Here you GO!! Your receipt.");
    receipt.writeln();

    // format the date to include up to seconds only
    String formattedDate =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

    receipt.writeln(formattedDate);
    receipt.writeln();
    receipt.writeln("-----------");

    for (final cartItem in _cart) {
      // Changed variable name to avoid conflict
      receipt.writeln(
          "₵${cartItem.quantity} x ₵${cartItem.food.name} - ₵${_formatPrice(double.parse(cartItem.food.price))}");
      SizedBox(height: 5);
      if (cartItem.selectedAddons.isNotEmpty) {
        receipt.writeln("  Add-ons:₵${_formatAddons(cartItem.selectedAddons)}");
      }
      receipt.writeln();
    }

    receipt.writeln("-----------");
    receipt.writeln();
    receipt.writeln("Total Item : ${getTotalItemCount()}");
    receipt.writeln("Total Price : ₵${_formatPrice(getTotalPrice())}");
    receipt.writeln();
    receipt.writeln("Delivery to: $deliveryAddress");
    return receipt.toString();
  }

// format double value into money
  String _formatPrice(double price) {
    return price.toStringAsFixed(2);
  }

// format list of addons into a string summary
  String _formatAddons(List<Addon> addons) {
    return addons
        .map((addon) => "${addon.name} (₵${_formatPrice(addon.price)})")
        .join(", ");
  }

  // String get totalPrice {
  //   double addonsPrice =
  //       selectedAddons.fold(0, (sum, addon) => sum + addon.price);
  //   return (food.price + addonsPrice) * quantity;
  // }
}