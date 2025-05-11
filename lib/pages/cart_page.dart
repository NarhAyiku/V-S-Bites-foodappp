import 'package:flutter/material.dart';
import 'package:foodappp/components/my_button.dart';
import 'package:foodappp/components/my_cart_tile.dart';
import 'package:foodappp/models/restaurants.dart';
import 'package:foodappp/pages/payment_page.dart'; // <-- Make sure this import exists
import 'package:provider/provider.dart';
// import 'package:paystack_manager/paystack_pay_manager.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Restaurants>(
      builder: (context, restaurants, child) {
        final userCart = restaurants.cart;
        final total = restaurants.getTotalPrice;

        return Scaffold(
          appBar: AppBar(
            title: const Text("Cart"),
            backgroundColor: Colors.transparent,
            foregroundColor: Theme.of(context).colorScheme.inversePrimary,
            actions: [
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Clear Cart"),
                      content: const Text("Are you sure you want to clear the cart?"),
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
                icon: const Icon(Icons.delete_forever_outlined ),
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
                padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15),
                child: MyButton(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PaymentPage(),
                    ),
                  ),
                  // onTap: _checkPayment,
                  text: "Proceed to Checkout (\₵${total().toStringAsFixed(2)})", 
                  // text: "Proceed to Checkout (${userCart.length} items) - \$${getTotalPrice().toStringAsFixed(2)}", 
                  onTop: () {  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}



  // void _checkPayment() {
  //   try {
  //     PaystackPayManager(context: context)
  //       ..setSecretKey("sk_test_fbf06d137e8515c1c7645196c6ae62bbe8008d91")
  //       // ..setCompanyAssetImage(Image(image: NetworkImage("YOUR-IMAGE-URL")))
  //       ..setAmount(10000)
  //       ..setReference(DateTime.now().millisecondsSinceEpoch.toString())
  //       ..setCurrency("GH")
  //       ..setEmail("samuelbeebest@gmail.com")
  //       ..setFirstName("Samuel")
  //       ..setLastName("Adekunle")
  //       ..setMetadata(
  //         {
  //           "custom_fields": [
  //             {
  //               "value": "TechWithSam",
  //               "display_name": "Payment_to",
  //               "variable_name": "Payment_to"
  //             }
  //           ]
  //         },
  //       )
  //       ..onSuccesful(_onPaymentSuccessful)
  //       ..onPending(_onPaymentPending)
  //       ..onFailed(_onPaymentFailed)
  //       ..onCancel(_onCancel)
  //       ..initialize();
  //   } catch (error) {
  //     print('Payment Error ==> $error');
  //   }
  // }

  // void _onPaymentSuccessful(Transaction transaction) {
  //   print('Transaction succesful');
  //   print(
  //       "Transaction message ==> ${transaction.message}, Ref ${transaction.refrenceNumber}");
  // }

  // void _onPaymentPending(Transaction transaction) {
  //   print('Transaction Pending');
  //   print("Transaction Ref ${transaction.refrenceNumber}");
  // }

  // void _onPaymentFailed(Transaction transaction) {
  //   print('Transaction Failed');
  //   print("Transaction message ==> ${transaction.message}");
  // }

  // void _onCancel(Transaction transaction) {
  //   print('Transaction Cancelled');
  // }
