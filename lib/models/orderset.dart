import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:foodappp/models/cart_item.dart';
import 'package:intl/intl.dart';
import 'food.dart';

class Restaurants with ChangeNotifier {
  final List<CartItem> _cart = [];
  final List<List<CartItem>> _successfulOrders = [];

  void markOrderAsSuccessful() {
    _successfulOrders.add(List.from(_cart)); // clone the cart
    _cart.clear();
    notifyListeners();
  }

  List<List<CartItem>> get successfulOrders => _successfulOrders;

  String displayOrderReceipt(List<CartItem> order) {
    final receipt = StringBuffer();
    receipt.writeln("Here you GO!! Your receipt.");
    receipt.writeln(DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()));
    receipt.writeln("-----------");

    for (final item in order) {
      receipt.writeln(
          "₵${item.quantity} x ${item.food.name} - ₵${_formatPrice(double.parse(item.food.price))}");
      if (item.selectedAddons.isNotEmpty) {
        receipt.writeln("  Add-ons: ₵${_formatAddons(item.selectedAddons)}");
      }
      receipt.writeln();
    }

    receipt.writeln("-----------");
    receipt.writeln("Total Items: ${order.length}");
    // receipt.writeln("Delivery to: $deliveryAddress");
    return receipt.toString();
  }

  String _formatPrice(double price) => price.toStringAsFixed(2);
  String _formatAddons(List<Addon> addons) => addons
      .map((addon) => "${addon.name} (₵${_formatPrice(addon.price)})")
      .join(", ");
}
