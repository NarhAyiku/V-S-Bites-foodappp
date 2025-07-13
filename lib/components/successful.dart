import 'package:flutter/material.dart';
import 'package:foodappp/Navigation.dart/Bottomnavigation.dart';

class Successfullogin extends StatelessWidget {
  final String message;

  const Successfullogin({Key? key, this.message = "Login Successful!"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Image.asset('assets/images/Continental/Screenshot 2025-06-16 at 00.30.48.png',
                    height: 300,
                    width: 300,
                  ),
                   SizedBox(height: 24),
              Text(
                message,
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
                textAlign: TextAlign.center,
                  ),
                   Text(
                'You have successfully logged into the app.',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 78, 77, 77),
                ),
                textAlign: TextAlign.center,
                  ),
                ],
              ),
              
            //  Spacer(),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                 Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => DashboardPage()),
                );
                },
                child:  Text('Continue', 
                style: TextStyle(fontSize: 16)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}