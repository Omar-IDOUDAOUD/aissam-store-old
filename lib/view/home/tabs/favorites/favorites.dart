import 'package:aissam_store/controller/favoritres.dart';
import 'package:aissam_store/core/constants/colors.dart';
import 'package:aissam_store/view/home/tabs/favorites/widgets/favorite_card.dart';
import 'package:aissam_store/view/home/tabs/favorites/widgets/loading_favorite_card.dart';
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
  late ValueNotifier<double?> _scrollHeaderNotifier; //
  static const double _fixHeaderExtent = 70;
  final FavoritesController _favoritesController = FavoritesController.instance;

//3IJcVXxTtYixGG6ABoKw
//3PbcwdXLqDUvrjyw2o5e
//4ZvfZlE3sr9VKpSf2suq

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    _scrollController = ScrollController(initialScrollOffset: 0)
      ..addListener(() {
        if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent) {
          _favoritesController.loadFavsPagination();
        }
        if (_scrollController.offset <= _fixHeaderExtent &&
            _scrollController.offset >= 0) {
          _scrollHeaderNotifier.value = _scrollController.offset;
        } else if (_scrollHeaderNotifier.value != null) {
          _scrollHeaderNotifier.value = null;
        }
      });
    _favoritesController.loadFavsPagination();
    _scrollHeaderNotifier = ValueNotifier(0);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FavoritesController>(
      id: _favoritesController.paginationDataResult.widgetToUpdateTag,
      init: _favoritesController,
      builder: (c) {
        return CustomScrollView(
          physics: BouncingScrollPhysics(),
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
                  prefixIconPath: 'assets/icons/search_small.svg',
                  onClear: () {},
                  // onCommit: () {},
                  focusNode: FocusNode(),
                ),
              ),
            ),
            if (!c.paginationDataResult.isLoading &&
                c.paginationDataResult.loadedData.isEmpty)
              SliverToBoxAdapter(child: Text('No Data'))
            else
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                sliver: SliverList.separated(
                  itemCount: c.paginationDataResult.loadedData.length +
                      (c.paginationDataResult.isLoading ? 3 : 0),
                  separatorBuilder: (_, i) => SizedBox(
                    height: 15,
                  ),
                  itemBuilder: (_, i) {
                    if (i >= c.paginationDataResult.loadedData.length)
                      return const LoadingFavoriteCard();
                    return Builder(
                      builder: (context) {
                        final itemData =
                            c.paginationDataResult.loadedData.elementAt(i);
                        return FavoriteCard(
                          data: itemData,
                          onFavoriteChange: (b) async {
                            if (b)
                              await _favoritesController
                                  .addFavoritedProduct(itemData.id!);
                            else
                              await _favoritesController
                                  .removeFavoritedProduct(itemData.id!);
                          },
                        );
                      },
                    );
                  },
                ),
              ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    _scrollHeaderNotifier.dispose();
    super.dispose();
  }
}
