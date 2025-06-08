import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:foodappp/pages/Successfulpage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart';

class StripeService {
  Future<void> makeTestPayment({required double amount}) async {
    print("🔵 makeTestPayment called with amount: $amount");
    try {
      // Step 1: Call your Flask backend to get the client secret
      print("🔵 Sending POST request to backend for payment intent...");
      final response = await http.post(
        Uri.parse('http://10.0.96.246:4242/create-payment-intent'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'amount': (amount * 100).toInt()}),
      );
      print("🟢 Received response from backend: ${response.body}");

      final data = jsonDecode(response.body);
      final clientSecret = data['clientSecret'];
      print("🔵 Extracted clientSecret: $clientSecret");

      if (clientSecret == null) {
        print("❌ clientSecret is null!");
        throw Exception("Failed to get client secret from backend.");
      }

      // Step 2: Initialize the payment sheet
      print("🔵 Initializing payment sheet...");
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: 'FoodAppp',
          allowsDelayedPaymentMethods: true,
          style: ThemeMode.system,
        ),
      )
        .then((_) async {
        print("✅ Sheet initialized. Now presenting...");
        await Stripe.instance.presentPaymentSheet();
        print("🎉 Payment successful!");
      }).catchError((e) {
        print("💥 Error: $e");
        _showAlertDialog("Error", e.toString());
      });

      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => const SuccessfulPage(),
      //   ),
      // );
    } on StripeException catch (e) {
      // Handle Stripe-specific errors gracefully
      print("❌ StripeException: ${e.error.localizedMessage}");
      _showAlertDialog("Payment Cancelled",
          e.error.localizedMessage ?? 'Something went wrong.');
    } catch (e) {
      // Handle any other exceptions
      print("❌ General Error: $e");
      _showAlertDialog("Payment Error", e.toString());
    }
    print("🔵 makeTestPayment finished.");
  }

  // Simple dialog for feedback (Optional)
  void _showAlertDialog(String title, String message) {
    debugPrint("📢 $title: $message");
  }
}

