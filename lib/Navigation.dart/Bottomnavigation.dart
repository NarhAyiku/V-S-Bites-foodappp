import 'package:flutter/material.dart';
import 'package:foodappp/components/my_cart_tile.dart';
import 'package:foodappp/pages/cart_page.dart';
import 'package:foodappp/pages/cartme.dart';
import 'package:foodappp/pages/home_page.dart';
import 'package:foodappp/pages/settings_page.dart';
import 'package:gap/gap.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int indexMenu = 0;
  final menu = [
    {
      'icon': 'assets/images/Salads/house-chimney_9239762.png',
      'icon_active': 'assets/images/Salads/house-chimney_9239762.png',
      'fragment': const HomePage(),
    },
    {
      'icon': 'assets/images/Salads/memo-circle-check_9585392.png',
      'icon_active': 'assets/images/Salads/memo-circle-check_9585392.png',
      'fragment': Cartme(),
    },
    {
      'icon': 'assets/images/Salads/settings_3917058.png',
      'icon_active': 'assets/images/Salads/settings_3917058.png',
      'fragment': const SettingsPage(),
      // 'fragment': const Shop(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: menu[indexMenu]['fragment'] as Widget,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Row(
          children: List.generate(menu.length, (index) {
            Map item = menu[index];
            bool isActive = indexMenu == index;
            return Expanded(
              child: InkWell(
                onTap: () {
                  indexMenu = index;
                  setState(() {});
                },
                child: SizedBox(
                  height: 90,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Gap(20),
                      ImageIcon(
                        AssetImage(
                          item[isActive ? 'icon_active' : 'icon'],
                        ),
                        size: 24,
                        // color: Colors isActive ? red : white,
                        color: isActive
                            ? const Color.fromARGB(255, 0, 0, 0)
                            : Colors.grey,
                        // color: Color(isActive ? 620f0f : 0xffA2A2A2),
                      ),
                      // if (isActive) const Gap(6),
                      // if (isActive)
                      //   Container(
                      //     height: 5,
                      //     width: 10,
                      //     decoration: BoxDecoration(
                      //       color: const Color.fromARGB(255, 214, 100, 38),
                      //       borderRadius: BorderRadius.circular(18),
                      //     ),
                      //   ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
