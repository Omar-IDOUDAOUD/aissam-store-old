import 'package:aissam_store/controller/user.dart';
import 'package:aissam_store/controller/user_cart.dart';
import 'package:aissam_store/core/constants/colors.dart';
import 'package:aissam_store/view/home/tabs/favorites/widgets/loading_favorite_card.dart';
import 'package:aissam_store/view/home/tabs/my_cart/widgets/cart_item.dart';
import 'package:aissam_store/view/home/tabs/my_cart/widgets/checkout_fab.dart';
import 'package:aissam_store/view/home/tabs/widgets/header_scroll_up_blur.dart';
import 'package:aissam_store/view/public/text_field.dart';
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
          padding: const EdgeInsets.symmetric(horizontal: 25),
          elevation: ((v ?? fixedExtent - shrinkOffset) / fixedExtent),
          child: Row(
            children: [
              Text(
                'My Cart',
                style: Get.textTheme.headlineLarge!
                    .copyWith(fontWeight: FontWeight.w500),
              ),
              const Spacer(),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.greenAccent[700]!.withOpacity(.5),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  child: Text(
                    '3 Products',
                    style: Get.textTheme.bodyMedium!.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
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

class MyCartTab extends StatefulWidget {
  MyCartTab({Key? key}) : super(key: key);

  @override
  State<MyCartTab> createState() => _MyCartTabState();
}

class _MyCartTabState extends State<MyCartTab> {
  late final ScrollController _scrollController;
  late ValueNotifier<double?> _scrollHeaderNotifier; //
  static const double _fixHeaderExtent = 70;

  final UserCartController _userCartController = UserCartController.instance;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController(initialScrollOffset: 0)
      ..addListener(() {
        if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent) {
          _userCartController.loadData();
        }
        if (_expandCheckoutButton) _collapseCheckoutBottomSheet();
        if (_scrollController.offset <= _fixHeaderExtent &&
            _scrollController.offset >= 0) {
          _scrollHeaderNotifier.value = _scrollController.offset;
        } else if (_scrollHeaderNotifier.value != null) {
          _scrollHeaderNotifier.value = null;
        }
      });
    _userCartController.loadData();
    _scrollHeaderNotifier = ValueNotifier(0);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    _scrollHeaderNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GetBuilder<UserCartController>(
          init: _userCartController,
          id: _userCartController.cartItemsPaginationData.widgetToUpdateTag,
          builder: (c) {
            return CustomScrollView(
              physics: const BouncingScrollPhysics(),
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
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  sliver: SliverToBoxAdapter(
                    child: CustomTextField(
                      prefixIconPath: 'assets/icons/search_small.svg',
                      onClear: () {},
                      focusNode: FocusNode(),
                    ),
                  ),
                ),
                if (!c.cartItemsPaginationData.isLoading &&
                    c.cartItemsPaginationData.loadedData.isEmpty)
                  SliverToBoxAdapter(child: Text('No Data'))
                else
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 20),
                    sliver: SliverList.builder(
                      itemCount: c.cartItemsPaginationData.loadedData.length +
                          (c.cartItemsPaginationData.isLoading ? 3 : 0),
                      itemBuilder: (_, i) {
                        if (i >= c.cartItemsPaginationData.loadedData.length)
                          return LoadingFavoriteCard();
                        return CartItem(
                          listIndex: i,
                          data:
                              c.cartItemsPaginationData.loadedData.elementAt(i),
                        );
                      },
                    ),
                  ),
              ],
            );
          },
        ),
        AnimatedPositioned(
          bottom: _expandCheckoutButton ? 0 : -230,
          height: 230,
          width: Get.size.width,
          duration: _anDur,
          curve: _anCurve,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(35)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, -5),
                  color: Colors.black.withOpacity(.2),
                  blurRadius: 50,
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 105,
                ),
                Text(
                  'View Checkout History',
                  textAlign: TextAlign.center,
                  style: Get.textTheme.bodyLarge!.copyWith(
                    color: CstColors.b,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
        AnimatedPositioned(
          duration: _anDur,
          curve: _anCurve,
          bottom: _expandCheckoutButton ? 140 : 100,
          height: _expandCheckoutButton ? 60 : 50,
          right: 25,
          width: _expandCheckoutButton ? Get.size.width - (25 * 2) : 50,
          child: CheckoutFAB(
            isExpand: _expandCheckoutButton,
            onExpand: _expandCheckoutBottomSheet,
          ),
        ),
      ],
    );
  }

  _expandCheckoutBottomSheet() {
    _scrollController.animateTo(_scrollController.offset,
        curve: Curves.linear, duration: Duration.zero);
    setState(() {
      _expandCheckoutButton = true;
    });
  }

  _collapseCheckoutBottomSheet() {
    setState(() {
      _expandCheckoutButton = false;
    });
  }

  final _anDur = 500.milliseconds;
  final _anCurve = Curves.linearToEaseOut;

  bool _expandCheckoutButton = false;
}
