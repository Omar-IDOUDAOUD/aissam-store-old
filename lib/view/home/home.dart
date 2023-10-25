import 'package:aissam_store/view/home/nav_bar/nav_bar.dart';
import 'package:aissam_store/view/home/tabs/my_cart/my_cart.dart';
import 'package:aissam_store/view/home/tabs/favorites/favorites.dart';
import 'package:aissam_store/view/home/tabs/main/main.dart';
import 'package:aissam_store/view/home/tabs/search/search.dart';
import 'package:aissam_store/view/home/tabs/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  // late final PageController _pageController;
  late final TabController _tabController;
  int _activeTabIndex = 0;

  @override
  void initState() {
    super.initState();

    // _pageController =
    //     PageController(initialPage: _activeTabIndex, keepPage: true);
    _tabController =
        TabController(length: 5, vsync: this, initialIndex: _activeTabIndex)
          ..addListener(() {
            setState(() {
              _activeTabIndex = _tabController.index;
            });
          });
  }

  @override
  void dispose() {
    super.dispose();
    // TODO: implement dispose
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          TabBarView(
            controller: _tabController,
            children: [
              MainTab(),
              FavoritesTab(),
              SearchTabV2(),
              MyCartTab(),
              SettingsTab(),
            ],
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: NavBar(
              activeIndex: _activeTabIndex,
              onIndexChange: (int index) {
                _tabController.animateTo(
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
