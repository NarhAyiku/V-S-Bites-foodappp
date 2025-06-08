    import 'package:flutter/material.dart';
    import 'package:foodappp/services/auth/auth_service.dart';
import 'package:foodappp/services/auth/login_or_register.dart';
    import '../pages/settings_page.dart';
    import 'my_drawer_tile.dart';

    class  MyDrawer extends StatelessWidget {
      const MyDrawer({super.key});

      void logout(BuildContext context) {
        final authService = AuthServices();
        authService.signOut();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginOrRegister(),
          ),
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Logged out successfully'),  
          ),
        );

      }

      @override
      Widget build(BuildContext context) {
        return Drawer(
         backgroundColor: Theme.of(context).colorScheme.background,
         child: Column(
         children: [
          // app logo
          Padding(
            padding: const EdgeInsets.only(top:100.0),
            child: Icon(Icons.lock_open_rounded,
                size: 80,color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Divider(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          //home list title
           MyDrawerTile(text: "H O M E",
               icon: Icons.home,
               onTap: () => Navigator.pop(context),
           ),

          //setting list title
           MyDrawerTile(text: "S E T T I N G S",
             icon: Icons.settings,
             onTap: () {
               Navigator.pop(context);
               Navigator.push(
                 context,
                 MaterialPageRoute(
                   builder: (context) => const SettingsPage(),
               ),
               );
             },
           ),

          const Spacer(),

          //logout list title
           MyDrawerTile(text: "L O G O U T",
             icon: Icons.logout,
             onTap: () {
                logout(context);
             },
           ),



           const SizedBox(height: 25),

        ],
      ),
    );
  }
    }
