// ignore_for_file: prefer_const_constructors

import 'package:aissam_store/controller/search.dart';
import 'package:aissam_store/core/constants/colors.dart';
import 'package:aissam_store/controller/search.dart' as ctrl;
import 'package:aissam_store/view/home/tabs/search/filter_dialog.dart';
import 'package:aissam_store/view/home/tabs/search/widgets/history_part.dart';
import 'package:aissam_store/view/home/tabs/search/widgets/resultes_part.dart';
import 'package:aissam_store/view/home/tabs/search/widgets/search_bar_persistent.dart';
import 'package:aissam_store/view/home/tabs/search/widgets/suggestions_part.dart';
import 'package:aissam_store/view/public/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabHeaderTitles extends StatefulWidget {
  const TabHeaderTitles({super.key});

  static const double height1 = 65 + 20; //20: padding
  static const double height2 = 80 + 20;

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
        _controller.currentTabUIState.value == SearchTabUIStates.Results)
      setState(() {
        _isResultsTab = true;
      });
    else if (_isResultsTab &&
        _controller.currentTabUIState.value != SearchTabUIStates.Results)
      setState(() {
        _isResultsTab = false;
      });
  }

  @override
  Widget build(BuildContext context) {
    final double hPadding = 20;
    final double height =
        (_isResultsTab ? TabHeaderTitles.height2 : TabHeaderTitles.height1) -
            20;
    return AnimatedSize(
      duration: 300.milliseconds,
      child: Padding(
        padding: EdgeInsets.fromLTRB(25, hPadding, 25, 0),
        child: SizedBox(
          height: height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _isResultsTab ? 'Search Results' : 'Search',
                    style: Get.textTheme.headlineLarge!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (_isResultsTab)
                    GestureDetector(
                      onTap: () => Get.dialog(SearchFilterDialog()),
                      child: ColoredBox(
                        color: Colors.transparent,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 3),
                          child: Icon(
                            Icons.filter_list_rounded,
                            color: CstColors.a,
                            size: 25,
                          ),
                        ),
                      ),
                    )
                ],
              ),
              Text(
                _isResultsTab
                    ? _controller.searchFieldController.text
                    : "Let's find something",
                style: Get.textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                  height: 1.2,
                  color: CstColors.a,
                ),
              ),
              if (_isResultsTab)
                GetBuilder<SearchControllerV2>(
                  id: _controller.resultsCountWidgetsTag,
                  init: _controller,
                  builder: (c) {
                    if (c.resultsCount == null) return Text('Loading...');
                    return Text('${c.resultsCount!.toString()} results');
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
