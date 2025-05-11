import 'package:flutter/material.dart';
import 'package:foodappp/models/restaurants.dart';
import 'package:provider/provider.dart';

class MyReceipt extends StatefulWidget {
  const MyReceipt({super.key});




  @override
  State<MyReceipt> createState() => _MyReceiptState();
}

class _MyReceiptState extends State<MyReceipt> {

  
  @override 
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right:25, bottom:25, top: 25),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Thank you for your order!"),
            const SizedBox(
              height: 25
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).colorScheme.secondary),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(25),
              child: Consumer<Restaurants>(
                builder: (context,restaurants,child) => 
                  Text(restaurants.displayCartReceipt(context)),
            ),
            ),
            const SizedBox(height: 20),
            const Text("Estimated delivery time is: 4:30 PM"),

          ],
      ),
      ),
    );


}
}