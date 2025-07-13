import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:foodappp/components/PhoneForm.dart';
import 'package:foodappp/const.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
  final String baseUrl = AppConstants.baseUrl;
Future<Map<String, dynamic>> sendPhoneNumber(String phone) async {

  final url = Uri.parse('$baseUrl/phone_number'); // Replace with your local IP

  try {
    print('Sending phone number: $phone to $url');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'phone': phone}),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      final error = jsonDecode(response.body);
      throw Exception(error['error'] ?? 'Unknown error');
    }
  } catch (e) {
    print('Error occurred: $e');
    throw Exception('Failed to connect: $e');
  }
}


Future<bool> verifyCode(String phone, String code) async {
  final url = Uri.parse('$baseUrl/verify_code'); // your IP

  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'phone': phone, 'code': code}),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      final error = jsonDecode(response.body);
      throw Exception(error['error'] ?? 'Verification failed');
    }
  } catch (e) {
    throw Exception('$e');
  }
}


Future<void> logout(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('isLoggedIn');
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (_) => PhoneForm()),
  );
}