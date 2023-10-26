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

  static const double height1 = 65;
  static const double height2 = 80;

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
    return ColoredBox(
      color: Colors.blue,
      child: AnimatedSize(
        duration: 300.milliseconds,
        child: SizedBox(
          height:
              _isResultsTab ? TabHeaderTitles.height2 : TabHeaderTitles.height1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
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
              if (_isResultsTab)
                SizedBox(
                  height: 15,
                  width: 50,
                  child: ColoredBox(color: Colors.red),
                )
            ],
          ),
        ),
      ),
    );
  }
}
