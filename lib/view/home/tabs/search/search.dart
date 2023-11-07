// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member, curly_braces_in_flow_control_structures

import 'package:aissam_store/controller/search.dart';
import 'package:aissam_store/core/constants/colors.dart';
import 'package:aissam_store/controller/search.dart' as ctrl;
import 'package:aissam_store/view/home/tabs/search/filter_dialog.dart';
import 'package:aissam_store/view/home/tabs/search/widgets/header_titles.dart';
import 'package:aissam_store/view/home/tabs/search/widgets/history_part.dart';
import 'package:aissam_store/view/home/tabs/search/widgets/resultes_part.dart'
    as ResultsPart;
import 'package:aissam_store/view/home/tabs/search/widgets/search_bar_persistent.dart';
import 'package:aissam_store/view/home/tabs/search/widgets/suggestions_part.dart';
import 'package:aissam_store/view/public/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> with TickerProviderStateMixin {
  late final TabController _tabController;
  late final ScrollController _scrollController;
  final SearchControllerV2 _controller = SearchControllerV2.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _resultsTabController = TabController(length: 3, vsync: this)
      ..addListener(_resultsTabMovementHnadler);
    _scrollController = ScrollController();
    _controller.searchFieldController.addListener(_searchTextFieldListener);
    _controller.currentTabUIState.addListener(_tabMovementHandler);
    _controller.currentTabUIState.addListener(_scrollFocusModeHandler);
  }

  int get _getResultsCurrentTabIndex => _resultsTabController.index + 2;

  void _resultsTabMovementHnadler() {
    _tabController.animateTo(_getResultsCurrentTabIndex);
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
      _tabController.animateTo(_getResultsCurrentTabIndex,
          duration: 300.milliseconds);
  }

  void _scrollFocusModeHandler() {
    if (_controller.currentTabUIState.value == SearchTabUIStates.Searching) {
      print('Scroll Focus Mode enabled');
      _scrollController.animateTo(TabHeaderTitles.height1,
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
    _controller.searchFieldController
      ..removeListener(_searchTextFieldListener)
      ..clear();
    _controller.currentTabUIState.removeListener(_tabMovementHandler);
    _controller.currentTabUIState.removeListener(_scrollFocusModeHandler);
    _controller.currentTabUIState.value = SearchTabUIStates.values.elementAt(0);
    _tabController.dispose();
    _resultsTabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  late final TabController _resultsTabController;

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      controller: _scrollController,
      headerSliverBuilder: (_, __) => [
        SliverToBoxAdapter(
          child: TabHeaderTitles(),
        ),
        SliverPersistentHeader(
          delegate: SearchBarHeaderPersistent(),
          pinned: true,
          floating: true,
        ),
        SliverPadding(
          padding: EdgeInsets.only(top: 10),
          sliver: SliverToBoxAdapter(
            child: ValueListenableBuilder<SearchTabUIStates>(
              valueListenable: _controller.currentTabUIState,
              child: ResultsPart.TabsBar(tabController: _resultsTabController),
              builder: (_, v, c) {
                return AnimatedSize(
                  duration: 150.milliseconds,
                  child: AnimatedSwitcher(
                    duration: 150.milliseconds,
                    child: v == SearchTabUIStates.Results
                        ? SizedBox(height: 25, child: c)
                        : SizedBox.shrink(),
                    transitionBuilder: (child, a) {
                      return FadeTransition(
                        opacity: a,
                        child: child,
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ],
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: [
          HistoryPart(),
          SuggestionsPart(),
          ResultsPart.ResultesPart(),
          ResultsPart.ResultesPart(),
          ResultsPart.ResultesPart(),
        ],
      ),
    );
  }
}
