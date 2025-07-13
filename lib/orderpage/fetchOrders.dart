import 'dart:convert';
import 'package:foodappp/const.dart';
import 'package:foodappp/orderpage/Order.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<List<Order>> fetchOrders(String phoneNumber) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final phoneNumber = prefs.getString('phoneNumber');
  print('Fetching orders for phone number: $phoneNumber');
  if (phoneNumber == null) {
    throw Exception('Phone number not found in SharedPreferences');
  }
  final String baseUrl = AppConstants.baseUrl;
  final url = Uri.parse('$baseUrl/api/orders/$phoneNumber');

  final response = await http.get(url);
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');

  

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final List<dynamic> ordersJson = data['orders'];

    return ordersJson.map((json) => Order.fromJson(json)).toList();
  } else {
    throw Exception('Failed to fetch orders');
  }
}


Future<void> toggleOrderStatus(int id, String newStatus) async {
  final String baseUrl = AppConstants.baseUrl;
  final url = Uri.parse('$baseUrl/api/payments');

  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'id': id, 'status': newStatus}),
  );

  if (response.statusCode == 200) {
    print('Order status updated: ${response.body}');
  } else {
    throw Exception('Failed to update order status');
  }
}

