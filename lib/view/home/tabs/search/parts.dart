  ///////////------------------------------------------------1st part
        // SliverToBoxAdapter(
        //   child: Padding(
        //     padding: EdgeInsets.only(
        //       right: 25,
        //       left: 25,
        //       top: 20,
        //     ),
        //     child: Row(
        //       crossAxisAlignment: CrossAxisAlignment.end,
        //       children: [
        //         Text(
        //           'HISTORY',
        //           style: Get.textTheme.headline4!.copyWith(height: 0.1),
        //         ),
        //         SizedBox(
        //           width: 5,
        //         ),
        //         Expanded(
        //           child: SizedBox(
        //             height: 1.5,
        //             child: DecoratedBox(
        //               decoration: BoxDecoration(
        //                 borderRadius: BorderRadius.circular(2.5),
        //                 color: CstColors.b.withOpacity(.5),
        //               ),
        //             ),
        //           ),
        //         )
        //       ],
        //     ),
        //   ),
        // ),
        // SliverPadding(padding: EdgeInsets.all(10)),
        // SliverList(
        //   delegate: SliverChildBuilderDelegate(
        //     (_, i) {
        //       return Padding(
        //         padding: const EdgeInsets.symmetric(
        //           vertical: 5,
        //           horizontal: 25,
        //         ),
        //         child: Row(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             Expanded(
        //               child: Column(
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 children: [
        //                   Text(
        //                     'White style',
        //                     style: Get.textTheme.headline2,
        //                   ),
        //                   Text(
        //                     'Yesterday',
        //                     style: Get.textTheme.headline5!.copyWith(
        //                       height: 1,
        //                     ),
        //                   )
        //                 ],
        //               ),
        //             ),
        //             SvgPicture.asset(
        //               'assets/icons/search.svg',
        //               height: 27,
        //             )
        //           ],
        //         ),
        //       );
        //     },
        //     childCount: 100,
        //   ),
        // ),

        ///////////------------------------------------------------2nd part
        // SliverToBoxAdapter(
        //   child: Padding(
        //     padding: EdgeInsets.only(
        //       right: 25,
        //       left: 25,
        //       top: 5,
        //     ),
        //     child: Row(
        //       // crossAxisAlignment: CrossAxisAlignment.end,
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       children: [
        //         Text(
        //           'SEARCH CATEGORY',
        //           style: Get.textTheme.headline4!.copyWith(color: CstColors.c),
        //         ),
        //         Text.rich(
        //           TextSpan(
        //             children: [
        //               TextSpan(
        //                 text: '1 category | ',
        //                 style: Get.textTheme.headline5!,
        //               ),
        //               TextSpan(
        //                 text: 'All',
        //                 style: Get.textTheme.headline5!
        //                     .copyWith(color: CstColors.g),
        //               )
        //             ],
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        // SliverToBoxAdapter(
        //   child: SizedBox(
        //     height: 103,
        //     child: ListView.separated(
        //       itemCount: 20,
        //       separatorBuilder: (_, i) {
        //         return SizedBox(
        //           width: 10,
        //         );
        //       },
        //       padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        //       scrollDirection: Axis.horizontal,
        //       itemBuilder: (_, i) {
        //         return CategorieItem(
        //           imagePath: 'assets/images/categories_qaftans.png',
        //           imageColor: CstColors.h,
        //           title: 'Gaftans',
        //         );
        //       },
        //     ),
        //   ),
        // ),
        // SliverPadding(
        //   padding: EdgeInsets.symmetric(
        //     horizontal: 25,
        //   ),
        //   sliver: SliverToBoxAdapter(
        //     child: Text(
        //       'SUGGESTIONS',
        //       style: Get.textTheme.headline4!.copyWith(color: CstColors.c),
        //     ),
        //   ),
        // ),
        // // SliverPadding(padding: EdgeInsets.all(10)),
        // SliverToBoxAdapter(
        //   child: SizedBox(
        //     height: 5,
        //   ),
        // ),
        // SliverList(
        //   delegate: SliverChildBuilderDelegate(
        //     (_, i) {
        //       return Padding(
        //         padding: const EdgeInsets.symmetric(
        //           vertical: 5,
        //           horizontal: 25,
        //         ),
        //         child: Row(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             Expanded(
        //               child: RichText(
        //                 text: TextSpan(
        //                   children: [
        //                     TextSpan(
        //                       text: 'Whit',
        //                       style: Get.textTheme.headline2,
        //                     ),
        //                     TextSpan(
        //                       text: 'e Abayas',
        //                       style: Get.textTheme.headline2!.copyWith(
        //                         color: CstColors.b,
        //                         fontWeight: FontWeight.w400,
        //                       ),
        //                     ),
        //                   ],
        //                 ),
        //               ),
        //             ),
        //             SvgPicture.asset(
        //               'assets/icons/search.svg',
        //               height: 27,
        //             )
        //           ],
        //         ),
        //       );
        //     },
        //     childCount: 100,
        //   ),
        // ),