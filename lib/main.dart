import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foodappp/services/auth/auth_gate.dart';
import 'package:foodappp/firebase_options.dart';
import 'package:foodappp/models/restaurants.dart';
import 'package:foodappp/themes/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => Restaurants()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
       home: const AuthGate(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}

String formatCurrency(double amount) {
  final format = NumberFormat.currency(
    locale: 'en_GH',
    symbol: 'GH₵',
    decimalDigits: amount.truncateToDouble() == amount ? 0 : 2,
  );
  return format.format(amount);
}

class PriceWidget extends StatelessWidget {
  final double price;

  const PriceWidget({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    return Text(
      formatCurrency(price),
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}