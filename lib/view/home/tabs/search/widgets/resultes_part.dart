import 'package:aissam_store/controller/search.dart';
import 'package:aissam_store/core/constants/colors.dart';
import 'package:aissam_store/models/product.dart';
import 'package:aissam_store/view/home/tabs/widgets/loading_product_card.dart';
import 'package:aissam_store/view/home/tabs/widgets/product_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResultesPart extends StatefulWidget {
  ResultesPart({
    super.key,
  });

  // final ScrollController scrollController;

  @override
  State<ResultesPart> createState() => _ResultesPartState();
}

class _ResultesPartState extends State<ResultesPart> {
  final SearchControllerV2 _controller = SearchControllerV2.instance;
  // late final ScrollController scrollController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // widget.scrollController..bo;
    // widget.scrollController.addListener(() {
    //   print('Hellooo');
    // });
    _controller.search();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // widget.scrollController.removeListener(_dataPaginationHandler);
    super.dispose();
  }

  bool _dataPaginationHandler(ScrollUpdateNotification notification) {
    if (notification.metrics.pixels >= notification.metrics.maxScrollExtent) {
      print('Balak');
      _controller.search();
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchControllerV2>(
      id: _controller.paginationData.widgetToUpdateTag,
      init: _controller,
      builder: (SearchControllerV2 c) {
        print(
            'REBUILD WIDGET,is loading: ${c.paginationData.isLoading}, data lenght ${c.paginationData.loadedData.length}');
        if (!c.paginationData.isLoading && c.paginationData.loadedData.isEmpty)
          return Text('No Data');
        return NotificationListener<ScrollUpdateNotification>(
          onNotification: _dataPaginationHandler,
          child: GridView.builder(
            padding: EdgeInsets.all(25),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 2 / 4,
            ),
            itemCount: c.paginationData.loadedData.length +
                (c.paginationData.isLoading ? 3 : 0),
            itemBuilder: (_, i) {
              if (i >= c.paginationData.loadedData.length)
                return const LoadingProductCard();
              return ProductCard(
                  data: c.paginationData.loadedData.elementAt(i));
            },
          ),
        );
      },
    );
  }
}

class TabsBar extends StatefulWidget {
  const TabsBar({super.key, required this.tabController});

  final TabController tabController;

  @override
  State<TabsBar> createState() => _TabsBarState();
}

class _TabsBarState extends State<TabsBar> {
  @override
  Widget build(BuildContext context) {
    return TabBar(
      splashBorderRadius: BorderRadius.circular(7),
      controller: widget.tabController,
      isScrollable: true,
      indicatorSize: TabBarIndicatorSize.label,
      indicator: BoxDecoration(
          color: CstColors.g, borderRadius: BorderRadius.circular(5)),
      indicatorPadding: EdgeInsets.only(top: 22.5),
      labelPadding: EdgeInsets.symmetric(horizontal: 5),
      onTap: (i) async {
        setState(() {});
      },
      tabs: [
        _getSearchResultsTypeTab('All', 0),
        _getSearchResultsTypeTab('Bset Selling', 1),
        _getSearchResultsTypeTab('Most liked', 2),
      ],
    );
  }

  final SearchControllerV2 _controller = SearchControllerV2.instance;

  Widget _getSearchResultsTypeTab(String title, int index) {
    return Tab(
      child: Row(
        children: [
          Text(
            title,
            style: Get.textTheme.bodyMedium!.copyWith(
              color: widget.tabController.index == index
                  ? CstColors.g
                  : CstColors.b,
              fontWeight: widget.tabController.index == index
                  ? FontWeight.w500
                  : FontWeight.w400,
            ),
          ),
          Row(
            children: [
              SizedBox(
                width: 4,
              ),
              AnimatedSize(
                duration: 200.milliseconds,
                alignment: Alignment.centerLeft,
                curve: Curves.linearToEaseOut,
                child: GetBuilder<SearchControllerV2>(
                  init: _controller,
                  id: _controller.resultsCountWidgetsTag,
                  builder: (c) {
                    if (widget.tabController.index != index ||
                        _controller.resultsCount == null)
                      return SizedBox.shrink();
                    return DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: widget.tabController.index == index
                            ? CstColors.g
                            : CstColors.b,
                      ),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 4, vertical: 0),
                        child: Text(
                          c.resultsCount.toString(),
                          style: Get.textTheme.displaySmall!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
