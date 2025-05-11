   import 'package:flutter/material.dart';
import 'package:foodappp/pages/login_page.dart';
import 'package:foodappp/pages/register_page.dart';

    class LoginOrRegister extends StatefulWidget {
      const LoginOrRegister ({super.key});

      @override
      State<LoginOrRegister> createState() => _LoginOrRegisterState();
    }

    class _LoginOrRegisterState extends State<LoginOrRegister> {

      // initially, show log in page
      bool shoeLoginPage = true;

      // toggle between login and register page
      void togglePages() {
        setState(() {
          shoeLoginPage = !shoeLoginPage;
        });
      }
   @override
      Widget build(BuildContext context){
        if (shoeLoginPage) {
          return LoginPage(onTap: togglePages);
        } else {
          return RegisterPage(onTap: togglePages);
        }
      }
   }
