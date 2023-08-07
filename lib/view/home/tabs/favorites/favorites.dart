import 'package:aissam_store/core/constants/colors.dart';
import 'package:aissam_store/view/home/tabs/favorites/widgets/favorite_card.dart';
import 'package:aissam_store/view/home/tabs/widgets/header_scroll_up_blur.dart';
import 'package:aissam_store/view/public/text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class _HeaderDelegate extends SliverPersistentHeaderDelegate {
  const _HeaderDelegate(
      {required this.scrollController,
      required this.notifier,
      this.fixedExtent = 70});
  final ScrollController scrollController;
  final ValueNotifier<double?> notifier;
  final double fixedExtent;

  double get _getScrollOffset =>
      scrollController.hasClients ? scrollController.offset : 0;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return ValueListenableBuilder<double?>(
      valueListenable: notifier,
      builder: (context, v, c) {
        return HeaderWithScrollUpBlur(
          padding: EdgeInsets.symmetric(horizontal: 25),
          elevation: ((v ?? fixedExtent - shrinkOffset) / fixedExtent),
          child: Row(
            children: [
              Text(
                'Favorites',
                style: Get.textTheme.headlineLarge!
                    .copyWith(fontWeight: FontWeight.w500),
              ),
              const Spacer(),
              Text(
                '+15',
                style: Get.textTheme.headlineSmall!
                    .copyWith(color: CstColors.b, fontWeight: FontWeight.w400),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => fixedExtent;

  @override
  // TODO: implement minExtent
  double get minExtent => fixedExtent;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return true;
  }
}

class FavoritesTab extends StatefulWidget {
  FavoritesTab({Key? key}) : super(key: key);

  @override
  State<FavoritesTab> createState() => _FavoritesTabState();
}

class _FavoritesTabState extends State<FavoritesTab> {
  late final ScrollController _scrollController;
  ValueNotifier<double?> _scrollHeaderNotifier = ValueNotifier(0); //
  static const double _fixHeaderExtent = 70;

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    _scrollController = ScrollController(initialScrollOffset: 0)
      ..addListener(() {
        if (_scrollController.offset <= _fixHeaderExtent &&
            _scrollController.offset >= 0) {
          _scrollHeaderNotifier.value = _scrollController.offset;
        } else if (_scrollHeaderNotifier.value != null) {
          _scrollHeaderNotifier.value = null;
        }
      });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('FAVORITE BUILD');
    return CustomScrollView(
      // padding: ,
      controller: _scrollController,
      slivers: [
        SliverPersistentHeader(
          floating: true,
          pinned: false,
          delegate: _HeaderDelegate(
            scrollController: _scrollController,
            notifier: _scrollHeaderNotifier,
            fixedExtent: _fixHeaderExtent,
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          sliver: SliverToBoxAdapter(
            child: CustomTextField(
              onClear: () {},
              onCommit: (){},
              focusNode: FocusNode(),
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          sliver: SliverList.separated(
            itemCount: 20,
            separatorBuilder: (_, i) => SizedBox(
              height: 15,
            ),
            itemBuilder: (_, i) => FavoriteCard(),
          ),
        ),
      ],
    );
  }

  Widget _listedItems(
      Widget Function(BuildContext _, int i) b, double listHeight, int count) {
    return SizedBox(
      height: listHeight,
      child: ListView.separated(
        itemCount: count,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemBuilder: b,
        separatorBuilder: (_, i) => const SizedBox(
          width: 10,
        ),
      ),
    );
  }
}
