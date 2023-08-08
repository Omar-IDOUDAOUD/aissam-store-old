// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:aissam_store/core/constants/colors.dart';
import 'package:aissam_store/view/home/tabs/search/widgets/history_part.dart';
import 'package:aissam_store/view/home/tabs/search/widgets/resultes_part.dart';
import 'package:aissam_store/view/home/tabs/search/widgets/search_bar_persistent.dart';
import 'package:aissam_store/view/home/tabs/search/widgets/searching_part.dart';
import 'package:aissam_store/view/public/text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> with TickerProviderStateMixin {
  late final ValueNotifier<bool> _isSearchBarFloatingNotifier;
  late final ScrollController _scrollController;
  late final TextEditingController _searchController;
  late final FocusNode _searchFocusNode;
  late final TabController _tabController;
  late final TabController _searchResultsTabController;
  late final ValueNotifier _searchResultsTabsAppearanceNotifier;
  bool _searchResultsTabsAppearanceAn1 = false; // for AnimatedSize widget
  bool _searchResultsTabsAppearanceAn2 = false; // for AnimatedContainer widget

  @override
  void dispose() {
    // TODO: implement dispose
    _isSearchBarFloatingNotifier.dispose();
    _scrollController.dispose();
    _searchFocusNode.dispose();
    _searchController.dispose();
    _tabController.dispose();
    _searchResultsTabController.dispose();
    _searchResultsTabsAppearanceNotifier.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isSearchBarFloatingNotifier = ValueNotifier(false);
    _scrollController = ScrollController()
      ..addListener(() {
        if (_getScrollOffset <= _getTitleHeaderHeight() + 20)
          _isSearchBarFloatingNotifier.value = false;
        else
          _isSearchBarFloatingNotifier.value = true;
      });
    _searchFocusNode = FocusNode();
    _tabController = TabController(length: 5, vsync: this)
      ..addListener(() async {
        // _searchResultsTabsAppearanceNotifier.value = _tabController.index >= 2;
        if (_tabController.index >= 2)
          _showResultsTabs();
        else
          _hideResultsTabs();
      });
    _searchResultsTabController = TabController(length: 3, vsync: this);
    _searchController = TextEditingController()
      ..addListener(() {
        if (_searchController.text.isEmpty)
          _changePart(0);
        else if (_searchController.text.isNotEmpty) _changePart(1);
        // else if (_showResultTabs)
      });
    _searchResultsTabsAppearanceNotifier = ValueNotifier(false);
  }

  void _showSearchResultTitle() {
    _titleHeaderHeight = null;
    setState(() {}); // to change header state;
    _scrollController.animateTo(0,
        duration: 200.milliseconds, curve: Curves.linearToEaseOut);
  }

  void _hideSearchResultTitle() {
    _titleHeaderHeight = null;
    setState(() {}); // to change header state;
  }

  void _showResultsTabs() async {
    // _titleHeaderHeight =
    //     null; // to reload the nex title header heighr for the next search bar focus;
    _searchResultsTabsAppearanceAn1 = true;
    _searchResultsTabsAppearanceNotifier.notifyListeners();
    await 200.milliseconds.delay();
    _searchResultsTabsAppearanceAn2 = true;
    _searchResultsTabsAppearanceNotifier.notifyListeners();
    // _showSearchResultTitle();
  }

  void _hideResultsTabs() async {
    _hideSearchResultTitle();
    _searchResultsTabsAppearanceAn2 = false;
    _searchResultsTabsAppearanceNotifier.notifyListeners();
    await 200.milliseconds.delay();
    _searchResultsTabsAppearanceAn1 = false;
    _searchResultsTabsAppearanceNotifier.notifyListeners();
  }

  Future<void> _changePart(int partIndex) async {
    _tabController.animateTo(partIndex, duration: 200.milliseconds);
    return await 200.milliseconds.delay();
  }

  double? _titleHeaderHeight;

  double _getTitleHeaderHeight() {
    if (_titleHeaderHeight != null) return _titleHeaderHeight!;
    final RenderBox renderBox =
        _titleHeaderKey.currentContext?.findRenderObject() as RenderBox;

    final Size size = renderBox.size;
    _titleHeaderHeight = size.height + 20;
    return _titleHeaderHeight!;
  }

  void _onRequestBarSearch() {
    _scrollController
        .animateTo(_getTitleHeaderHeight(),
            duration: 600.milliseconds, curve: Curves.linearToEaseOut)
        .then((value) {
      _isSearchBarFloatingNotifier.value = false;
      _searchFocusNode.requestFocus();
    });
  }

  double get _getScrollOffset =>
      _scrollController.hasClients ? _scrollController.offset : 0;

  final _titleHeaderKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      physics: BouncingScrollPhysics(),
      controller: _scrollController,
      headerSliverBuilder: (_, __) => [
        SliverPadding(
          padding: EdgeInsets.only(top: 20, right: 25, left: 25),
          sliver: SliverToBoxAdapter(
            child: AnimatedSize(
              duration: 200.milliseconds,
              child: Column(
                key: _titleHeaderKey,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _tabController.index >= 2 ? 'Search Results' : 'Search',
                    style: Get.textTheme.headlineLarge!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (_tabController.index >= 2) SizedBox(height: 5),
                  Text(
                    _tabController.index >= 2
                        ? 'White Style Abayas'
                        : "Let's find something",
                    style: Get.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      height: 1.2,
                      color: CstColors.a,
                    ),
                  ),
                  if (_tabController.index >= 2)
                    Text(
                      '20 result',
                      style: Get.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        height: 1.2,
                        color: CstColors.b,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
        SliverPersistentHeader(
          pinned: true,
          floating: true,
          delegate: SearchBarHeaderPersistent(
            isFloatingNotifier: _isSearchBarFloatingNotifier,
            focusNode: _searchFocusNode,
            onTap: _onRequestBarSearch,
            controller: _searchController,
            onCommit: () async {
              _searchFocusNode.unfocus();
              await _changePart(_searchResultsTabController.index + 2);
              _showSearchResultTitle();
            },
          ),
        ),
        SliverToBoxAdapter(
          child: ValueListenableBuilder(
              valueListenable: _searchResultsTabsAppearanceNotifier,
              builder: (_, __, ___) {
                return AnimatedSize(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  duration: 200.milliseconds,
                  child: !_searchResultsTabsAppearanceAn1
                      ? SizedBox.shrink()
                      : Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 5),
                            child: AnimatedOpacity(
                              duration: 200.milliseconds,
                              opacity: _searchResultsTabsAppearanceAn2 ? 1 : 0,
                              child: SizedBox(
                                height: 25,
                                child: TabBar(
                                  splashBorderRadius: BorderRadius.circular(7),

                                  controller: _searchResultsTabController,
                                  // TabController(
                                  //   length: 3,
                                  //   vsync: this,
                                  //   initialIndex: _tabController.index - 2,
                                  // ),
                                  isScrollable: true,
                                  indicatorSize: TabBarIndicatorSize.label,
                                  indicator: BoxDecoration(
                                      color: CstColors.g,
                                      borderRadius: BorderRadius.circular(5)),
                                  // indicatorWeight:2,
                                  indicatorPadding: EdgeInsets.only(top: 22.5),
                                  labelPadding:
                                      EdgeInsets.symmetric(horizontal: 5),
                                  onTap: (i) async {
                                    await _changePart(i + 2);
                                    _searchResultsTabController.animateTo(i);
                                    // setState(() {});
                                  },
                                  tabs: [
                                    _getSearchResultsTypeTab('All', 20, 0),
                                    _getSearchResultsTypeTab(
                                        'Bset Selling', 5, 1),
                                    _getSearchResultsTypeTab(
                                        'Most liked', 15, 2),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                );
              }),
        ),
      ],
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: [
          // HISTORY PART
          HistoryPart(), //0
          SearchingPart(), //1
          ResultesPart(testTmage: 'assets/images/image_2.png'), //2
          ResultesPart(testTmage: 'assets/images/image_3.png'), //3
          ResultesPart(testTmage: 'assets/images/image_4.png'), //4
        ],
      ),
    );
  }

  Widget _getSearchResultsTypeTab(String title, int resultsAmount, int index) {
    return Tab(
      child: Row(
        children: [
          Text(
            title,
            style: Get.textTheme.bodyMedium!.copyWith(
                color: _searchResultsTabController.index == index
                    ? CstColors.g
                    : CstColors.b,
                fontWeight: _searchResultsTabController.index == index
                    ? FontWeight.w500
                    : FontWeight.w400
                // color: MaterialStateColor.resolveWith((states) => )
                ),
          ),
          SizedBox(
            width: 4,
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              color: _searchResultsTabController.index == index
                  ? CstColors.g
                  : CstColors.b,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4, vertical: 0),
              child: Text(
                resultsAmount.toString(),
                style:
                    Get.textTheme.displaySmall!.copyWith(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
