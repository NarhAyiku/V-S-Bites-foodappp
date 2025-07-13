import 'package:flutter/material.dart';
import 'package:foodappp/Navigation.dart/Bottomnavigation.dart';
import 'package:foodappp/Splash_Screen/Onboarding.dart';
import 'package:foodappp/components/PhoneForm.dart';
import 'package:foodappp/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static const String KEYLOGIN = "is_first_login";

  @override
  void initState() {
    super.initState();
    checkFirstTime();
  }

   Future<bool> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  Future<void> checkFirstTime() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool(KEYLOGIN) ?? true;

    await Future.delayed(const Duration(seconds: 3));

    if (isFirstTime) {
      await prefs.setBool(KEYLOGIN, false);
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const OnboardingScreen()),
        );
      }
    } else if (await _checkLoginStatus() == false) {
      // User is not logged in
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => PhoneForm()),
        );
      }
    } else {
      // Returning user
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const DashboardPage()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Your logo here
            Image.asset(
              'assets/images/Continental/logo.png',
              width: 150,
              height: 150,
            ),
          ],
        ),
      ),
    );
  }
}
