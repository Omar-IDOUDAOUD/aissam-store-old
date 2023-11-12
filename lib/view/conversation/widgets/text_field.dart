// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MessageTextField extends StatelessWidget {
  const MessageTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.green,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: SizedBox(
          height: kToolbarHeight - 20,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
            ),
            child: Padding(
              padding: EdgeInsets.all(15),
              child: ColoredBox(
                color: Colors.red,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration.collapsed(
                          hintText: 'type here...',
                        ),
                      ),
                    ),
                    SvgPicture.asset(
                      'assets/icons/ic_fluent_add_24_filled.svg',
                      color: Colors.purpleAccent.shade700,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
