import 'package:aissam_store/controller/search.dart';
import 'package:aissam_store/core/constants/colors.dart';
import 'package:aissam_store/view/public/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SearchBarHeaderPersistent extends SliverPersistentHeaderDelegate {
  SearchControllerV2 _controller = SearchControllerV2.instance;
  FocusNode _focusNode = FocusNode();

  // void _requestFocus() {
  //   _controller.currentTabUIState.value = SearchTabUIStates.Searching;
  //   400
  //       .milliseconds
  //       .delay()
  //       .then((value) => _focusNode.requestFocus()); //300.mili
  // }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final isFloating = shrinkOffset != 0;
    return Padding(
      padding: EdgeInsets.only(top: 20, right: 25, left: 25),
      child: AnimatedSwitcher(
        duration: 200.milliseconds,
        child: isFloating
            ? GestureDetector(
                key: Key('childkey1'),
                onTap: () async {
                  if (_controller.currentTabUIState.value ==
                      SearchTabUIStates.Searching)
                    _controller.currentTabUIState.notifyListeners();
                  else
                    _controller.currentTabUIState.value =
                        SearchTabUIStates.Searching;
                  await 350.milliseconds.delay();
                  _controller.searchFieldfocusNode.requestFocus();
                },
                child: _getFakeSearchBar(Key('childkey2')),
              )
            : SearchBarV2(),
        transitionBuilder: (c, a) {
          return FadeTransition(
            opacity: a,
            child: c,
          );
        },
      ),
    );
  }

  Widget _getFakeSearchBar(Key key) {
    return DecoratedBox(
      key: key,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/icons/search.svg',
                height: 25,
                width: 25,
                fit: BoxFit.scaleDown,
                alignment: Alignment.center,
                color: CstColors.b,
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: Text(
                  _controller.searchFieldController.text,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: Get.textTheme.headlineSmall!.copyWith(
                    color: CstColors.a,
                    fontWeight: FontWeight.w400,
                    height: 1.2,
                  ),
                ),
              ),
              if (_controller.searchFieldController.text.isNotEmpty) ...[
                SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () {
                    _controller.searchFieldController.clear();
                  },
                  child: SvgPicture.asset(
                    'assets/icons/close_no_padding.svg',
                    height: 13,
                    fit: BoxFit.scaleDown,
                    allowDrawingOutsideViewBox: true,
                    alignment: Alignment.center,
                    color: CstColors.c,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }

  // Widget _getTextField(bool isFloating, bool isEnabled) =>

  static const double _fixExtent = 73;

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

class SearchBarV2 extends StatefulWidget {
  const SearchBarV2({super.key});

  @override
  State<SearchBarV2> createState() => _SearchBarV2State();
}

class _SearchBarV2State extends State<SearchBarV2> {
  SearchControllerV2 _controller = SearchControllerV2.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.searchFieldfocusNode.addListener(_focusNodeListener);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.searchFieldfocusNode.removeListener(_focusNodeListener);
    super.dispose();
  }

  _focusNodeListener() {
    if (_controller.searchFieldfocusNode.hasFocus && !_showFilterIcon)
      setState(() {
        _showFilterIcon = true;
      });
    else if (!_controller.searchFieldfocusNode.hasFocus && _showFilterIcon)
      setState(() {
        _showFilterIcon = false;
      });
  }

  bool _showFilterIcon = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomTextField(
            // onTap: () {
            //   // print('Onatp integrated');
            //   _focusNode.requestFocus();
            // },
            prefixIconPath: 'assets/icons/search.svg',
            borderRadius: 12,
            focusNode: _controller.searchFieldfocusNode,
            // enabled: isEnabled,
            controller: _controller.searchFieldController,
            onClear: () {
              print('Clear Function');
              _controller.currentTabUIState.value = SearchTabUIStates.History;
            },
            onCommit: () {
              print('Commit Function');
              _controller.setSearchTerm;
              _controller.currentTabUIState.value = SearchTabUIStates.Results;
              // _controller.setSearchTerm =
              //     _controller.searchFieldController.text;
            },
          ),
        ),
        AnimatedSize(
          duration: 100.milliseconds,
          child: AnimatedSwitcher(
            duration: 100.milliseconds,
            child: _showFilterIcon
                ? GestureDetector(
                    onTap: () {},
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3),
                      child: Icon(
                        Icons.filter_list_rounded,
                        color: CstColors.a,
                        size: 25,
                      ),
                    ),
                  )
                : SizedBox.shrink(),
            transitionBuilder: (Widget c, Animation<double> a) {
              return ScaleTransition(
                scale: Tween(begin: 0.8, end: 1.0).animate(a),
                child: FadeTransition(
                  opacity: a,
                  child: c,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
