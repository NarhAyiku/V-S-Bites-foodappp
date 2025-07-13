import 'package:flutter/material.dart';
import 'package:foodappp/Navigation.dart/Bottomnavigation.dart';
import 'package:foodappp/models/ordercart.dart';

class SuccessfulPage extends StatelessWidget {
  final double totalAmount;
  
  const SuccessfulPage({Key? key, required this.totalAmount}) : super(key: key);

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
              Icon(
                Icons.check_circle_outline,
                color: Colors.orange,
                size: 100,
              ),
              const SizedBox(height: 24),
              Text(
                'Order Successful!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Thank you for your order. Your order is being processed successfully.',
                style: TextStyle(
                  fontSize: 16,
                  color: const Color.fromARGB(255, 50, 50, 50),
                ),
                textAlign: TextAlign.center,
              ),
               const SizedBox(height: 16),
              Text(
                'Pay $totalAmount on delivery!',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 50, 50, 50),
                ),
                textAlign: TextAlign.center,
              ),
              // const SizedBox(height: 32),
              // ElevatedButton(
              //   onPressed: () {
              //     // Navigator.pushReplacement(
              //     //     context,
              //     //     MaterialPageRoute(
              //     //       builder: (context) => const Ordercart(),
              //     //     ) // Replace with your home page widget
              //     //     );
              //   },
              //   child: const Text('Track Your Order'),
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: Color.fromARGB(255, 221, 84, 16),
              //     foregroundColor: Colors.white,
              //     padding:
              //         const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(8),
              //     ),
              //   ),
              // ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3), 
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DashboardPage(),
                        ) 
                        );
                  },
                  child: const Text('Back to Home'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 221, 84, 16),
                    foregroundColor: Colors.white,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 40, vertical: 13),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
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
