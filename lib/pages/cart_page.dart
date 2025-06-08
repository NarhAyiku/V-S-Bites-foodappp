import 'package:flutter/material.dart';
import 'package:foodappp/components/my_button.dart';
import 'package:foodappp/components/my_cart_tile.dart';
import 'package:foodappp/models/restaurants.dart';
import 'package:provider/provider.dart';


class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Restaurants>(
      builder: (context, restaurants, child) {
        final userCart = restaurants.cart;
        final double rawTotalCedi = restaurants.getTotalPrice();
        // Convert GH₵ to pesewas (smallest unit). .round() to avoid fractions.
        final int amountPesewas = (rawTotalCedi * 100).round();

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
              // Checkout Button
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15),
                child: MyButton(
                  text:
                      "Proceed to Checkout (₵${rawTotalCedi.toStringAsFixed(2)})",
                  onTap: () {
                    // Kick off Paystack with dynamic amount
                  },
                  onTop: () {
                    // _startPayment(context, amountPesewas);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
//   }

//   /// Initializes Paystack with the given [amountPesewas].
//   void _startPayment(BuildContext context, int amountPesewas) {
//     try {
//       PaystackPayManager(context: context)
//         // 🔑 Replace with YOUR live/test secret key. This is a test key.
//         ..setSecretKey("sk_test_fbf06d137e8515c1c7645196c6ae62bbe8008d91")
//         ..setAmount(amountPesewas)
//         ..setCurrency("GHS") // Use "GHS" for Ghana cedi
//         ..setReference(DateTime.now().millisecondsSinceEpoch.toString())
//         ..setEmail("samuelbeebest@gmail.com")
//         ..setFirstName("Samuel")
//         ..setLastName("Adekunle")
//         ..setMetadata(
//           {
//             "custom_fields": [
//               {
//                 "value": "TechWithSam",
//                 "display_name": "Payment_to",
//                 "variable_name": "Payment_to"
//               }
//             ]
//           },
//         )
//         ..onSuccesful(_onPaymentSuccessful)
//         ..onPending(_onPaymentPending)
//         ..onFailed(_onPaymentFailed)
//         ..onCancel(_onCancel)
//         ..initialize();
//     } catch (error) {
//       // Always log errors for debugging.
//       debugPrint('Payment Error ==> $error');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(
//             "Payment failed to start: $error",
//             style: const TextStyle(color: Colors.white),
//           ),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }

//   void _onPaymentSuccessful(Transaction transaction) {
//     debugPrint('Transaction successful');
//     debugPrint(
//         "Message => ${transaction.message}, Ref => ${transaction.refrenceNumber}");
//     // TODO: Handle post-success logic (e.g., clear cart, show a “Thank you” screen).
//   }

//   void _onPaymentPending(Transaction transaction) {
//     debugPrint('Transaction Pending');
//     debugPrint("Transaction Ref => ${transaction.refrenceNumber}");
//     // TODO: Maybe inform user that payment is being processed.
//   }

//   void _onPaymentFailed(Transaction transaction) {
//     debugPrint('Transaction Failed');
//     debugPrint("Message => ${transaction.message}");
//     // TODO: Show a failure message or retry option.
//   }

//   void _onCancel(Transaction transaction) {
//     debugPrint('Transaction Cancelled');
//     // TODO: Let the user know they cancelled the payment.
//   }
}
}
