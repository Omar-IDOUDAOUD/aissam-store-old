// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member, curly_braces_in_flow_control_structures

import 'package:aissam_store/controller/search.dart';
import 'package:aissam_store/core/constants/colors.dart';
import 'package:aissam_store/controller/search.dart' as ctrl;
import 'package:aissam_store/view/home/tabs/search/filter_dialog.dart';
import 'package:aissam_store/view/home/tabs/search/widgets/history_part.dart';
import 'package:aissam_store/view/home/tabs/search/widgets/resultes_part.dart';
import 'package:aissam_store/view/home/tabs/search/widgets/search_bar_persistent.dart';
import 'package:aissam_store/view/home/tabs/search/widgets/searching_part.dart';
import 'package:aissam_store/view/public/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchTabV2 extends StatefulWidget {
  const SearchTabV2({super.key});

  @override
  State<SearchTabV2> createState() => _SearchTabV2State();
}

class _SearchTabV2State extends State<SearchTabV2>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  late final ScrollController _scrollController;
  final SearchControllerV2 _controller = SearchControllerV2.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();
    _controller.searchFieldController.addListener(_searchTextFieldListener);
    _controller.currentTabUIState.addListener(_tabMovementHandler);
    _controller.currentTabUIState.addListener(_scrollFocusModeHandler);
  }

  void _searchTextFieldListener() {
    if (_controller.searchFieldController.text.isNotEmpty)
      _controller.currentTabUIState.value = SearchTabUIStates.Searching;
    else if (_controller.searchFieldController.text.isEmpty)
      _controller.currentTabUIState.value = SearchTabUIStates.History;
  }

  void _tabMovementHandler() {
    if (_controller.currentTabUIState.value == SearchTabUIStates.History)
      _tabController.animateTo(0, duration: 300.milliseconds);
    else if (_controller.currentTabUIState.value == SearchTabUIStates.Searching)
      _tabController.animateTo(1, duration: 300.milliseconds);
    else if (_controller.currentTabUIState.value == SearchTabUIStates.Results)
      _tabController.animateTo(2, duration: 300.milliseconds);
  }

  void _scrollFocusModeHandler() {
    if (_controller.currentTabUIState.value == SearchTabUIStates.Searching) {
      print('Scroll Focus Mode enabled');
      _scrollController.animateTo(100,
          duration: 300.milliseconds, curve: Curves.linearToEaseOut);
    } else {
      print('Scroll Focus Mode disanabled');
      _scrollController.animateTo(0,
          duration: 300.milliseconds, curve: Curves.linearToEaseOut);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.searchFieldController.removeListener(_searchTextFieldListener);
    _controller.currentTabUIState.removeListener(_tabMovementHandler);
    _controller.currentTabUIState.removeListener(_scrollFocusModeHandler);
    _controller.currentTabUIState.value = SearchTabUIStates.values.elementAt(0);
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      controller: _scrollController,
      headerSliverBuilder: (_, __) => [
        SliverToBoxAdapter(
          child: TabHeaderTitles(),
        ),
        // SliverPersistentHeader(
        //   delegate: SearchBarHeaderPersistent(),
        //   pinned: true,
        //   floating: true,
        // ),
        SliverToBoxAdapter(
          child: SearchBarV2(),
        ),
      ],
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: [
          HistoryPartV2(),
          SuggestionsPartV2(),
          ResultsPartV2(),
        ],
      ),
    );
  }
}

class TabHeaderTitles extends StatefulWidget {
  const TabHeaderTitles({super.key});

  @override
  State<TabHeaderTitles> createState() => _TabHeaderTitlesState();
}

class _TabHeaderTitlesState extends State<TabHeaderTitles> {
  final SearchControllerV2 _controller = SearchControllerV2.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.currentTabUIState
        .addListener(_reasultsTabTextLeandingApperenceHandler);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.currentTabUIState
        .removeListener(_reasultsTabTextLeandingApperenceHandler);
    super.dispose();
  }

  bool _isResultsTab = false;
  void _reasultsTabTextLeandingApperenceHandler() {
    if (!_isResultsTab &&
        _controller.currentTabUIState == SearchTabUIStates.Results)
      setState(() {
        _isResultsTab = true;
      });
    else if (_isResultsTab &&
        _controller.currentTabUIState != SearchTabUIStates.Results)
      setState(() {
        _isResultsTab = false;
      });
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.blue,
      child: SizedBox(
        height: 100,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _isResultsTab ? 'Results Tab' : 'Search Results',
              style: Get.textTheme.headlineLarge!.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              "Let's find something",
              style: Get.textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.w500,
                height: 1.2,
                color: CstColors.a,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class SearchBarV2 extends StatefulWidget {
//   const SearchBarV2({super.key});

//   @override
//   State<SearchBarV2> createState() => SearchBarV2State();
// }

// class SearchBarV2State extends State<SearchBarV2> {
//   final SearchControllerV2 _controller = SearchControllerV2.instance;

//   @override
//   Widget build(BuildContext context) {
//     return
//   }
// }

class HistoryPartV2 extends StatelessWidget {
  const HistoryPartV2({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (_, i) {
        if (i == 0) return Text('History');
        i = 1;
        return Text(
          'Histsory Item',
          style: TextStyle(fontSize: 25),
        );
      },
    );
  }
}

class SuggestionsPartV2 extends StatelessWidget {
  const SuggestionsPartV2({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (_, i) {
        if (i == 0) return Text('History');
        i = 1;
        return Text(
          'Suggestion Item',
          style: TextStyle(fontSize: 25),
        );
      },
    );
  }
}

class ResultsPartV2 extends StatelessWidget {
  const ResultsPartV2({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (_, i) {
        if (i == 0) return Text('History');
        i = 1;
        return Text(
          'Results Item',
          style: TextStyle(fontSize: 25),
        );
      },
    );
  }
}

//////////////OLD PART
class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> with TickerProviderStateMixin {
  late final ValueNotifier<bool> _isSearchBarFloatingNotifier;
  late final ScrollController _scrollController;
  late final FocusNode _searchFocusNode;
  late final TabController _tabController;
  late final TabController _searchResultsTabController;
  late final ValueNotifier _searchResultsTabsAppearanceNotifier;
  late final ValueNotifier<bool> _backToTopFabNotifier;
  bool _searchResultsTabsAppearanceAn1 = false;
  bool _searchResultsTabsAppearanceAn2 = false;
  bool _showSearchResultsTitle = false;
  double? _titleHeaderHeight;

  ///
  final ctrl.SearchController _searchController =
      ctrl.SearchController.instance;

  @override
  void dispose() {
    _searchController.searchTextEditingController
        .removeListener(_partsMovementsHandler);
    _isSearchBarFloatingNotifier.dispose();
    _scrollController.dispose();
    _searchFocusNode.dispose();
    // _searchTextEditingController.dispose();
    _tabController.dispose();
    _searchResultsTabController.dispose();
    _searchResultsTabsAppearanceNotifier.dispose();
    _backToTopFabNotifier.dispose();
    super.dispose();
  }

  void _showResultsTabs() async {
    _searchResultsTabsAppearanceAn1 = true;
    _searchResultsTabsAppearanceNotifier.notifyListeners();
    await 200.milliseconds.delay();
    _searchResultsTabsAppearanceAn2 = true;
    _searchResultsTabsAppearanceNotifier.notifyListeners();
  }

  void _hideResultsTabs() async {
    // _searchResultsTabController.animateTo(0);
    _searchResultsTabsAppearanceAn2 = false;
    _searchResultsTabsAppearanceNotifier.notifyListeners();
    await 200.milliseconds.delay();
    _searchResultsTabsAppearanceAn1 = false;
    _searchResultsTabsAppearanceNotifier.notifyListeners();
  }

  double _getTitleHeaderHeight() {
    if (_titleHeaderHeight != null) return _titleHeaderHeight!;
    final RenderBox renderBox =
        _titleHeaderKey.currentContext?.findRenderObject() as RenderBox;

    final Size size = renderBox.size;
    _titleHeaderHeight = size.height + 20;
    return _titleHeaderHeight!;
  }

  double get _getScrollOffset =>
      _scrollController.hasClients ? _scrollController.offset : 0;

  final _titleHeaderKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    // _searchController.test();
    // _searchController.searchFor('DVRZXtp4egRqlwyg3UtI');
    _isSearchBarFloatingNotifier = ValueNotifier(false);
    _backToTopFabNotifier = ValueNotifier(false);
    _scrollController = ScrollController()
      ..addListener(() {
        if (_getScrollOffset <= _getTitleHeaderHeight() + 20) {
          _isSearchBarFloatingNotifier.value = false;
          _hideBackToTopFAB();
        } else {
          _isSearchBarFloatingNotifier.value = true;
          _showBackToTopFAB();
        }
      });
    _searchFocusNode = FocusNode();
    _tabController = TabController(length: 5, vsync: this)
      ..addListener(() async {
        if (_tabController.index >= 2) {
          _showResultsTabs();
          print('show tabs');
        } else {
          _hideResultsTabs();
          print('hide tabs');
        }
      });
    _searchResultsTabController = TabController(length: 3, vsync: this);
    _searchController.searchTextEditingController
        .addListener(_partsMovementsHandler);
    _searchResultsTabsAppearanceNotifier = ValueNotifier(false);
    // final x = _searchController
    //     .searchSuggestions('Abayas')
    //     .then((value) => print(value));
  }

  void _partsMovementsHandler() {
    if (_searchController.searchTextEditingController.text.isEmpty &&
        _tabController.index != 0) {
      _showHistory();
    } else if (_searchController.searchTextEditingController.text.isNotEmpty &&
        _tabController.index != 1) {
      _showSuggestions();
    }
  }

  void _showBackToTopFAB() {
    _backToTopFabNotifier.value = true;
  }

  void _hideBackToTopFAB() {
    _backToTopFabNotifier.value = false;
  }

  Future<void> _changeSearchResultType(int partIndex) async {
    _tabController.animateTo(partIndex, duration: 200.milliseconds);
    return await 200.milliseconds.delay();
  }

  void _onSeachingFocus() {
    _scrollController
        .animateTo(_getTitleHeaderHeight(),
            duration: 600.milliseconds, curve: Curves.linearToEaseOut)
        .then((value) {
      _isSearchBarFloatingNotifier.value = false;
      _searchFocusNode.requestFocus();
    });
  }

  void _showHistory() {
    print('SHOW HISTORYYY');
    _updateHeader(false);
    _tabController.animateTo(0, duration: 200.milliseconds);
  }

  void _showSuggestions() {
    print('SHOW SUGGESTIONS');
    _updateHeader(false);
    _tabController.animateTo(1, duration: 200.milliseconds);
  }

  void _showResults() {
    _searchFocusNode.unfocus();
    _updateHeader(true);
    _scrollController.animateTo(0,
        duration: 200.milliseconds, curve: Curves.linearToEaseOut);
    _tabController.animateTo(_searchResultsTabController.index + 2,
        duration: 200.milliseconds);
  }

  void _updateHeader(showResultHeader) {
    if (_showSearchResultsTitle == showResultHeader) return;
    setState(() {
      _showSearchResultsTitle = showResultHeader;
      _titleHeaderHeight = null;
    });
  }

  void _openSearchFilterDialog() {
    Get.dialog(
      SearchFilterDialog(),
      barrierColor: Colors.black.withOpacity(.3),
      barrierDismissible: true,
    );
  }

  void _submitSearchTerm(searchTerm) {
    _searchController.searchTerm = searchTerm;
    _showResults();
  }

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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _showSearchResultsTitle ? 'Search Results' : 'Search',
                        style: Get.textTheme.headlineLarge!.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      // Tool
                      if (_showSearchResultsTitle)
                        GestureDetector(
                          onTap: _openSearchFilterDialog,
                          child: Icon(
                            Icons.filter_list_rounded,
                            color: CstColors.a,
                            size: 30,
                          ),
                        )
                    ],
                  ),
                  if (_showSearchResultsTitle) SizedBox(height: 5),
                  Text(
                    _showSearchResultsTitle
                        ? _searchController.searchTextEditingController.text
                        : "Let's find something",
                    style: Get.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      height: 1.2,
                      color: CstColors.a,
                    ),
                  ),
                  if (_showSearchResultsTitle)
                    GetBuilder<ctrl.SearchController>(
                        init: _searchController,
                        id: _searchController.searchResultsNumberWidgetId,
                        builder: (c) {
                          print('updateeeeeeeeeeee');
                          final n = c.resultsNumberBy(ResultsTypes.values
                              .elementAt(_searchResultsTabController.index));
                          return Text(
                            n == null ? 'Loading ...' : '$n results',
                            style: Get.textTheme.bodyMedium!.copyWith(
                              // fontWeight: FontWeight.w600,
                              height: 1.2,
                              color: CstColors.a,
                            ),
                          );
                        }),
                ],
              ),
            ),
          ),
        ),
        // SliverPersistentHeader(
        //   pinned: true,
        //   floating: true,
        //   delegate: SearchBarHeaderPersistent(
        //       // isFloatingNotifier: _isSearchBarFloatingNotifier,
        //       // focusNode: _searchFocusNode,
        //       // onTap: () async {
        //       //   if (_tabController.index >= 2) _showSuggestions();
        //       //   await 100.milliseconds.delay();
        //       //   _onSeachingFocus();
        //       // },
        //       // controller: _searchController.searchTextEditingController,
        //       // onCommit: () async {
        //       //   _submitSearchTerm(SearchTerm(
        //       //       term: _searchController.searchTextEditingController.text));
        //       // },
        //       ),
        // ),
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
                                  isScrollable: true,
                                  indicatorSize: TabBarIndicatorSize.label,
                                  indicator: BoxDecoration(
                                      color: CstColors.g,
                                      borderRadius: BorderRadius.circular(5)),
                                  indicatorPadding: EdgeInsets.only(top: 22.5),
                                  labelPadding:
                                      EdgeInsets.symmetric(horizontal: 5),
                                  onTap: (i) async {
                                    await _changeSearchResultType(i + 2);
                                    _searchResultsTabsAppearanceNotifier
                                        .notifyListeners();
                                  },
                                  tabs: [
                                    _getSearchResultsTypeTab('All', 0),
                                    _getSearchResultsTypeTab('Bset Selling', 1),
                                    _getSearchResultsTypeTab('Most liked', 2),
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
        controller: TabController(length: 3, vsync: this),
        children: [
          ListView.builder(
            itemBuilder: (BuildContext context, int index) {},
          ),
        ],
      ),
    );
  }

  Widget _getSearchResultsTypeTab(String title, int index) {
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
          AnimatedSize(
            duration: 200.milliseconds,
            alignment: Alignment.centerLeft,
            curve: Curves.linearToEaseOut,
            child: GetBuilder<ctrl.SearchController>(
              init: _searchController,
              id: _searchController.searchResultsNumberWidgetId,
              builder: (c) {
                final n =
                    c.resultsNumberBy(ResultsTypes.values.elementAt(index));
                if (n == null) return SizedBox.shrink();
                return Row(
                  children: [
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 4, vertical: 0),
                        child: Text(
                          n.toString(),
                          style: Get.textTheme.displaySmall!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
