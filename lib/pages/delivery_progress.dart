import 'package:flutter/material.dart';
import 'package:foodappp/components/my_receipt.dart';
import 'package:foodappp/models/restaurants.dart';
import 'package:foodappp/services/auth/firestore.dart';
import 'package:provider/provider.dart';

class DeliveryProgressPage extends StatefulWidget {
  const DeliveryProgressPage({super.key});

  @override
  State<DeliveryProgressPage> createState() => _DeliveryProgressPageState();
  }

class _DeliveryProgressPageState extends State<DeliveryProgressPage> {

  // get access to the database 
  FirestoreService db = FirestoreService();

  @override
  void initState() {
    super.initState();

    // if we get to this page, sumit the order to firestore db
    String receipt = context.read<Restaurants>().displayCartReceipt('');
    db.saveOrderToDatabase(receipt);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          MyReceipt(),
        ],
      ),
      bottomNavigationBar: _buildBottomNavBar(context),
    );
  }

  // Custom Bottom Navigation Bar - Message / Call delivery person
  Widget _buildBottomNavBar(BuildContext context) {
    return Container( 
      height: 100,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      padding: const EdgeInsets.all(25),
      child: Row(
        children: [
          // profile icon of the delivery person
          Container(
            decoration: BoxDecoration(color: Theme.of(context).colorScheme.background,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.person),
              )
            ),

            const SizedBox(width: 10),

            //  driver details
             Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Michael Smith",
                style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize:18,
                color: Theme.of(context).colorScheme.inversePrimary,
                ),
                ),
                Text(
                  "Delivery",
                style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                ),
                ),
              ],
             ),

        const Spacer(),

             Row(
              children: [
            // message button
            Container(
            decoration: BoxDecoration(color: Theme.of(context).colorScheme.background,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.message_rounded),
              color: Theme.of(context).colorScheme.primary,
              )
            ),

            const SizedBox(width: 10),

              // call button
            Container(
            decoration: BoxDecoration(color: Theme.of(context).colorScheme.background,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.call_rounded),
              color: Colors.green,
              )
            ),
        ],
      ),
        ],
      ),
    );
  }
}