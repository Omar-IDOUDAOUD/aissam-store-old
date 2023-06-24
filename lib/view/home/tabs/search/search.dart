import 'package:aissam_store/core/constants/colors.dart';
import 'package:aissam_store/view/home/tabs/widgets/categorie_item.dart';
import 'package:aissam_store/view/home/tabs/widgets/product_card.dart';
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
    return CustomScrollView(
      slivers: [
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
          pinned: true,
          delegate: HeaderSearchBar(),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: TabBar(
              controller: _tabCtrl,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: CstColors.g,
              indicatorPadding: EdgeInsets.only(top: 29),
              isScrollable: true,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: CstColors.g,
              ),
              // indicatorWeight: ,
              labelPadding: EdgeInsets.symmetric(horizontal: 10),

              tabs: [
                Tab(
                  height: 30,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('All', style: TextStyle(color: Colors.black)),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: CstColors.g,
                        ),
                        padding: EdgeInsets.all(2),
                        child: Text(
                          '4',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Tab(
                  height: 30,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('High ranking',
                          style: TextStyle(color: Colors.black)),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: CstColors.g,
                        ),
                        padding: EdgeInsets.all(2),
                        child: Text(
                          '4',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Tab(
                  height: 30,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Best selling',
                          style: TextStyle(color: Colors.black)),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: CstColors.g,
                        ),
                        padding: EdgeInsets.all(2),
                        child: Text(
                          '4',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverFillRemaining(
          child: DefaultTabController(
            length: 3, // Specify the number of tabs
            child: Column(
              children: [
                TabBar(
                  isScrollable: true, // Enable horizontal scrolling
                  labelPadding: EdgeInsets.symmetric(horizontal: 16.0),
                  tabs: [
                    Tab(text: 'Tab 1'),
                    Tab(text: 'Tab 2'),
                    Tab(text: 'Tab 3'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    
                    children: [
                      // Add your tab content here
                      ListView.builder(
                          itemBuilder: (_, i) {
                            return SizedBox(
                              height: 20,
                              width: 20,
                              child: ColoredBox(color: Colors.red),
                            );
                          },
                          itemCount: 100),
                      Center(child: Text('Tab 2 Content')),
                      Center(child: Text('Tab 3 Content')),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )

        ///////////------------------------------------------------3rd part
        ///
        ///
        ///

        // SliverPadding(
        //   padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        //   sliver: SliverToBoxAdapter(
        //     child: SliverGrid(),
        //   )
        // ),
      ],
    );
  }

  late TabController _tabCtrl;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabCtrl = TabController(length: 3, vsync: this);
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
