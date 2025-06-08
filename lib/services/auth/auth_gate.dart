import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
<<<<<<< HEAD
import '../../Splash_Screen/Splashscreen.dart';
// import 'package:foodappp/pages/admin/admin_page.dart';
// import 'package:foodappp/pages/home_page.dart';
// import 'package:foodappp/pages/login_page.dart';
// import 'package:foodappp/services/auth/auth_service.dart';
=======
import 'package:foodappp/pages/admin/admin_page.dart';
import 'package:foodappp/pages/home_page.dart';
import 'package:foodappp/pages/login_page.dart';
import 'package:foodappp/services/auth/auth_service.dart';
>>>>>>> 7d254673eea77aca16eeeb906fa5155b870e92e7

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
<<<<<<< HEAD
        return SplashScreen();
        // if (snapshot.hasData) {
        //   return FutureBuilder<bool>(
        //     future: AuthServices().currentUserIsAdmin(),
        //     builder: (context, adminSnapshot) {
        //       if (adminSnapshot.hasData && adminSnapshot.data == true) {
        //         return const AdminPage();
        //       }
        //       return const HomePage();
        //     },
        //   );
        // } else {
        //   return const LoginPage(onTap: null);
        // }
      },
    );
  }
}
=======
        if (snapshot.hasData) {
          return FutureBuilder<bool>(
            future: AuthServices().currentUserIsAdmin(),
            builder: (context, adminSnapshot) {
              if (adminSnapshot.hasData && adminSnapshot.data == true) {
                return const AdminPage();
              }
              return const HomePage();
            },
          );
        } else {
          return const LoginPage(onTap: null);
        }
      },
    );
  }
}
>>>>>>> 7d254673eea77aca16eeeb906fa5155b870e92e7
