import 'package:aissam_store/controller/connectivity.dart';
import 'package:aissam_store/core/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';

class ConnectionStatueWarningBar extends StatefulWidget {
  ConnectionStatueWarningBar({
    super.key,
    // this.isFromSnackBar = false,
  });

  // Stream<bool> connectivityStream;
  // final Function()? onDispose;

  // final bool isFromSnackBar;

  // static void snackBar() {
  //   final Overlay overlay;
  //   Get.bottomSheet(
  //     SizedBox(
  //       height: 30,
  //       child: ConnectionStatueWarningBar(isFromSnackBar: true),
  //     ),
  //     isScrollControlled: true,
  //     backgroundColor: Colors.yellow,
  //     isDismissible: false,
  //   );
  // }

  @override
  State<ConnectionStatueWarningBar> createState() =>
      _ConnectionStatueWarningBarState(
          // onHideBar: isFromSnackBar ? Get.back : null,
          );
}

class _ConnectionStatueWarningBarState extends State<ConnectionStatueWarningBar>
    with SingleTickerProviderStateMixin {
  // final Function()? onHideBar;
  // _ConnectionStatueWarningBarState({this.onHideBar});
  late final AnimationController _behaviorAnCtrl;
  late final Animation<double> _behaviorAn;
  bool? _isOffline;

  final ConnectivityController _connectivityController =
      ConnectivityController.instance;

  @override
  void initState() {
    // TODO: implement initState
    print('initstate');
    super.initState();
    _behaviorAnCtrl =
        AnimationController(vsync: this, duration: _childChangingAnDur)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed)
              setState(() {
                _isOffline = true;
              });
          });

    _behaviorAn = Tween<double>(begin: 0, end: 30).animate(CurvedAnimation(
        parent: _behaviorAnCtrl, curve: Curves.linearToEaseOut));

    _connectivityController.connectivityStream.stream.listen((event) {
      if (!event)
        _show();
      else
        _hide();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // if (widget.onDispose != null) widget.onDispose!();
    _behaviorAnCtrl.dispose();
    super.dispose();
  }

  // @override
  // void didUpdateWidget(covariant ConnectionStatueWarningBar oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   if (!widget.connectivityStream) {
  //     _behaviorAnCtrl.forward();
  //   } else {

  //   }
  //   print('dud upadte widget');
  // }

  void _show() {
    _behaviorAnCtrl.forward();
  }

  void _hide() {
    setState(() {
      _isOffline = false;
    });
    1.seconds.delay().then((value) {
      setState(() {
        _isOffline = null;
      });
      _childChangingAnDur.delay().then((value) {
        _behaviorAnCtrl.reverse();
        // .then((value) {
        //   if (onHideBar != null) onHideBar!();
        // });
      });
    });
  }

  final _childChangingAnDur = 400.milliseconds;

  @override
  Widget build(BuildContext context) {
    print('BUILD CONN SNACK BAR');
    print('build');
    return SizedBox(
      height: _behaviorAn.value,
      child: ColoredBox(
        color: CstColors.a,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: AnimatedSwitcher(
            switchInCurve: Curves.linearToEaseOut,
            switchOutCurve: !(_isOffline ?? true)
                ? Curves.linearToEaseOut
                : Curves.easeInToLinear,
            duration: _childChangingAnDur,
            child: Row(
              key: ValueKey(_isOffline),
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _isOffline == null
                  ? List.empty()
                  : [
                      SizedBox.square(
                        dimension: 30,
                        child: Icon(
                          _isOffline!
                              ? CupertinoIcons.wifi_exclamationmark
                              : CupertinoIcons.wifi,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      Text(
                        _isOffline! ? "you're offline!!" : "connection back!",
                        style: Get.textTheme.bodySmall!
                            .copyWith(color: Colors.white),
                      ),
                      SizedBox(width: 30),
                    ],
            ),
            transitionBuilder: (c, a) {
              // final scaleAnimation = a.isDismissed
              //     ? Tween<double>(
              //         begin: 0.8,
              //         end: 1,
              //       ).animate(a)
              //     : Tween<double>(
              //         begin: 1.2,
              //         end: 1,
              //       ).animate(a);
              final slideAnimation = a.isDismissed
                  ? Tween<Offset>(
                      begin: Offset(0, 0.15), //0.8
                      end: Offset.zero, //1
                    ).animate(a)
                  : Tween<Offset>(
                      begin: Offset(0, -0.15), //1.2
                      end: Offset.zero, //1
                    ).animate(a);
              return SlideTransition(
                position: slideAnimation,
                child: FadeTransition(
                  opacity: a,
                  child: c,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
  // print(key.toString());

  Animation<Offset> _getCurrentOffsetTween(key, Animation<double> a) {
    print(key.toString());
    if (key == ValueKey<bool?>(true) && a.isDismissed) {
      return Tween<Offset>(begin: Offset(0, 0.15), end: Offset.zero).animate(a);
    } else if (key == ValueKey<bool?>(true) && a.isCompleted) {
      return Tween<Offset>(begin: Offset.zero, end: Offset(0, -0.15))
          .animate(a);
    }

    if (key == ValueKey<bool?>(false) && a.isDismissed) {
      return Tween<Offset>(begin: Offset(0, 0.15), end: Offset.zero).animate(a);
    } else {
      return Tween<Offset>(begin: Offset.zero, end: Offset(0, -0.15))
          .animate(a);
    }
    // else if (key == ValueKey<bool?>(true) && a.isDismissed) {
    //   return Tween<Offset>(begin: Offset.zero, end: Offset(0, -0.15))
    //       .animate(a);
    // }

    // else if (key == ValueKey<bool?>(false)) {
    // print('aaaaaaaaaaaaaa');
    // }
    // return Tween<Offset>(begin: Offset.zero, end: Offset(0, -0.15)).animate(a);

    // if (key == ValueKey(false))
    // else if (key == ValueKey(false))
    // return Tween<Offset>(begin: Offset(0, -0.15), end: Offset.zero).animate(a);
  }
}
