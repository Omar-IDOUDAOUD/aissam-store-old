import 'package:aissam_store/core/constants/colors.dart';
import 'package:aissam_store/view/public/text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class _SearchBarHeaderPersistent extends SliverPersistentHeaderDelegate {
  _SearchBarHeaderPersistent(
      {required this.focusNode,
      // this.isFloating = false,
      this.onTap,
      required this.isFloatingNotifier});

  // final ScrollController scrollController;
  final FocusNode focusNode;
  // final bool isFloating;
  final Function()? onTap;
  final ValueNotifier<bool> isFloatingNotifier;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // TODO: implement build
    // print(
    //     "$shrinkOffset, value: ${shrinkOffset <= _fixExtent / 2 && shrinkOffset >= 0}");
    return Padding(
      padding: EdgeInsets.only(top: 20, right: 25, left: 25),
      child: GestureDetector(
        onTap: onTap,
        child: ValueListenableBuilder<bool>(
          valueListenable: isFloatingNotifier,
          builder: (context, v, c) {
            return CustomTextField(
              onTap: onTap,
              focusNode: focusNode,
              enabled: !v,
              isFloating: v,
            );
          },
        ),
      ),
    );
  }

  static const double _fixExtent = 78;

  @override
  // TODO: implement maxExtent
  double get maxExtent => _fixExtent;

  @override
  // TODO: implement minExtent
  double get minExtent => _fixExtent;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return false;
  }
}

class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  late final ScrollController _scrollController;
  late final FocusNode _searchFocusNode;
  final ValueNotifier<bool> _isSearchBarFloatingNotifier = ValueNotifier(false);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        print('listenner--------------------------------ééééé');
        if (_getScrollOffset <= _getTitleHeaderHeight() + 20)
          _isSearchBarFloatingNotifier.value = false;
        else
          _isSearchBarFloatingNotifier.value = true;
      });
    _searchFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  double? _titleHeaderHeight;

  double _getTitleHeaderHeight() {
    if (_titleHeaderHeight != null) return _titleHeaderHeight!;
    final RenderBox renderBox =
        _titleHeaderKey.currentContext?.findRenderObject() as RenderBox;

    final Size size = renderBox.size;
    print('title height: $size');
    _titleHeaderHeight = size.height + 20;
    return _titleHeaderHeight!;
  }

  void _onRequestBarSearch() {
    print("/////////////////////////");
    _scrollController
        .animateTo(_getTitleHeaderHeight(),
            duration: 600.milliseconds, curve: Curves.linearToEaseOut)
        .then((value) {
      _isSearchBarFloatingNotifier.value = false;
      _searchFocusNode.requestFocus();
    });
  }

  double get _getScrollOffset =>
      _scrollController.hasClients ? _scrollController.offset : 0;

  final _titleHeaderKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
   
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverPadding(
          // key: _titleHeaderKey,
          padding: EdgeInsets.only(top: 20, right: 25, left: 25),
          sliver: SliverToBoxAdapter(
            child: Column(
              key: _titleHeaderKey,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Search',
                  style: Get.textTheme.headlineLarge!.copyWith(
                    fontWeight: FontWeight.w600,
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
              ],
            ),
          ),
        ),

        SliverPersistentHeader(
          pinned: true,
          floating: true,
          delegate: _SearchBarHeaderPersistent(
            isFloatingNotifier: _isSearchBarFloatingNotifier,
            focusNode: _searchFocusNode,
            // isFloating: ,
            onTap: _onRequestBarSearch,
          ),
        ),
        // SliverToBoxAdapter(
        // ),

        SliverPadding(
          padding: EdgeInsets.only(top: 20),
          sliver: SliverList.builder(
            itemCount: Colors.accents.length,
            itemBuilder: (_, i) {
              return SizedBox(
                height: 100,
                child: ColoredBox(
                  color: Colors.accents.elementAt(i),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
