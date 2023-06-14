import 'package:aissam_store/view/home/nav_bar/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: PageView(
              controller: _pageController,
              children: [
                const ColoredBox(
                  color: Colors.blue,
                ),
                const ColoredBox(
                  color: Colors.yellow,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: NavBar(
              onPageChange: (int index) {
                _pageController.animateToPage(
                  index,
                  duration: 500.milliseconds,
                  curve: Curves.linearToEaseOut,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
