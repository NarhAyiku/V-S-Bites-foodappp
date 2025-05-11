// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:foodappp/services/auth/auth_service.dart';
import 'package:foodappp/components/my_button.dart';
import 'package:foodappp/components/my_textfield.dart';
import 'package:foodappp/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;

  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Login method with error handling
  void login() async {
    // get the instance of the auth service
    final _authService = AuthServices();

    // try sign in
    try{
      await _authService.signInWithEmailAndPassword(
        emailController.text,
        passwordController.text,
      );
    }
    // display any errors
    catch(e){
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(e.toString()),
        ),
      );
    }

    // Show loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      // Simulate network delay or authentication process
      await Future.delayed(const Duration(seconds: 2));

      // Here you'd replace with real authentication logic:
      // await AuthService.signIn(email, password);

      // If login successful, navigate to HomePage
      if (!mounted) return; // safety check for async gaps
      Navigator.pop(context); // close loading
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } catch (e) {
      if (!mounted) return;
      Navigator.pop(context); // close loading
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed: $e')),
      );
    }
  }

  void forgotPassword() async {
    // Show dialog to enter email
    String? email = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset Password'),
        content: TextField(
          controller: TextEditingController(text: emailController.text),
          decoration: const InputDecoration(
            hintText: 'Enter your email',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, emailController.text),
            child: const Text('Reset'),
          ),
        ],
      ),
    );

    if (email != null && email.isNotEmpty) {
      try {
        // Show loading indicator
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );

        // Send password reset email
        await AuthServices().resetPassword(email);

        // Remove loading indicator
        if (!mounted) return;
        Navigator.pop(context);

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Password reset email sent!'),
            backgroundColor: Colors.green,
          ),
        );
      } catch (e) {
        // Remove loading indicator
        if (!mounted) return;
        Navigator.pop(context);

        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: theme.background,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              const SizedBox(height: 10),

              // Lock Icon
              Icon(
                Icons.lock_open_rounded,
                size: 80,
                color: theme.inversePrimary,
              ),

              const SizedBox(height: 10),

              // App Slogan
              Text(
                "Food Delivery App",
                style: TextStyle(
                  fontSize: 18,
                  color: theme.inversePrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 30),

              // Email field
              MyTextField(
                controller: emailController,
                hintText: "Email",
                obscureText: false,
              ),

              const SizedBox(height: 10),

              // Password field
              MyTextField(
                controller: passwordController,
                hintText: "Password",
                obscureText: true,
              ),

              // Add Forgot Password button
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: forgotPassword,
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(
                      color: theme.inversePrimary,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Sign In Button
              MyButton(
                text: "Sign In",
                onTap: login, 
                onTop: () {},
              ),

              const SizedBox(height: 25),

              // Register Now Text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Not a member?",
                    style: TextStyle(color: theme.inversePrimary),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text(
                      "Register now",
                      style: TextStyle(
                        color: theme.inversePrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
