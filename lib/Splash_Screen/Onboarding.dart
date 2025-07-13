import 'package:flutter/material.dart';
import 'package:foodappp/Navigation.dart/Bottomnavigation.dart';
import 'package:foodappp/components/PhoneForm.dart';
import 'package:foodappp/pages/home_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingContent> _contents = [
    OnboardingContent(
      image: "assets/images/Continental/burger.jpg",
      title: "Quick & Easy Ordering",
      description: "Order your favorite meals at affordable prices.",
      backgroundColor: Color(0xFFE8F5E9),
    ),
    OnboardingContent(
      image: "assets/images/Continental/quality=100.png",
      title: "Fast Delivery",
      description: "Enjoy lightning-fast delivery within campus.",
      backgroundColor: Color(0xFFE3F2FD),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: _contents.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              // ...existing code...
              itemBuilder: (context, index) {
                return Container(
                  color: _contents[index].backgroundColor,
                  child: Stack(
                    children: [
                      // Background Image
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(_contents[index].image),
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.4),
                              BlendMode.darken,
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        bottom: 100,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _contents[index].title,
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                _contents[index].description,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.white,
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // SizedBox(
                      //       height: 200,
                      //     ),
                      // Content
                      Positioned(
                        bottom: 0,
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Row(
                              //   children: List.generate(
                              //     _contents.length,
                              //     (index) => buildDot(index),
                              //   ),
                              // ),
                              ElevatedButton(
                                onPressed: () {
                                  if (_currentPage == _contents.length - 1) {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                               PhoneForm()),
                                    );
                                  } else {
                                    _pageController.nextPage(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.easeInOut,
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange,
                                  minimumSize: Size(
                                      MediaQuery.of(context).size.width - 40,
                                      50), // Full width minus padding
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 20),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                child: Text(
                                  _currentPage == _contents.length - 1
                                      ? "Get Started"
                                      : "Continue",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
// ...existing code...
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDot(int index) {
    return Container(
      height: 10,
      width: _currentPage == index ? 25 : 10,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: _currentPage == index ? Colors.orange : Colors.grey,
      ),
    );
  }
}

class OnboardingContent {
  final String image;
  final String title;
  final String description;
  final Color backgroundColor;

  OnboardingContent({
    required this.image,
    required this.title,
    required this.description,
    required this.backgroundColor,
  });
}
