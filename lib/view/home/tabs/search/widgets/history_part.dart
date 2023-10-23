import 'package:aissam_store/controller/search.dart';
import 'package:aissam_store/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:aissam_store/controller/search.dart' as ctrls;

class HistoryPart extends StatelessWidget {
  HistoryPart({super.key, required this.onSearchRequest});
  final Function(SearchHistoryItem searchHistoryItem) onSearchRequest;

  final ctrls.SearchController _controller = ctrls.SearchController.instance;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        SliverPadding(
          padding: EdgeInsets.all(25),
          sliver: SliverToBoxAdapter(
            child: SizedBox(
              height: 10,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'HISTORY',
                    style: Get.textTheme.bodyMedium!.copyWith(
                      color: CstColors.b,
                      height: 0.4,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 1,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: CstColors.b,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SliverList.separated(
          // padding: EdgeInsets.only(top: 15),
          itemCount: _controller.searchHistory.length,
          separatorBuilder: (_, i) => SizedBox(
            height: 10,
          ),
          itemBuilder: (_, i) {
            return InkWell(
                onTap: () =>
                    onSearchRequest(_controller.searchHistory.elementAt(i)),
                onFocusChange: (b) {
                  print('Focus changed: $b');
                },
                child:
                    _HistoryItem(data: _controller.searchHistory.elementAt(i)));
          },
        )
      ],
    );
  }
}

class _HistoryItem extends StatelessWidget {
  const _HistoryItem({super.key, required this.data});

  final SearchHistoryItem data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25),
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
    );
  }
}
