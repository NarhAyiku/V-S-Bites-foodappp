import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:foodappp/const.dart'; // Assuming this contains AppConstants.baseUrl
import 'package:foodappp/pages/Successfulpage.dart'; // Assuming this is your success page
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart';

class StripeService {
  final String baseUrl = AppConstants.baseUrl;

  /// Helper function to show a SnackBar message to the user.
  /// This is a better way to provide feedback in Flutter UI than print statements
  /// or unsupported alert dialogs.
  // void _showSnackBar(BuildContext context, String message, {bool isError = false}) {
  //   if (!context.mounted) return; // Ensure context is still valid

  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text(
  //         message,
  //         style: TextStyle(color: isError ? Colors.white : Colors.black),
  //       ),
  //       backgroundColor: isError ? Colors.red.shade700 : Colors.green.shade400,
  //       duration: const Duration(seconds: 3),
  //       behavior: SnackBarBehavior.floating, // Makes it float above content
  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  //       margin: const EdgeInsets.all(10),
  //     ),
  //   );
  // }

  Future<void> makeTestPayment({required double amount, context}) async {
    print("🔵 makeTestPayment called with amount: $amount");
    // _showSnackBar(context, "Initiating payment...", isError: false);

    try {
      // Step 1: Call your Flask backend to get the client secret
      print("🔵 Sending POST request to backend for payment intent...");
      final response = await http.post(
        Uri.parse('$baseUrl/create-payment-intent'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'amount': (amount * 100).toInt()}), // Amount in cents
      );
      print("🟢 Received response from backend: ${response.body}");

      if (response.statusCode != 200) {
        final errorData = jsonDecode(response.body);
        final errorMessage = errorData['error'] ?? 'Unknown error from backend';
        throw Exception("Backend error: $errorMessage (Status: ${response.statusCode})");
      }

      final data = jsonDecode(response.body);
      final clientSecret = data['clientSecret'];
      print("🔵 Extracted clientSecret: $clientSecret");

      if (clientSecret == null || clientSecret.isEmpty) {
        throw Exception("Failed to get client secret from backend. Client secret is null or empty.");
      }

      // Step 2: Initialize the payment sheet
      print("🔵 Initializing payment sheet...");
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: 'FoodAppp',
          style: ThemeMode.system,
          allowsDelayedPaymentMethods: true, // Recommended for better user experience
          appearance: const PaymentSheetAppearance(),
          billingDetails: const BillingDetails(
            email: 'test@foodappp.com',
            name: 'Muffin',
            phone: '+233123456789',
          ),
        ),
      );
      print("✅ Payment sheet initialized.");

      // Step 3: Present the payment sheet
      print("🔵 Presenting payment sheet...");
      // This is the point where your app might be crashing.
      // The presentPaymentSheet() method can throw a StripeException if the user
      // cancels or if there's an issue with the payment.
      await Stripe.instance.presentPaymentSheet();

      print("🎉 Payment successful!");
      // _showSnackBar(context, "Payment successful!", isError: false);

      // Step 4: Navigate to success page
      // Use addPostFrameCallback to ensure navigation happens after the current
      // build cycle completes, especially after a potentially blocking operation
      // like presentPaymentSheet.
      // if (context.mounted) {
      //   WidgetsBinding.instance.addPostFrameCallback((_) {
      //     Navigator.pushReplacement(
      //       context,
      //       MaterialPageRoute(builder: (context) => const SuccessfulPage()),
      //     );
      //   });
      // }
    } on StripeException catch (e) {
      // Handle Stripe-specific errors gracefully
      print("❌ StripeException: ${e.error.localizedMessage}");
      final errorMessage = e.error.localizedMessage ?? 'Payment was cancelled or failed.';
      // _showSnackBar(context, "Payment Failed: $errorMessage", isError: true);
    } catch (e) {
      // Handle any other exceptions (network errors, JSON parsing errors, etc.)
      print("❌ General Error during payment: $e");
      // _showSnackBar(context, "An unexpected error occurred: $e", isError: true);
    }
    print("🔵 makeTestPayment finished.");
  }
}
