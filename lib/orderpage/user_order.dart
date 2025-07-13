import 'package:flutter/material.dart';
import 'package:foodappp/orderpage/Order.dart';
import 'package:foodappp/orderpage/fetchOrders.dart';

class OrdersPage extends StatefulWidget {
  final String phoneNumber;

  const OrdersPage({super.key, required this.phoneNumber});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  late Future<List<Order>> _ordersFuture;

  @override
  void initState() {
    super.initState();
    _ordersFuture = fetchOrders(widget.phoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Payment History",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF22223B),
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Order>>(
        future: _ordersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              // child: Text(
              //   "Error: ${snapshot.error}",
              //   style: const TextStyle(color: Colors.red, fontSize: 18),
              // ),
                   child: Text(
                "No Orders Found",
                style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 18),
              ),
            );
          }

          final orders = snapshot.data ?? [];

          if (orders.isEmpty) {
            return const Center(
              child: Text(
                "No orders found.",
                style: TextStyle(fontSize: 20, color: Colors.grey),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 18),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.07),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                  color: Colors.white,
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 18, horizontal: 20),
                  leading: CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.orange,
                    child: Text(
                      "₵",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white.withOpacity(0.95),
                      ),
                    ),
                  ),
                  title: Text(
                    "₵${order.amount.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF22223B),
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...order.cartDetails.map<Widget>((item) {
                          final foodName = item['name'] ?? 'Unnamed';
                          final addons = item['addons'] as List<dynamic>? ?? [];
                          final addonNames =
                              addons.map((a) => a['name']).join(', ');
                          return Padding(
                            padding: const EdgeInsets.only(top: 2),
                            child: Text(
                              "- $foodName ${addonNames.isNotEmpty ? '(Addons: $addonNames)' : ''}",
                              style: const TextStyle(
                                fontSize: 15,
                                color: Color(0xFF4A4E69),
                              ),
                            ),
                          );
                        }),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(Icons.payment, size: 18, color: Color(0xFF9D8189)),
                            const SizedBox(width: 6),
                            Text(
                              "Method: ${order.method}",
                              style: const TextStyle(
                                color: Colors.orange,
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.calendar_today, size: 16, color: Color(0xFF22223B)),
                            const SizedBox(width: 6),
                            Text(
                              "Date: ${DateTime.parse(order.timestamp).toLocal().toString().split('.')[0]}",
                              style: const TextStyle(
                                color: Color(0xFF22223B),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
