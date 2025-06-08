import 'package:flutter/material.dart';
import 'package:foodappp/models/orderset.dart';
import 'package:provider/provider.dart';


class Ordercart extends StatefulWidget {
  const Ordercart({super.key});

  @override
  State<Ordercart> createState() => _OrdercartState();
}

class _OrdercartState extends State<Ordercart> {
  @override
  Widget build(BuildContext context) {
    final restaurants = Provider.of<Restaurants>(context);
    final orders = restaurants.successfulOrders;

    return Padding(
      padding: const EdgeInsets.all(25),
      child: orders.isEmpty
          ? const Center(child: Text("No orders made yet."))
          : ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      restaurants.displayOrderReceipt(order),
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
