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
    return Column(
      children: [
        Text(
          'HISTORY',
          style: Get.textTheme.bodyMedium!.copyWith(
            color: CstColors.b,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Expanded(
          child: ListView.separated(
            itemCount: 100,
            itemBuilder: (_, i) => _HistoryItem(
              // data: _controller.history.elementAt(i),
              data: SearchHistoryItem(
                searchQuery: 'History ',
                searchDateTime: DateTime.now(),
              ),
            ),
            separatorBuilder: (_, i) => SizedBox(
              height: 10,
            ),
          ),
        ),
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
