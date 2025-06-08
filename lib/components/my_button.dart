import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String text;

  const MyButton({
    super.key,
    required this.onTap,
<<<<<<< HEAD
    required this.text,
=======
    required this.text, 
>>>>>>> 7d254673eea77aca16eeeb906fa5155b870e92e7
    required Null Function() onTop,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
<<<<<<< HEAD
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: Colors.orange,
=======
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
>>>>>>> 7d254673eea77aca16eeeb906fa5155b870e92e7
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
<<<<<<< HEAD
              color: Colors.white,
=======
              color: Theme.of(context).colorScheme.inversePrimary,
>>>>>>> 7d254673eea77aca16eeeb906fa5155b870e92e7
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
<<<<<<< HEAD
}
=======
}
>>>>>>> 7d254673eea77aca16eeeb906fa5155b870e92e7
