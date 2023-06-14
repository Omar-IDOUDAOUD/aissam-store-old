import 'package:aissam_store/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class NavBar extends StatefulWidget {
  NavBar({Key? key, required this.onPageChange}) : super(key: key);

  final Function(int index) onPageChange;

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int focusItem = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black54.withOpacity(.2),
            blurRadius: 30,
            offset: Offset(0, -2),
          )
        ],
      ),
      padding: EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          NavBarItem(
            focus: focusItem == 0,
            iconPath: 'assets/icons/home.svg',
            onTap: () {
              widget.onPageChange(0);
              setState(() {
                focusItem = 0;
              });
            },
          ),
          NavBarItem(
            focus: focusItem == 1,
            iconPath: 'assets/icons/star.svg',
            onTap: () {
              widget.onPageChange(1);
              setState(() {
                focusItem = 1;
              });
            },
          ),
          NavBarItem(
            focus: focusItem == 2,
            iconPath: 'assets/icons/search.svg',
            onTap: () {
              widget.onPageChange(2);
              setState(() {
                focusItem = 2;
              });
            },
          ),
          NavBarItem(
            focus: focusItem == 3,
            iconPath: 'assets/icons/box_alt.svg',
            onTap: () {
              widget.onPageChange(3);
              setState(() {
                focusItem = 3;
              });
            },
          ),
          NavBarItem(
            focus: focusItem == 4,
            iconPath: 'assets/icons/user.svg',
            onTap: () {
              widget.onPageChange(4);

              setState(() {
                focusItem = 4;
              });
            },
          ),
        ],
      ),
    );
  }
}

class NavBarItem extends StatefulWidget {
  const NavBarItem(
      {Key? key,
      required this.iconPath,
      required this.focus,
      required this.onTap})
      : super(key: key);
  final String iconPath;
  final bool focus;
  final Function() onTap;
  @override
  State<NavBarItem> createState() => _NavBarItemState();
}

class _NavBarItemState extends State<NavBarItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: widget.onTap,
          child: AnimatedPadding(
            curve: const Cubic(0.175, 0.885, 0.32, 2.7),
            duration: 350.milliseconds,
            padding: EdgeInsets.only(top: widget.focus ? 5 : 15),
            child: SvgPicture.asset(widget.iconPath),
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Expanded(
          child: AnimatedAlign(
            alignment: widget.focus ? Alignment.topCenter : Alignment(0, 2),
            duration: 200.milliseconds,
            child: Container(
              width: 5,
              height: 5,
              decoration:
                  BoxDecoration(color: CstColors.a, shape: BoxShape.circle),
            ),
          ),
        )
      ],
    );
  }
}
