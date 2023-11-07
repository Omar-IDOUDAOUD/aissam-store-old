import 'package:aissam_store/controller/search.dart';
import 'package:aissam_store/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:aissam_store/controller/search.dart' as ctrls;

class HistoryPart extends StatelessWidget {
  // HistoryPart({t});
  // final Function(SearchHistoryItem searchHistoryItem) onSearchRequest;

  final ctrls.SearchControllerV2 _controller =
      ctrls.SearchControllerV2.instance;

  @override
  Widget build(BuildContext context) {
    print(
        'test 12: ${_controller.history.map((e) => e.searchQuery).toString()}');
    return ListView.separated(
      padding: EdgeInsets.all(25),
      itemCount: _controller.history.length + 1,
      itemBuilder: (_, i) {
        if (i == 0)
          return Text(
            'HISTORY',
            style: Get.textTheme.bodyMedium!.copyWith(
              color: CstColors.b,
              fontWeight: FontWeight.w400,
            ),
          );
        i -= 1;
        return _HistoryItem(
          data: _controller.history.elementAt(i),
          onTap: () {
            final searchTerm = _controller.history.elementAt(i);
            _controller.searchFieldController.text = searchTerm.searchQuery;
            _controller.setSearchTerm(SearchTerm(
                query: searchTerm.searchQuery, id: searchTerm.tagId));
            _controller.currentTabUIState.value =
                ctrls.SearchTabUIStates.Results;
          },
        );
      },
      separatorBuilder: (_, i) => SizedBox(
        height: 10,
      ),
    );
  }
}

class _HistoryItem extends StatelessWidget {
  const _HistoryItem({super.key, required this.data, required this.onTap});

  final SearchHistoryItem data;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ColoredBox(
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.searchQuery,
                  style: Get.textTheme.headlineMedium!.copyWith(
                    color: CstColors.a,
                    height: 1.2,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  data.searchDateTime.toString(),
                  style: Get.textTheme.bodySmall!.copyWith(
                    color: CstColors.c,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            SvgPicture.asset('assets/icons/search_small.svg')
          ],
        ),
      ),
    );
  }
}
