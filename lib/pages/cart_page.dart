import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:foodappp/components/my_button.dart';
import 'package:foodappp/components/my_cart_tile.dart';
import 'package:foodappp/models/restaurants.dart';
import 'package:foodappp/pages/StripeService.dart';
import 'package:foodappp/pages/Successfulpage.dart';
import 'package:foodappp/pages/payment_page.dart';
import 'package:foodappp/pages/sendPaymentToBackend.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Restaurants>(
      builder: (context, restaurants, child) {
        final userCart = restaurants.cart;
        //  final userCart = restaurants.cart;
        final total = restaurants.getTotalPrice;
        final double rawTotalCedi = restaurants.getTotalPrice();
        // Convert GH₵ to pesewas (smallest unit). .round() to avoid fractions.
        final int amountPesewas = (rawTotalCedi * 100).round();

        return Scaffold(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
            title: const Text("Cart",
            style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Color(0xFF010F07),
        ),),
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
                    : SingleChildScrollView(
                    padding: const EdgeInsets.all(12.0),
                  child: Column(
                      children: [
                          Card(
                            color: const Color.fromARGB(255, 241, 241, 241),
                            margin: const EdgeInsets.all(16.0),
                            elevation: 0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "Subtotal",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      Text(
                                        "₵${total().toStringAsFixed(2)}",
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Text(
                                        "Service Fee",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      Text(
                                        "₵5.00",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  const Divider(height: 24, thickness: 1),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "Total",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "₵${(total() + 5).toStringAsFixed(2)}",
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(255, 0, 0, 0),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                        ),
                        const SizedBox(height: 16),
                         ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(), // Disable internal scroll
                          itemCount: userCart.length,
                          itemBuilder: (context, index) {
                            final cartItem = userCart[index];
                            return MyCartTile(cartItem: cartItem);
                          },
                        ),
                  
                      ],
                    ),
                ),
              ),
              // Checkout Button
               if (userCart.isNotEmpty)
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
                          activeColor: Colors.orange, // orange when selected
                          fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                            if (states.contains(MaterialState.selected)) {
                              return Colors.orange; // Fill with orange when selected
                            }
                            return Colors.grey; // Or whatever you want when unselected
                          }),
                        ),

                    const Text('Cash'),
                    Radio<int>(
                      value: 1,
                      groupValue: selectedPayment,
                      onChanged: (value) {
                        paymentNotifier.value = value!;
                      },
                      activeColor: Colors.orange, // orange when selected
                      fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                        if (states.contains(MaterialState.selected)) {
                          return Colors.orange; // Fill with orange when selected
                        }
                        return Colors.grey; // Or whatever you want when unselected
                      }),
                    ),

                    const Text('Card'),
                   
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: MyButton(
                        onTap: () async {
                         
                            // Retrieve phone number from SharedPreferences
                            final prefs = await SharedPreferences.getInstance();
                            String phoneNumber = prefs.getString('phoneNumber') ?? '';
                            double totalAmount = total() + 5;
                            
                            String paymentMethod = selectedPayment == 0 ? "cash" : "card";

                            final userCart = restaurants.cart;
                            // Gather cart details: product names, images, and addons
                            List<Map<String, dynamic>> cartDetailsList = userCart.map((cartItem) {
                              return {
                                'name': cartItem.food.name,
                                // 'image': cartItem.food.imagePath,
                                // 'addons': cartItem.selectedAddons ?? [],
                              };
                            }).toList();

                            try {
                              await sendPaymentToBackend(
                                amount: totalAmount,
                                paymentMethod: paymentMethod,
                                phoneNumber: phoneNumber,
                                cartDetails: jsonEncode(cartDetailsList),
                              );

                              if (selectedPayment == 0) {
                                // Cash
                                restaurants.clearCart();
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                  builder: (context) => SuccessfulPage(
                                    totalAmount: totalAmount,
                                  ),
                                  ),
                                );
                                print("Payment error:");
                            } else {
                              // Card
                              final stripeService = StripeService();
                              await stripeService.makeTestPayment(amount: totalAmount);

                              restaurants.clearCart();
// 

                              // Navigator.pushReplacement(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => const PaymentPage(),
                              //   ),
                              // );
                            }
                               print("Payment error: ");
                          } catch (e) {
                            // Handle error: show a dialog, snack bar, etc.
                            print("Payment error: $e");
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Payment failed, please try again.")),
                            );
                          }
                        },
                        text: "Pay  ₵${(total() + 5).toStringAsFixed(2)}",
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
               SizedBox(height: 40),

              // Padding(
              //   padding:
              //       const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15),
              //   child: MyButton(
              //     text:
              //         "Proceed to Checkout (₵${rawTotalCedi.toStringAsFixed(2)})",
              //     onTap: () {
              //       Navigator.pushReplacement(
              //             context,
              //             MaterialPageRoute(
              //             builder: (context) => const SuccessfulPage(),
              //             ),
              //           );
              //       // Kick off Paystack with dynamic amount
              //     },
              //     onTop: () {
              //       // _startPayment(context, amountPesewas);
              //     },
              //   ),
              // ),
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
