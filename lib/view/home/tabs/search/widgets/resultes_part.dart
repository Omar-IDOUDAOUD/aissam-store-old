import 'package:aissam_store/controller/search.dart';
import 'package:aissam_store/core/constants/colors.dart';
import 'package:aissam_store/models/product.dart';
import 'package:aissam_store/view/home/tabs/widgets/loading_product_card.dart';
import 'package:aissam_store/view/home/tabs/widgets/product_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aissam_store/controller/search.dart' as ctrls;

class ResultesPart extends StatefulWidget {
  ResultesPart({super.key});

  @override
  State<ResultesPart> createState() => _ResultesPartState();
}

class _ResultesPartState extends State<ResultesPart> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(25),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 2 / 4,
      ),
      itemCount: 500,
      itemBuilder: (_, i) {
        return ProductCard(data: Product.testModel());
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
              DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: widget.tabController.index == index
                      ? CstColors.g
                      : CstColors.b,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 0),
                  child: Text(
                    0.toString(),
                    style: Get.textTheme.displaySmall!
                        .copyWith(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
