import 'package:aissam_store/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({Key? key}) : super(key: key);

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (_, b) => [
        SliverPersistentHeader(
          floating: false,
          pinned: false,
          delegate: TitleHeader(
            title: 'Search Resultes',
            title2: 'White style abayas',
            title3: '20 resultes',
          ),
        ),
        SliverPersistentHeader(
          pinned: false,
          floating: true,
          delegate: HeaderSearchBar(),
        ),
        SliverPersistentHeader(
          pinned: false,
          floating: true,
          delegate: HeaderTabBar(c: _tabCtrl),
        ),
      ],
      body: PageView(
        children: [
          ListView(
            children: [
              SizedBox(
                width: 20,
                height: 100,
                child: ColoredBox(color: Colors.red),
              ),
              SizedBox(
                width: 20,
                height: 100,
                child: ColoredBox(color: Colors.blue),
              ),
              SizedBox(
                width: 20,
                height: 100,
                child: ColoredBox(color: Colors.yellow),
              ),
              SizedBox(
                width: 20,
                height: 100,
                child: ColoredBox(color: Colors.red),
              ),
              SizedBox(
                width: 20,
                height: 100,
                child: ColoredBox(color: Colors.blue),
              ),
              SizedBox(
                width: 20,
                height: 100,
                child: ColoredBox(color: Colors.yellow),
              ),
              SizedBox(
                width: 20,
                height: 100,
                child: ColoredBox(color: Colors.red),
              ),
              SizedBox(
                width: 20,
                height: 100,
                child: ColoredBox(color: Colors.blue),
              ),
              SizedBox(
                width: 20,
                height: 100,
                child: ColoredBox(color: Colors.yellow),
              ),
              SizedBox(
                width: 20,
                height: 100,
                child: ColoredBox(color: Colors.red),
              ),
              SizedBox(
                width: 20,
                height: 100,
                child: ColoredBox(color: Colors.blue),
              ),
              SizedBox(
                width: 20,
                height: 100,
                child: ColoredBox(color: Colors.yellow),
              ),
            ],
          )
        ],
      ),
    );
  }

  late TabController _tabCtrl;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabCtrl = TabController(length: 2, vsync: this);
  }
}

class TitleHeader extends SliverPersistentHeaderDelegate {
  final String title;
  final String title2;
  final String? title3;

  TitleHeader({required this.title, required this.title2, this.title3});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    print(shrinkOffset);
    return SizedBox.expand(
      child: Title(
        title: title,
        title2: title2,
        title3: title3,
      ),
    );
  }

  double get _fixExtent => title3 != null ? 95 : 80;
  @override
  // TODO: implement maxExtent
  double get maxExtent => _fixExtent;

  @override
  // TODO: implement minExtent
  double get minExtent => _fixExtent;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class Title extends StatelessWidget {
  const Title(
      {Key? key, required this.title, required this.title2, this.title3})
      : super(key: key);
  final String title;
  final String title2;
  final String? title3;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, right: 25, left: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Get.textTheme.headline1!.copyWith(
              color: CstColors.a,
              fontWeight: FontWeight.w400,
            ),
          ),
          if (title3 != null)
            SizedBox(
              height: 5,
            ),
          Text(
            title2,
            style: Get.textTheme.headline4!.copyWith(
              color: CstColors.a,
              fontWeight: title3 != null ? FontWeight.w500 : FontWeight.bold,
              height: 1,
            ),
          ),
          if (title3 != null)
            Text(
              title3!,
              style: Get.textTheme.headline5!.copyWith(
                color: CstColors.b.withOpacity(.8),
                fontWeight: FontWeight.bold,
                height: 1.4,
              ),
            ),
        ],
      ),
    );
  }
}

class HeaderTabBar extends SliverPersistentHeaderDelegate {
  final TabController c;

  HeaderTabBar({required this.c});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // TODO: implement build
    return SizedBox(
      height: _fixExtent,
      child: ColoredBox(
        color: Colors.white,
        child: Center(
          child: TabBar(
            controller: c,
            isScrollable: true,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(5)),
              color: CstColors.g,
            ),
            indicatorSize: TabBarIndicatorSize.label,
            indicatorPadding: EdgeInsets.only(
              top: _fixExtent - 5,
            ),
            labelPadding: EdgeInsets.symmetric(horizontal: 5),
            tabs: [
              Tab(
                // height: _fixExtent,
                child: Row(
                  children: [
                    Text(
                      'data data',
                      style: TextStyle(color: Colors.black),
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: CstColors.g.withOpacity(c.index == 0 ? .5 : .0),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: Text('5'),
                      ),
                    )
                  ],
                ),
              ),
              Tab(
                child: Text(
                  'data',
                  style: TextStyle(color: Colors.black),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  final double _fixExtent = 50;

  @override
  // TODO: implement maxExtent
  double get maxExtent => _fixExtent;

  @override
  // TODO: implement minExtent
  double get minExtent => _fixExtent;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return true;
  }
}

class HeaderSearchBar extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    print(shrinkOffset);
    return SizedBox.expand(
      child: SearchBar(),
    );
  }

  final double _fixExtent = 72;
  @override
  // TODO: implement maxExtent
  double get maxExtent => _fixExtent;

  @override
  // TODO: implement minExtent
  double get minExtent => _fixExtent;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: TextField(
        style: Get.textTheme.headline3!.copyWith(color: CstColors.a),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey[300],
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 5, vertical: 18),
          prefixIconConstraints: const BoxConstraints(
            minWidth: 40,
          ),
          prefixIcon: SvgPicture.asset(
            'assets/icons/search_small.svg',
            // height: 10,
            // width: 10,
            fit: BoxFit.scaleDown,
          ),
          isCollapsed: true,
          hintText: 'Search here...',
          hintStyle: Get.textTheme.headline3!.copyWith(
            color: CstColors.b.withOpacity(.5),
          ),
        ),
      ),
    );
  }
}
