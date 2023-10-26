// // ignore_for_file: curly_braces_in_flow_control_structures

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

class SuggestionsPart extends StatelessWidget {
  const SuggestionsPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Suggestions',
          style: Get.textTheme.bodyMedium!.copyWith(
            color: CstColors.b,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 200,
            itemBuilder: (_, i) {
              return Text(
                'Suggestion Item',
                style: TextStyle(fontSize: 25),
              );
            },
          ),
        ),
      ],
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
