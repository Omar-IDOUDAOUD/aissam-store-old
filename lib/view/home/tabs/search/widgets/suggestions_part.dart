// // ignore_for_file: curly_braces_in_flow_control_structures

// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:math';

import 'package:aissam_store/controller/product.dart';
import 'package:aissam_store/core/constants/colors.dart';
import 'package:aissam_store/models/category.dart';
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
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.searchFieldController.removeListener(_searchFieldListener);
    super.dispose();
  }

  void _searchFieldListener() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement
    return FutureBuilder<List<ctrls.SearchTerm>>(
        future: _controller.searchFieldController.text.isNotEmpty
            ? _controller.suggestions()
            : null,
        builder: (context, snapshot) {
          final isWaiting = snapshot.connectionState == ConnectionState.waiting;
          final noData = !snapshot.hasData;
          final hasError = snapshot.hasError;
          final noSuggestions = !noData && snapshot.data!.isEmpty;
          return CustomScrollView(
            slivers: [
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                sliver: _sliverToChild(
                  Row(
                    children: [
                      Text(
                        'SEARCH COLLECTION',
                        style: Get.textTheme.bodyLarge!.copyWith(
                          color: CstColors.a,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Spacer(),
                      Text(
                        '1 category | ',
                        style: Get.textTheme.bodyMedium!.copyWith(
                          color: CstColors.b,
                          height: 0.4,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        'All',
                        style: Get.textTheme.bodyMedium!.copyWith(
                          color: CstColors.g,
                          height: 0.4,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              _sliverToChild(
                _CategoriesCostumizationList(),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                sliver: SliverToBoxAdapter(
                  child: Text(
                    'SUGGESTIONS',
                    style: Get.textTheme.bodyLarge!.copyWith(
                      color: CstColors.a,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              if (noData)
                _sliverToChild(Text('SearchForSomethong'))
              else if (isWaiting)
                _sliverToChild(CircularProgressIndicator())
              else if (noSuggestions)
                _sliverToChild(Text('No Suggestions'))
              else if (hasError)
                _sliverToChild(Text('An Error occurred'))
              else
                SliverList.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (_, i) {
                    return Text(snapshot.data!.elementAt(i).query);
                  },
                )
            ],
          );
        });
  }

  Widget _sliverToChild(Widget child) {
    return SliverToBoxAdapter(
      child: child,
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return FutureBuilder<List<ctrls.SearchTerm>>(
  //     future: _controller.searchFieldController.text.isNotEmpty
  //         ? _controller.suggestions()
  //         : null,
  //     builder: (context, snapshot) {
  //       return ListView.builder(
  //         itemCount:
  //             3 + (snapshot.hasData ? max(snapshot.data!.length - 1, 0) : 0),
  //         itemBuilder: (_, i) {
  //           if (i == 0)
  //             return Padding(
  //               padding: EdgeInsets.symmetric(horizontal: 25),
  //               child: Row(
  //                 children: [
  //                   Text(
  //                     'SEARCH COLLECTION',
  //                     style: Get.textTheme.bodyLarge!.copyWith(
  //                       color: CstColors.a,
  //                       fontWeight: FontWeight.w400,
  //                     ),
  //                   ),
  //                   Spacer(),
  //                   Text(
  //                     '1 category | ',
  //                     style: Get.textTheme.bodyMedium!.copyWith(
  //                       color: CstColors.b,
  //                       height: 0.4,
  //                       fontWeight: FontWeight.w400,
  //                     ),
  //                   ),
  //                   Text(
  //                     'All',
  //                     style: Get.textTheme.bodyMedium!.copyWith(
  //                       color: CstColors.g,
  //                       height: 0.4,
  //                       fontWeight: FontWeight.w400,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             );
  //           if (i == 1) return _CategoriesCostumizationList();
  //           if (i == 2)
  //             return Padding(
  //               padding: EdgeInsets.symmetric(horizontal: 25),
  //               child: Text(
  //                 'SUGGESTIONS',
  //                 style: Get.textTheme.bodyLarge!.copyWith(
  //                   color: CstColors.a,
  //                   fontWeight: FontWeight.w400,
  //                 ),
  //               ),
  //             );
  //          i -= 2;
  //           // i = 0
  //           if (snapshot.connectionState == ConnectionState.waiting)
  //             return const Text('Loading');
  //           if (snapshot.hasError) return Text('Error Occurred');
  //           if (!snapshot.hasData) return Text('Search For Sometrhing');
  //           if (snapshot.hasData && snapshot.data!.isEmpty)
  //             return Text('No Suggestions');
  //           return Padding(
  //             padding: EdgeInsets.symmetric(horizontal: 25),
  //             child: Text(
  //               snapshot.data!.elementAt(i).query,
  //               style: TextStyle(fontSize: 25),
  //             ),
  //           );
  //         },
  //       );
  //     },
  //   );
  // }
}

class _CategoriesCostumizationList extends StatelessWidget {
  _CategoriesCostumizationList({super.key});
  final ProductsController _productsController = ProductsController.instance;

  @override
  Widget build(BuildContext context) {
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
                    data: snapshot.data!.elementAt(i),
                  ),
          ),
        );
      },
    );
  }
}

// class SearchingPart extends StatefulWidget {
//   SearchingPart({super.key, required this.onSuggestionClick});

//   final Function(ctrls.SearchTerm term) onSuggestionClick;

//   @override
//   State<SearchingPart> createState() => _SearchingPartState();
// }

// class _SearchingPartState extends State<SearchingPart> {
//   final ctrls.SearchController _controller = ctrls.SearchController.instance;
//   final ProductsController _productsController = ProductsController.instance;

//   @override
//   void initState() {
//     // TODO: implement initState

//     super.initState();
//     print('INIT STATE SEARCHING PART');
//     _controller.searchTextEditingController.addListener(() {
//       if (!_checkSearchEmptiness && mounted) {
//         print('trying get data');
//         setState(() {});
//       }
//     });
//   }

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     print('DISPOSE SEARCHING PART');
//     super.dispose();
//   }

//   bool get _checkSearchEmptiness =>
//       _controller.searchTextEditingController.text.isEmpty;
//   // bool _canSendRequest = false;

//   @override
//   Widget build(BuildContext context) {
//     // print('rebuild widget, v=$_canSendRequest');
//     return FutureBuilder<List<ctrls.SearchTerm>>(
//       initialData: _controller.lastSearchSuggestions,
//       future: _controller
//           .searchSuggestions(_controller.searchTextEditingController.text),
//       builder: (context, sn) {
//         if (sn.hasError) return Text('An error occurred');
//         if (sn.hasData) {
//           return CustomScrollView(
//             physics: const BouncingScrollPhysics(),
//             slivers: [
//               SliverPadding(
//                 padding:
//                     EdgeInsets.only(right: 25, left: 25, top: 25, bottom: 15),
//                 sliver: SliverToBoxAdapter(
//                   child: Row(
//                     children: [
//                       Text(
//                         'SEARCH COLLECTION',
//                         style: Get.textTheme.bodyLarge!.copyWith(
//                           color: CstColors.a,
//                           height: 0.4,
//                           fontWeight: FontWeight.w400,
//                         ),
//                       ),
//                       Spacer(),
//                       Text(
//                         '1 category | ',
//                         style: Get.textTheme.bodyMedium!.copyWith(
//                           color: CstColors.b,
//                           height: 0.4,
//                           fontWeight: FontWeight.w400,
//                         ),
//                       ),
//                       Text(
//                         'All',
//                         style: Get.textTheme.bodyMedium!.copyWith(
//                           color: CstColors.g,
//                           height: 0.4,
//                           fontWeight: FontWeight.w400,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SliverToBoxAdapter(
//                 child: SizedBox(
//                   height: 85,
//                   child: FutureBuilder<List<Category>>(
//                       initialData: _productsController.loadedCategories,
//                       future: _productsController.categories(),
//                       builder: (context, snapshot) {
//                         if (snapshot.hasError)
//                           return Center(
//                             child: Text('There was an error'),
//                           );
//                         final isWaiting = snapshot.connectionState ==
//                                 ConnectionState.waiting &&
//                             !snapshot.hasData;
//                         return ListView.separated(
//                           itemCount: isWaiting ? 3 : snapshot.data!.length,
//                           padding: EdgeInsets.symmetric(horizontal: 25),
//                           scrollDirection: Axis.horizontal,
//                           separatorBuilder: (_, i) => SizedBox(
//                             width: 10,
//                           ),
//                           itemBuilder: (_, i) => LoadingCategoryItem(),
//                           // isWaiting
//                           //     ? LoadingCategoryItem()
//                           //     : CategorieItem(
//                           //         data: snapshot.data!.elementAt(i),
//                           //       ),
//                         );
//                       }),
//                 ),
//               ),
//               SliverPadding(
//                 padding:
//                     EdgeInsets.only(right: 25, left: 25, top: 25, bottom: 15),
//                 sliver: SliverToBoxAdapter(
//                   child: SizedBox(
//                     height: 20,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'SUGGESTIONS',
//                           style: Get.textTheme.bodyLarge!.copyWith(
//                             color: CstColors.a,
//                             // height: 0.4,
//                             fontWeight: FontWeight.w400,
//                           ),
//                         ),
//                         if (sn.connectionState == ConnectionState.waiting)
//                           SizedBox.square(
//                             dimension: 20,
//                             child: CircularProgressIndicator(
//                               color: Colors.grey,
//                               strokeWidth: 1.5,
//                             ),
//                           )
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               if (sn.connectionState == ConnectionState.waiting && !sn.hasData)
//                 Center(child: CircularProgressIndicator())
//               else
//                 SliverList.separated(
//                   itemCount: sn.data!.isNotEmpty ? sn.data!.length : 1,
//                   separatorBuilder: (_, i) => SizedBox(height: 15),
//                   itemBuilder: (_, i) => Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 25),
//                     child: Builder(builder: (context) {
//                       final userInput =
//                           _controller.searchTextEditingController.text;
//                       final suggestion = sn.data!.isNotEmpty
//                           ? sn.data!.elementAt(i).term
//                           : userInput;
//                       var boldClip;
//                       var lightClip;
//                       if (_controller.searchTextEditingController.text.length <=
//                           suggestion.length) {
//                         boldClip = _controller.searchTextEditingController.text;
//                         lightClip = suggestion.substring(_controller
//                             .searchTextEditingController.text.length);
//                         for (var i2 = 0;
//                             i2 <
//                                 _controller
//                                     .searchTextEditingController.text.length;
//                             i2++) {
//                           if (userInput[i2].toLowerCase() ==
//                               suggestion[i2].toLowerCase()) continue;
//                           boldClip = '';
//                           lightClip = suggestion;
//                         }
//                       } else {
//                         lightClip = suggestion;
//                       }
//                       return InkWell(
//                         onTap: () => widget.onSuggestionClick(sn.data!.isEmpty
//                             ? ctrls.SearchTerm(term: suggestion)
//                             : sn.data!.elementAt(i)),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text.rich(
//                               TextSpan(
//                                 children: [
//                                   TextSpan(
//                                     text: boldClip,
//                                     style:
//                                         Get.textTheme.headlineMedium!.copyWith(
//                                       color: CstColors.a,
//                                       height: 1.2,
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                                   ),
//                                   TextSpan(
//                                     text: lightClip,
//                                     style:
//                                         Get.textTheme.headlineMedium!.copyWith(
//                                       color: CstColors.c,
//                                       height: 1.2,
//                                       fontWeight: FontWeight.w400,
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                             // Text(
//                             //   sn.data!.elementAt(i),
//                             //   style: Get.textTheme.headlineMedium!.copyWith(
//                             //     color: CstColors.c,
//                             //     height: 1.2,
//                             //     fontWeight: FontWeight.w400,
//                             //   ),
//                             // ),
//                             SvgPicture.asset('assets/icons/search_small.svg')
//                           ],
//                         ),
//                       );
//                     }),
//                   ),
//                 ),
//             ],
//           );
//         }

//         if (sn.connectionState == ConnectionState.waiting && !sn.hasData)
//           return Center(
//               child: CircularProgressIndicator(
//             color: Colors.grey,
//             strokeWidth: 1.5,
//           ));
//         return Center(child: Text('Something went wrong'));
//       },
//     );
//   }
// }
