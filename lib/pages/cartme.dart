// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:foodappp/components/my_button.dart';
// import 'package:foodappp/components/my_cart_tile.dart';
// import 'package:foodappp/models/restaurants.dart';
// import 'package:foodappp/pages/StripeService.dart';
// import 'package:foodappp/pages/Successfulpage.dart';
// import 'package:foodappp/pages/payment_page.dart'; // <-- Make sure this import exists
// import 'package:foodappp/pages/sendPaymentToBackend.dart';
// import 'package:provider/provider.dart';

// class Cartme extends StatelessWidget {
//   const Cartme({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<Restaurants>(
//       builder: (context, restaurants, child) {
//         final userCart = restaurants.cart;
//         final total = restaurants.getTotalPrice;

//         return Scaffold(
//           backgroundColor: const Color.fromARGB(255, 255, 255, 255),
//           appBar: AppBar(
//             backgroundColor: const Color.fromARGB(255, 255, 255, 255),
//             title: const Text("Cart",
//             style: TextStyle(
//           fontSize: 30,
//           fontWeight: FontWeight.bold,
//           color: Color(0xFF010F07),
//         ),),
//             foregroundColor: Theme.of(context).colorScheme.inversePrimary,
//             actions: [
//               IconButton(
//                 onPressed: () {
//                   showDialog(
//                     context: context,
//                     builder: (context) => AlertDialog(
//                       title: const Text("Clear Cart"),
//                       content: const Text(
//                           "Are you sure you want to clear the cart?"),
//                       actions: [
//                         TextButton(
//                           onPressed: () => Navigator.pop(context),
//                           child: const Text("Cancel"),
//                         ),
//                         TextButton(
//                           onPressed: () {
//                             restaurants.clearCart();
//                             Navigator.pop(context);
//                           },
//                           child: const Text("Yes"),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//                 icon: const Icon(Icons.delete_forever_outlined),
//               ),
//             ],
//           ),
//           body: Column(
//             children: [
//               // Cart Items List
//               Expanded(
//               child: userCart.isEmpty
//                 ? const Center(
//                   child: Text(
//                     "Cart is empty...",
//                     style: TextStyle(fontSize: 16),
//                   ),
//                   )
//                 : SingleChildScrollView(
//                     padding: const EdgeInsets.all(10.0),
//                   child: Column(
//                       children: [
//                         Card(
//                             color: const Color.fromARGB(255, 241, 241, 241),
//                             // margin: const EdgeInsets.all(16.0),
//                             elevation: 0,
//                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                             child: Padding(
//                               padding: const EdgeInsets.all(16.0),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                                 children: [
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       const Text(
//                                         "Order Summary",
//                                         style: TextStyle(
//                                           fontSize: 18,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                       // Text(
//                                       //   "₵${total().toStringAsFixed(2)}",
//                                       //   style: const TextStyle(fontSize: 16),
//                                       // ),
//                                     ],
//                                   ),
//                                     const Divider(height: 24, thickness: 0.1),
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       const Text(
//                                         "Subtotal",
//                                         style: TextStyle(fontSize: 16),
//                                       ),
//                                       Text(
//                                         "₵${total().toStringAsFixed(2)}",
//                                         style: const TextStyle(fontSize: 16),
//                                       ),
//                                     ],
//                                   ),
//                                   const SizedBox(height: 8),
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     children: const [
//                                       Text(
//                                         "Service Fee",
//                                         style: TextStyle(fontSize: 16),
//                                       ),
//                                       Text(
//                                         "₵5.00",
//                                         style: TextStyle(fontSize: 16),
//                                       ),
//                                     ],
//                                   ),
//                                   const Divider(height: 24, thickness: 0.5),
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       const Text(
//                                         "Total",
//                                         style: TextStyle(
//                                           fontSize: 18,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                       Text(
//                                         "₵${(total() + 5).toStringAsFixed(2)}",
//                                         style: const TextStyle(
//                                           fontSize: 18,
//                                           fontWeight: FontWeight.bold,
//                                           color: Color.fromARGB(255, 0, 0, 0),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                         ),
//                         // const SizedBox(height: 10),
//                          ListView.builder(
//                           shrinkWrap: true,
//                           physics: const NeverScrollableScrollPhysics(), // Disable internal scroll
//                           itemCount: userCart.length,
//                           itemBuilder: (context, index) {
//                             final cartItem = userCart[index];
//                             return Container(child: MyCartTile(cartItem: cartItem));
//                           },
//                         ),
//                       ],
//                     ),
//                 ),
//               ),

//               // Payment Method Selection
//                if (userCart.isNotEmpty)
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                 StatefulBuilder(
//                 builder: (context, setState) {
//                   // Use a ValueNotifier for stateful selection
//                   final paymentNotifier = ValueNotifier<int>(0);
//                   return ValueListenableBuilder<int>(
//                   valueListenable: paymentNotifier,
//                   builder: (context, selectedPayment, _) => Row(
//                     children: [
//                     Radio<int>(
//                           value: 0,
//                           groupValue: selectedPayment,
//                           onChanged: (value) {
//                             paymentNotifier.value = value!;
//                           },
//                           activeColor: Colors.orange, // orange when selected
//                           fillColor: MaterialStateProperty.resolveWith<Color>((states) {
//                             if (states.contains(MaterialState.selected)) {
//                               return Colors.orange; // Fill with orange when selected
//                             }
//                             return Colors.grey; // Or whatever you want when unselected
//                           }),
//                         ),
//                     const Text('Cash'),
//                     Radio<int>(
//                           value: 1,
//                           groupValue: selectedPayment,
//                           onChanged: (value) {
//                             paymentNotifier.value = value!;
//                           },
//                           activeColor: Colors.orange, // orange when selected
//                           fillColor: MaterialStateProperty.resolveWith<Color>((states) {
//                             if (states.contains(MaterialState.selected)) {
//                               return Colors.orange; // Fill with orange when selected
//                             }
//                             return Colors.grey; // Or whatever you want when unselected
//                           }),
//                         ),
//                     const Text('Card'),
//                     // Proceed Button
//                     Padding(
//                       padding: const EdgeInsets.only(left: 16.0),
//                       child: MyButton(
//                         onTap: () async {
//                           String phoneNumber = 'phoneNumber'; 
//                           double totalAmount = total() + 5;
//                           String paymentMethod = selectedPayment == 0 ? "cash" : "card";

//                           try {
//                             await sendPaymentToBackend(
//                               amount: totalAmount,
//                               paymentMethod: paymentMethod,
//                               phoneNumber: phoneNumber,
//                             );

//                             if (selectedPayment == 0) {
//                               // Cash
//                               restaurants.clearCart();
//                               Navigator.pushReplacement(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => const SuccessfulPage(),
//                                 ),
//                               );
//                             } else {
//                               // Card
//                               final stripeService = StripeService();
//                               await stripeService.makeTestPayment(amount: totalAmount);

//                               restaurants.clearCart();
//                               Navigator.pushReplacement(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => const PaymentPage(),
//                                 ),
//                               );
//                             }
//                           } catch (e) {
//                             // Handle error: show a dialog, snack bar, etc.
//                             print("Payment error: $e");
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(content: Text("Payment failed, please try again.")),
//                             );
//                           }
//                         },
//                         text: "Pay  ₵${(total() + 5).toStringAsFixed(2)}",
//                         onTop: () {},
//                       ),
//                     ),
//                     ],
//                   ),
//                   );
//                 },
//                 ),
//               ],
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

