import 'package:aissam_store/view/home/nav_bar/nav_bar.dart';
import 'package:aissam_store/view/home/tabs/main/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final PageController _pageController;
  int _activeTabIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _pageController =
        PageController(initialPage: _activeTabIndex, keepPage: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                _activeTabIndex = index; 
                setState(() {});
              },
              children: [
                MainTab(),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: NavBar(
              activeIndex: _activeTabIndex,
              onIndexChange: (int index) {
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
