import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:foodappp/components/my_button.dart';

import 'delivery_progress.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;

  // user wants to pay
  void userTappedPay() {
    if (formKey.currentState!.validate()) {
      //only if the form is valid
      showDialog(
      context: context,
       builder: (context) => AlertDialog(
        title: const Text('Payment Successful'),
        content: SingleChildScrollView(
          child: ListBody(
            children:[ 
              Text("Card Number: $cardNumber"),
              Text("Expiry Date: $expiryDate"),
              Text("Card Holder Name: $cardHolderName"),
              Text("CVV Code: $cvvCode"),
            ],
          ),
        ),
        actions: [
          // cancel button
          TextButton(
              onPressed: () =>  Navigator.pop(context),
            child: const Text('Cancel'),
            ),
            

          // yes button
          TextButton(
            onPressed: () => Navigator.push(context,
            MaterialPageRoute(
              builder: (context) => DeliveryProgressPage(),
              ),
              ),
            child: const Text('Yes'),
          ),

        ],
       ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Checkout"),
      ),
      body: Column(children: [
        // credit card payment
        CreditCardWidget(
        cardNumber: cardNumber, 
        expiryDate: expiryDate, 
        cardHolderName: cardHolderName, 
        cvvCode: cvvCode, 
        showBackView: isCvvFocused,
        onCreditCardWidgetChange: (p0) {},
        ),

        // credit card form
        CreditCardForm(
  cardNumber: cardNumber,
  expiryDate: expiryDate,
  cardHolderName: cardHolderName,
  cvvCode: cvvCode, // 👈 THIS comma was missing
  onCreditCardModelChange: (data) {
    setState(() {
      cardNumber = data.cardNumber;
      expiryDate = data.expiryDate;
      cardHolderName = data.cardHolderName;
      cvvCode = data.cvvCode;
    });
  },
  formKey: formKey,
),

         const Spacer(),
         MyButton(
          onTap: userTappedPay,
          text: "Pay now", 
          onTop: () {  },
          ),

          const SizedBox(height: 25),
      ],
      ),
    );
  }
  }