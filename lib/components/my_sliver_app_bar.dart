import 'package:flutter/material.dart';
import 'package:foodappp/models/restaurants.dart';
import 'package:provider/provider.dart';

class MySliverAppBar extends StatefulWidget {
  final Widget child;
  final Widget title;

  const MySliverAppBar({
    super.key,
    required this.child,
    required this.title,
  });

  @override
  State<MySliverAppBar> createState() => _MySliverAppBarState();
}

class _MySliverAppBarState extends State<MySliverAppBar> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Restaurants>(
      builder: (context, restaurants, child) {
        final userCart = restaurants.cart;

        return SliverAppBar(
          expandedHeight: 280,
          collapsedHeight: 120,
          floating: false,
          pinned: true,
          // leading: Text('Hello there,'),
          // actions: [
          //   // cart button with badge
          //   Stack(
          //     children: [
          //       Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: IconButton(
          //           onPressed: () {
          //             // go to cart page
          //             Navigator.push(
          //               context,
          //               MaterialPageRoute(
          //                 builder: (context) => const CartPage(),
          //               ),
          //             );
          //           },
          //           icon: const Icon(Icons.shopping_cart),
          //         ),
          //       ),
          //       if (userCart.isNotEmpty)
          //         Positioned(
          //           right: 0,
          //           child: Container(
          //             padding: const EdgeInsets.all(2),
          //             decoration: BoxDecoration(
          //               color: Colors.red,
          //               borderRadius: BorderRadius.circular(10),
          //             ),
          //             constraints: const BoxConstraints(
          //               minWidth: 20,
          //               minHeight: 20,
          //             ),
          //             child: Text(
          //               '${userCart.length}',
          //               style: const TextStyle(
          //                 color: Colors.white,
          //                 fontSize: 12,
          //               ),
          //               textAlign: TextAlign.center,
          //             ),
          //           ),
          //         ),
          //     ],
          //   )
          // ],
          // title: const Text("V's Bites"),
          backgroundColor: Theme.of(context).colorScheme.background,
          foregroundColor: Theme.of(context).colorScheme.inversePrimary,
          flexibleSpace: FlexibleSpaceBar(
            background: Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: widget.child,
            ),
            title: widget.title,
            centerTitle: true,
            titlePadding: const EdgeInsets.only(left: 0, right: 0, top: 0),
            expandedTitleScale: 1,
          ),
        );
      },
    );
  }
}
