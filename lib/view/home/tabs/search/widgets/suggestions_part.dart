// // ignore_for_file: curly_braces_in_flow_control_structures

// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:math';

import 'package:aissam_store/controller/product.dart';
import 'package:aissam_store/core/constants/colors.dart';
import 'package:aissam_store/data/model/category.dart';
import 'package:aissam_store/view/home/tabs/widgets/categorie_item.dart';
import 'package:aissam_store/view/home/tabs/widgets/loading_category_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:aissam_store/controller/search.dart' as ctrls;

class SuggestionsPart extends StatefulWidget {
  const SuggestionsPart({super.key});

  @override
  State<SuggestionsPart> createState() => _SuggestionsPartState();
}

class _SuggestionsPartState extends State<SuggestionsPart> {
  ctrls.SearchControllerV2 _controller = ctrls.SearchControllerV2.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.searchFieldController.addListener(_searchFieldListener);
    _checkHistoryTermExistence();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.searchFieldController.removeListener(_searchFieldListener);
    super.dispose();
  }

  void _searchFieldListener() {
    _checkHistoryTermExistence();
    setState(() {});
  }

  final List<ctrls.SearchTerm> _previousSuggestionsResults =
      List.empty(growable: true);

  final List<ctrls.SearchTerm> _suggsetionsFromHistory =
      List.empty(growable: true);
  void _checkHistoryTermExistence() {
    if (_controller.searchFieldController.text.isEmpty) return;
    final result = _controller.history.where((element) =>
        element.searchQuery.startsWith(_controller.searchFieldController.text));
    _suggsetionsFromHistory
      ..clear()
      ..addAll(result
          .map((e) => ctrls.SearchTerm(query: e.searchQuery, id: e.tagId))
          .toList());
    print(
        'test 11: find new history sugg: ${_suggsetionsFromHistory.map((e) => e.query).toString()}');
  }

  final ValueNotifier<Object> _categoriesChangeNotifier = ValueNotifier(Object);

  @override
  Widget build(BuildContext context) {
    // TODO: implement

    return FutureBuilder<List<ctrls.SearchTerm>>(
      future: _controller.searchFieldController.text.isNotEmpty
          ? _controller
              .suggestions()
              .then((value) => _previousSuggestionsResults
                ..clear()
                ..addAll(value))
          : null,
      initialData: _previousSuggestionsResults,
      builder: (context, snapshot) {
        final isWaiting = snapshot.connectionState == ConnectionState.waiting;
        // final noData = snapshot.data!.isEmpty;
        final hasError = snapshot.hasError;

        return CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              sliver: _sliverToChild(
                ValueListenableBuilder(
                    valueListenable: _categoriesChangeNotifier,
                    builder: (_, __, ___) {
                      final selectedCategoriesLength =
                          _controller.filterParameters.categoriesNames.length;
                      return Row(
                        children: [
                          Text(
                            'SEARCH COLLECTIONS',
                            style: Get.textTheme.bodyLarge!.copyWith(
                              color: ColorsConsts.a,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Spacer(),
                          Text(
                            selectedCategoriesLength != 0
                                ? '$selectedCategoriesLength categories | '
                                : 'All Categories',
                            style: Get.textTheme.bodyMedium!.copyWith(
                              color: ColorsConsts.b,
                              height: 0.4,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          if (selectedCategoriesLength != 0)
                            GestureDetector(
                              onTap: () {
                                _controller.setCategoriesFilter(
                                    List.empty(growable: true));
                                _categoriesChangeNotifier.notifyListeners();
                              },
                              child: Text(
                                'All',
                                style: Get.textTheme.bodyMedium!.copyWith(
                                  color: ColorsConsts.g,
                                  backgroundColor: Colors.transparent,
                                  height: 0.4,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                        ],
                      );
                    }),
              ),
            ),
            _sliverToChild(
              ValueListenableBuilder(
                valueListenable: _categoriesChangeNotifier,
                builder: (_, __, ___) {
                  return _CategoriesCostumizationList(
                    onChangeList: _categoriesChangeNotifier.notifyListeners,
                  );
                },
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.fromLTRB(25, 10, 25, 0),
              sliver: SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'SUGGESTIONS',
                      style: Get.textTheme.bodyLarge!.copyWith(
                        color: ColorsConsts.a,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    if (isWaiting)
                      SizedBox.square(
                        dimension: 15,
                        child: CircularProgressIndicator(
                          strokeWidth: 1.5,
                          color: ColorsConsts.b,
                        ),
                      )
                  ],
                ),
              ),
            ),
            if (hasError)
              _sliverToChild(Text('An Error occurred'))
            else
              SliverList.builder(
                itemCount:
                    _suggsetionsFromHistory.length + snapshot.data!.length,
                itemBuilder: (_, i) {
                  final isFromHistory = i < _suggsetionsFromHistory.length;
                  final term = isFromHistory
                      ? _suggsetionsFromHistory.elementAt(i)
                      : snapshot.data!
                          .elementAt(i - _suggsetionsFromHistory.length);
                  final userInput = _controller.searchFieldController.text;
                  final suggestion = term.query;
                  String boldClip;
                  String lightClip;
                  int index =
                      suggestion.toLowerCase().indexOf(userInput.toLowerCase());
                  if (index >= 0) {
                    boldClip =
                        suggestion.substring(index, index + userInput.length);
                    lightClip = suggestion.substring(index + userInput.length);
                  } else {
                    boldClip = '';
                    lightClip = suggestion;
                  }
                  return _SuggestionItem(
                    isFromHistory: isFromHistory,
                    boldClip: boldClip,
                    normalClip: lightClip,
                    onClick: () {
                      _controller.searchFieldController.text = term.query;
                      _controller.setSearchTerm(term);
                      _controller.currentTabUIState.value =
                          ctrls.SearchTabUIStates.Results;
                    },
                  );
                },
              )
          ],
        );
      },
    );
  }

  Widget _sliverToChild(Widget child) {
    return SliverToBoxAdapter(
      child: child,
    );
  }
}

class _CategoriesCostumizationList extends StatelessWidget {
  _CategoriesCostumizationList({super.key, this.onChangeList});
  final Function()? onChangeList;
  final ProductsController _productsController = ProductsController.instance;
  final ctrls.SearchControllerV2 _controller =
      ctrls.SearchControllerV2.instance;

  @override
  Widget build(BuildContext context) {
    final List<String> selectedCategories =
        _controller.filterParameters.categoriesNames;
    print('test 15: list length: ${selectedCategories.length}');
    return FutureBuilder<List<Category>>(
      future: _productsController.categories(),
      initialData: _productsController.loadedCategories,
      builder: (context, snapshot) {
        if (snapshot.hasError)
          return const Center(
            child: Text('There was an error'),
          );
        final isWaiting = snapshot.connectionState == ConnectionState.waiting &&
            !snapshot.hasData;
        return SizedBox(
          height: 85,
          child: ListView.separated(
            itemCount: isWaiting ? 3 : snapshot.data!.length,
            padding: EdgeInsets.symmetric(horizontal: 25),
            scrollDirection: Axis.horizontal,
            separatorBuilder: (_, i) => SizedBox(
              width: 10,
            ),
            itemBuilder: (_, i) => isWaiting
                ? LoadingCategoryItem()
                : CategorieItem(
                    onCheck: (isChecked) {
                      if (isChecked) {
                        selectedCategories
                            .add(snapshot.data!.elementAt(i).name);
                      } else {
                        selectedCategories
                            .remove(snapshot.data!.elementAt(i).name);
                      }
                      _controller.setCategoriesFilter(selectedCategories);
                      if (onChangeList != null) onChangeList!();
                    },
                    checked: selectedCategories
                        .contains(snapshot.data!.elementAt(i).id),
                    data: snapshot.data!.elementAt(i),
                  ),
          ),
        );
      },
    );
  }
}

class _SuggestionItem extends StatelessWidget {
  const _SuggestionItem(
      {super.key,
      this.isFromHistory = false,
      required this.boldClip,
      required this.normalClip,
      required this.onClick});
  final bool isFromHistory;
  final String boldClip;
  final String normalClip;
  final Function() onClick;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 25),
      onTap: onClick,
      trailing: SvgPicture.asset(isFromHistory
          ? 'assets/icons/ic_fluent_arrow_counterclockwise_24_filled.svg'
          : 'assets/icons/search_small.svg'),
      title: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: boldClip,
              style: Get.textTheme.headlineSmall!
                  .copyWith(fontWeight: FontWeight.bold, color: ColorsConsts.a),
            ),
            TextSpan(
              text: normalClip,
              style: Get.textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.normal, color: ColorsConsts.c),
            ),
          ],
        ),
      ),
    );
  }
}
