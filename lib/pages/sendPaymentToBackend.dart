import 'package:foodappp/const.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
Future<void> sendPaymentToBackend({
  required double amount,
  required String paymentMethod,
  required String phoneNumber,
  required String cartDetails,
}) async {
  final String baseUrl = AppConstants.baseUrl;
   String url = '$baseUrl/api/payment';

  final response = await http.post(
    Uri.parse(url),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'amount': amount,
      'payment_method': paymentMethod,
      'phone_number': phoneNumber,
      'cartDetails': cartDetails, 
    }),
  );

  if (response.statusCode == 200) {
    print("✅ Payment sent successfully: ${response.body}");
  } else {
    print("❌ Failed to send payment: ${response.body}");
    throw Exception("Payment failed");
  }
}
