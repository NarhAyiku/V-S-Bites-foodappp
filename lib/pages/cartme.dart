import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:foodappp/components/my_button.dart';
import 'package:foodappp/components/my_cart_tile.dart';
import 'package:foodappp/models/restaurants.dart';
import 'package:foodappp/pages/StripeService.dart';
import 'package:foodappp/pages/Successfulpage.dart';
import 'package:foodappp/pages/payment_page.dart'; // <-- Make sure this import exists
import 'package:provider/provider.dart';

class Cartme extends StatelessWidget {
  const Cartme({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Restaurants>(
      builder: (context, restaurants, child) {
        final userCart = restaurants.cart;
        final total = restaurants.getTotalPrice;

        return Scaffold(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
            title: const Text("Cart"),
            foregroundColor: Theme.of(context).colorScheme.inversePrimary,
            actions: [
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Clear Cart"),
                      content: const Text(
                          "Are you sure you want to clear the cart?"),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () {
                            restaurants.clearCart();
                            Navigator.pop(context);
                          },
                          child: const Text("Yes"),
                        ),
                      ],
                    ),
                  );
                },
                icon: const Icon(Icons.delete_forever_outlined),
              ),
            ],
          ),
          body: Column(
            children: [
              // Cart Items List
              Expanded(
              child: userCart.isEmpty
                ? const Center(
                  child: Text(
                    "Cart is empty...",
                    style: TextStyle(fontSize: 16),
                  ),
                  )
                : ListView.builder(
                  itemCount: userCart.length,
                  itemBuilder: (context, index) {
                    final cartItem = userCart[index];
                    return MyCartTile(cartItem: cartItem);
                  },
                  ),
              ),
              // Payment Method Selection
              Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StatefulBuilder(
                builder: (context, setState) {
                  // Use a ValueNotifier for stateful selection
                  final paymentNotifier = ValueNotifier<int>(0);
                  return ValueListenableBuilder<int>(
                  valueListenable: paymentNotifier,
                  builder: (context, selectedPayment, _) => Row(
                    children: [
                    Radio<int>(
                      value: 0,
                      groupValue: selectedPayment,
                      onChanged: (value) {
                      paymentNotifier.value = value!;
                      },
                    ),
                    const Text('Cash'),
                    Radio<int>(
                      value: 1,
                      groupValue: selectedPayment,
                      onChanged: (value) {
                      paymentNotifier.value = value!;
                      },
                    ),
                    const Text('Card'),
                    // Proceed Button
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: MyButton(
                      onTap: () async {
                        if (selectedPayment == 0) {
                        // Cash: clear cart and go to success
                        restaurants.clearCart();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                          builder: (context) => const SuccessfulPage(),
                          ),
                        );
                        } else {
                        // Card: Stripe payment
                        double totalAmount = total();
                        final stripeService = StripeService();
                        await stripeService.makeTestPayment(amount: totalAmount);
                        restaurants.clearCart();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                          builder: (context) => const PaymentPage(),
                          ),
                        );
                        }
                      },
                      text: selectedPayment == 0
                        ? "Pay  \₵${total().toStringAsFixed(2)}"
                        : "Pay  \₵${total().toStringAsFixed(2)}",
                      onTop: () {},
                      ),
                    ),
                    ],
                  ),
                  );
                },
                ),
              ],
              ),
            ],
          ),
        );
      },
    );
  }
}

