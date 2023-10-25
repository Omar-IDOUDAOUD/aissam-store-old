import 'package:aissam_store/controller/search.dart';
import 'package:aissam_store/core/constants/colors.dart';
import 'package:aissam_store/view/public/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// class SearchBarHeaderPersistent extends SliverPersistentHeaderDelegate {
//   SearchControllerV2 _controller = SearchControllerV2.instance;
//   FocusNode _focusNode = FocusNode();

//   // void _requestFocus() {
//   //   _controller.currentTabUIState.value = SearchTabUIStates.Searching;
//   //   400
//   //       .milliseconds
//   //       .delay()
//   //       .then((value) => _focusNode.requestFocus()); //300.mili
//   // }

//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     final isFloating = shrinkOffset >= 30;
//     // final enabled = shrinkOffset == 0;
//     return Padding(
//         padding: EdgeInsets.only(top: 20, right: 25, left: 25),
//         child: AnimatedPhysicalModel(
//           duration: 300.milliseconds,
//           color: Colors.transparent,
//           elevation: isFloating ? 20 : 0,
//           shadowColor: Colors.black,
//           shape: BoxShape.rectangle,
//           borderRadius: BorderRadius.circular(12),
//           child: CustomTextField(
//             // onTap: () {
//             //   // print('Onatp integrated');
//             //   _focusNode.requestFocus();
//             // },
//             borderRadius: 12,
//             focusNode: _focusNode,
//             // enabled: isEnabled,
//             controller: _controller.searchFieldController,
//             onClear: () {
//               print('Clear Function');
//               _controller.currentTabUIState.value = SearchTabUIStates.History;
//               _controller.setSearchTerm = null;
//             },
//             onCommit: () {
//               print('Commit Function');
//               _controller.currentTabUIState.value = SearchTabUIStates.Results;
//               _controller.setSearchTerm =
//                   _controller.searchFieldController.text;
//             },
//           ),
//         ));
//   }

//   // Widget _getTextField(bool isFloating, bool isEnabled) =>

//   static const double _fixExtent = 78;

//   @override
//   // TODO: implement maxExtent
//   double get maxExtent => _fixExtent;

//   @override
//   // TODO: implement minExtent
//   double get minExtent => _fixExtent;

//   @override
//   bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
//     // TODO: implement shouldRebuild
//     return false;
//   }
// }

class SearchBarV2 extends StatefulWidget {
  const SearchBarV2({super.key});

  @override
  State<SearchBarV2> createState() => _SearchBarV2State();
}

class _SearchBarV2State extends State<SearchBarV2> {
  SearchControllerV2 _controller = SearchControllerV2.instance;
  late final FocusNode _focusNode;

  @override
  void dispose() {
    // TODO: implement dispose
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_focusNodeListener);
  }

  _focusNodeListener() {
    if (_focusNode.hasFocus && !_showFilterIcon)
      setState(() {
        _showFilterIcon = true;
      });
    else if (!_focusNode.hasFocus && _showFilterIcon)
      setState(() {
        _showFilterIcon = false;
      });
  }

  bool _showFilterIcon = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20, right: 25, left: 25),
      child: Row(
        children: [
          Expanded(
            child: CustomTextField(
              // onTap: () {
              //   // print('Onatp integrated');
              //   _focusNode.requestFocus();
              // },
              prefixIconPath: 'assets/icons/search.svg',
              borderRadius: 12,
              focusNode: _focusNode,
              // enabled: isEnabled,
              controller: _controller.searchFieldController,
              onClear: () {
                print('Clear Function');
                _controller.currentTabUIState.value = SearchTabUIStates.History;
                _controller.setSearchTerm = null;
              },
              onCommit: () {
                print('Commit Function');
                _controller.currentTabUIState.value = SearchTabUIStates.Results;
                _controller.setSearchTerm =
                    _controller.searchFieldController.text;
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
      ),
    );
  }
}
